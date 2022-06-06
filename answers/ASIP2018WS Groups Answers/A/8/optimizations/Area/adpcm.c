/***********************************************************
copyright 1992 by Stichting Mathematisch Centrum, Amsterdam, The
Netherlands.

                        All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the names of Stichting Mathematisch
Centrum or CWI not be used in advertising or publicity pertaining to
distribution of the software without specific, written prior permission.

STICHTING MATHEMATISCH CENTRUM DISCLAIMS ALL WARRANTIES WITH REGARD TO
THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS, IN NO EVENT SHALL STICHTING MATHEMATISCH CENTRUM BE LIABLE
FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

******************************************************************/

/*
** Intel/DVI ADPCM coder/decoder.
**
** The algorithm for this coder was taken from the IMA Compatability Project
** proceedings, Vol 2, Number 2; May 1992.
**
** Version 1.2, 18-Dec-92.
**
** Change log:
** - Fixed a stupid bug, where the delta was computed as
**   stepsize*code/4 in stead of stepsize*(code+0.5)/4.
** - There was an off-by-one error causing it to pick
**   an incorrect delta once in a blue moon.
** - The NODIVMUL define has been removed. Computations are now always done
**   using shifts, adds and subtracts. It turned out that, because the standard
**   is defined using shift/add/subtract, you needed bits of fixup code
**   (because the div/mul simulation using shift/add/sub made some rounding
**   errors that real div/mul don't make) and all together the resultant code
**   ran slower than just using the shifts all the time.
** - Changed some of the variable names to be more meaningful.
*/
#define ASIP
#ifndef ASIP
#  include <stdio.h>
#  define t_print printf
#  define t_printInt(VALUE) printf("%i", (VALUE))
#  define t_printHex(VALUE, LENGTH) printf("0x%." #LENGTH "X", (VALUE))
#else
#  include "lib_audio.h"
#  include "loadStoreByte.h"
#  include "lib_clock.h"
#  include "lib_lcd.h"
#endif


/* Intel ADPCM step variation table */
static int indexTable[16] = {
    -1, -1, -1, -1, 2, 4, 6, 8,
    -1, -1, -1, -1, 2, 4, 6, 8,
};

static int stepsizeTable[89] = {
    7, 8, 9, 10, 11, 12, 13, 14, 16, 17,
    19, 21, 23, 25, 28, 31, 34, 37, 41, 45,
    50, 55, 60, 66, 73, 80, 88, 97, 107, 118,
    130, 143, 157, 173, 190, 209, 230, 253, 279, 307,
    337, 371, 408, 449, 494, 544, 598, 658, 724, 796,
    876, 963, 1060, 1166, 1282, 1411, 1552, 1707, 1878, 2066,
    2272, 2499, 2749, 3024, 3327, 3660, 4026, 4428, 4871, 5358,
    5894, 6484, 7132, 7845, 8630, 9493, 10442, 11487, 12635, 13899,
    15289, 16818, 18500, 20350, 22385, 24623, 27086, 29794, 32767
};

/*
   PRINT_ARRAY defines the output destination for the decoded signal.
		=0 : Used for Hardware test! Output through audio.
		=1 : Used for Simulation! Output through the LCD instead of audio.
*/
#define PRINT_ARRAY 0


int adpcm_decoder(unsigned char* indata, int len) {
    int sign;			/* Current adpcm sign bit */
    int delta;			/* Current adpcm output value */
    int step;			/* Stepsize */
    int valpred = 0;		/* Predicted value */
    int vpdiff;			/* Current change to valpred */
    int index = 0;		/* Current step change index */
    int inputbuffer = 0;	/* place to keep next 4-bit value */
    int bufferstep = 0;		/* toggle between inputbuffer/input */
    int printCounter=0;
#if PRINT_ARRAY
    char* separator = "";

	t_print("unsigned short audioData[] = {\r\n");
#endif

    step = stepsizeTable[index];
    for ( ; len > 0 ; len-- ) {

	/* Step 1 - get the delta value */
	if ( bufferstep ) {
	    delta = inputbuffer & 0xf;
	} else {
	    inputbuffer = *indata++;
	    delta = (inputbuffer >> 4) & 0xf;
	}
	bufferstep = !bufferstep;

	/* Step 2 - Find new index value (for later) */
	index += indexTable[delta];
	if ( index < 0 ) index = 0;
	if ( index > 88 ) index = 88;

	/* Step 3 - Separate sign and magnitude */
	sign = delta & 8;
	delta = delta & 7;

	/* Step 4 - Compute difference and new predicted value */
	/*
	** Computes 'vpdiff = (delta+0.5)*step/4', but see comment
	** in adpcm_coder.
	*/
	vpdiff = step >> 3;
	if ( delta & 4 ) vpdiff += step;
	if ( delta & 2 ) vpdiff += step>>1;
	if ( delta & 1 ) vpdiff += step>>2;

	if ( sign )
	  valpred -= vpdiff;
	else
	  valpred += vpdiff;

	/* Step 5 - clamp output value */
	if ( valpred > 32767 )
	  valpred = 32767;
	else if ( valpred < -32768 )
	  valpred = -32768;

	/* Step 6 - Update step value */
	step = stepsizeTable[index];

	/* Step 7 - Output value */
	// The following value needs to be 0x8000 when running on FPGA and 0x0
	// when decoding back to a wave file playing on pc.
	// The reason is: on pc the audio data is moving between -2^15 and +2^15
	// (i.e. signed values, thus 0 is the middle) while on the FPGA they
	// move between 0 and 2^16 (i.e. 2^15 = 0x8000 is the middle).
#define signedUnsignedModification 0x8000
#if PRINT_ARRAY
	t_print(separator);
	t_printHex( (valpred+signedUnsignedModification) & 0xFFFF, 4);
	if (printCounter%10==9) separator=",\r\n";
	else separator=", ";
	printCounter++;
#else
	if (printCounter&1) 
	*audioAddressL = (valpred+signedUnsignedModification) & 0xFFFF;
	else  *audioAddressR =  (valpred+signedUnsignedModification) & 0xFFFF;
	printCounter++;
#endif
    }

#if PRINT_ARRAY
	t_print("};\r\n\n");
#endif

    return 0;
}

#include "adpcmData.h"

int main() {
  // 2 * numberOfArrayElements, because each sample is only 4 Bits
  int numberOfSamples = 2 * sizeof(adpcmData);
  int time;
  char tempString[32];

  //while (1) {      // Endlosschleife nur für FPGA. Für ModelSim/dlxsim, bitte deaktivieren!
    t_print("\r\nADPCM Decode: Start");

    time = *clockAddress;
    adpcm_decoder(adpcmData, numberOfSamples);
    time = *clockAddress - time;

    t_print("\r\nADPCM Decode: Decoding Done.");
    t_print("\r\nRequired time for decoding: ");
	intToStr(time, tempString);
	t_print(tempString);
    t_print(" cycles\r\n");
 //}
  return 0;
}
