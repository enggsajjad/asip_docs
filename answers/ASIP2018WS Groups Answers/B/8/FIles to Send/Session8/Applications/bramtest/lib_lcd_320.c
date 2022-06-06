#include "lib_lcd.h"
#include "string.h"
#include "loadStoreByte.h"

 //volatile int* const lcdAddress = (int*)LCD_ADDR;
/* ------------------------
   some stuff to help ...
   ------------------------ */

// burn some CPU cycles
int wait (const int waitvalue) {
  int count = 0;
  while (count++ != waitvalue);

  return --count;
}


// read acknowledge from display
int getack (int address) {
  int value;
  //int adr = address;
  volatile int* const lcdAddress = (int*) LCD_ADDR;

   //Read Command from I2C
  *lcdAddress = 0;     				//1. first field doesnot matter for read
  *lcdAddress = ++address;			//2. Second field: address + R=1
  *lcdAddress = 1;     				//3. first field: number of bytes to read
  value = *lcdAddress;

  if (value == 15) return 1;
  else return 0;
}

int checkbuffer () {
  int value = 0;
  int checksum;
  int length = 0;
  int bytes_ready = 0;
  int bytes_free = 0;
  int bcc = 0;
  //const adr = LCD_I2C_ADDR << 1 ;
  const adr = LCD_I2C_ADDR;
  volatile int* const lcdAddress = (int*)LCD_ADDR;

  // Write to I2C command
  *lcdAddress = 4;			//1. Length
  *lcdAddress = adr;			//2. address
  *lcdAddress = 18; 			//3.1 Data DC2
  *lcdAddress = 1;
  *lcdAddress = 73; 			// I
  *lcdAddress = 92;		//BCC=18+1+73=

  checksum = -1;
  while (checksum == -1) {
    // fetch buffer information, i2c read command
    *lcdAddress = 0;			//1. Lenght doesnot matter
    *lcdAddress = adr + 1;		//2. address
    *lcdAddress = 6;			//3. bytes to read

    value = *lcdAddress;  		// ACK
    value = *lcdAddress;  		// DC2
    checksum = value;
    length = *lcdAddress; 		// length
    checksum += length;
    bytes_ready = *lcdAddress;   	// data
    checksum += bytes_ready;
    bytes_free = *lcdAddress;   	// data
    checksum += bytes_free;
    bcc = *lcdAddress;   		// bcc

    // check for transmission errors (SmallProtokoll)
    checksum = checksum % 256;
    if (checksum != bcc) {
      checksum = -1;  // loop runs again

      // rerequest last data package
      *lcdAddress = 4;
      *lcdAddress = adr;
      *lcdAddress = 18; 	// DC2
      *lcdAddress = 1;
      *lcdAddress = 82; 	// R
      *lcdAddress = 101;	//18+1+82=101
    }
  }

  return bytes_ready;
}

// read specified amount of data from display, returns amount of bytes read
int getbytes (char* dest, int bytes_to_read) {
  int bytes_read = 0;
  int value;
  int checksum;
  int length = 0;
  int bcc = 0;
//  const adr = LCD_I2C_ADDR << 1 ;
  const adr = LCD_I2C_ADDR;
  volatile int* const lcdAddress = (int*)LCD_ADDR;

  // send command
  *lcdAddress = 4;
  *lcdAddress = adr;
  *lcdAddress = 18; 	// DC2
  *lcdAddress = 1;
  *lcdAddress = 83; 	// S
  *lcdAddress = 102;	//Checksum 18+1+83

  checksum = -1;
  while (checksum == -1) {
    // fetch buffer data
    *lcdAddress = 0;
    *lcdAddress = adr + 1;
    *lcdAddress = bytes_to_read + 4;

    value = *lcdAddress;  	// ACK
    // todo : check if ACK was ok
    value = *lcdAddress;   	// DC1
    checksum = value;
    // todo : check if length is equal bytes_to_read
    length = *lcdAddress;  	// length
    checksum += length;
    while (bytes_read != bytes_to_read) {
      value = *lcdAddress;
      storeByte(dest + bytes_read, value);
      bytes_read++;
      checksum += value;
    }
    bcc = *lcdAddress;    	// bcc

    // check for transmission errors (SmallProtokoll)
    checksum = checksum & 0xFF;
    if (checksum != bcc) {
      checksum = -1;  // loop runs again
      // rerequest last data package
      *lcdAddress = 4;
      *lcdAddress = adr;
      *lcdAddress = 18; 	// DC2
      *lcdAddress = 1;
      *lcdAddress = 82; 	// R
      *lcdAddress = 101; 	//checksum 18+1+82
    }
  }

  return bytes_read;
}

/* ------------------------
   Send individual commands
   ------------------------ */

int sendcommand (const char cmd0, const char cmd1, const int options[], const char text[], int intcount, int charcount, int address) {

  int checksum, value;
  //int* options_ptr = (int*) options;
  //char* text_ptr = (char* ) text;
  int* options_ptr;
  char* text_ptr;
  int intcount_local;
  int charcount_local;
  volatile int* const lcdAddress = (int*)LCD_ADDR;

  // amount of control char characters is 6
  // DC1, LEN, ESC, CMD0, CMD1, BCC

  //address <<= 1;

  do {

    options_ptr = (int*) options;
    text_ptr = (char* ) text;
    intcount_local = intcount;
    charcount_local = charcount;

    //Writing to I2C							// 1. First Field: Length
    *lcdAddress = intcount + charcount + 6;
    *lcdAddress = address;					        // 2. Second Field: Address to where to write
    *lcdAddress = 17;    // DC1						// 3.1 Third Field: I2C User Data       DC1

    *lcdAddress = intcount + charcount + 3;				// 3.2 Third Field: I2C User Data       LEN=count of user data without DC1 and without BCC

    // now we put special code characters here
    *lcdAddress = 27;							// 3.3 Third Field: I2C User Data       ESC
    *lcdAddress = cmd0;							// 3.4 Third Field: I2C User Data       CMD0
    *lcdAddress = cmd1;							// 3.5 Third Field: I2C User Data       CMD1

    checksum = 17 + (intcount + charcount + 3) + 27 + cmd0 + cmd1;

    while (intcount_local-- != 0) {					// 3.6 Third Field: I2C User Data       CMD parameters
      value = *options_ptr++;
	*lcdAddress = value;
      checksum += value;
    }

    //while (*text_ptr != '\0') {
    while (charcount_local-- != 0) {					// 3.7 Third Field: I2C User Data       Text
         value = *text_ptr++;
	 *lcdAddress = value;
         checksum += value;
    }

    *lcdAddress = checksum  % 256;					// 3.6 Third Field: I2C User Data       BCC= sum of all bytes including DC1 and LEN modulo 256
    //wait(8000); 
    wait(10000); 
}
  while (getack(address) != 0);
wait(10000);
  return 0;
}

/* -------------------------------------
   Convenience functions in Graphic Mode
   ------------------------------------- */

int g_print (const char* str, int x, int y) {
  int args[4];

  args[0] = x;
  args[1] = x >> 8;
  args[2] = y;
  args[3] = y >> 8;

  sendcommand('Z', 'L', args, str, 4, strlen(str) + 1, LCD_I2C_ADDR); // print hellow graphically
  //wait(10000);
  return 0;
}

int g_drawrect (int x1, int y1, int x2, int y2) {
  int args[8];

  args[0] = x1;
  args[1] = x1 >> 8;
  args[2] = y1;
  args[3] = y1 >> 8;
  args[4] = x2;
  args[5] = x2 >> 8;
  args[6] = y2;
  args[7] = y2 >> 8;

  sendcommand('G', 'R', args, 0, 8, 0, LCD_I2C_ADDR); // draw a rectangle

  return 0;
}

int g_drawline (int x1, int y1, int x2, int y2) {
  int args[8];

  args[0] = x1;
  args[1] = x1 >> 8;
  args[2] = y1;
  args[3] = y1 >> 8;
  args[4] = x2;
  args[5] = x2 >> 8;
  args[6] = y2;
  args[7] = y2 >> 8;
  
  sendcommand('G', 'D', args, 0, 8, 0, LCD_I2C_ADDR); // draw a line

  return 0;
}

int g_makebar (int x1, int y1, int x2, int y2, int low_val, int high_val, int init_val,  int type, int fill_type, int touch) {
  static int barcounter = 1;
  int args[13];

  if (barcounter < 32) {
    args[0] = barcounter;  // select internal number for bar
    args[1] = x1;
	args[2] = x1 >> 8;
    args[3] = y1;
	args[4] = y1 >> 8;
    args[5] = x2;
	args[6] = x2 >> 8;
    args[7] = y2;
	args[8] = y2 >> 8;
    args[9] = low_val;       // low value of bar
    args[10] = high_val;      // high value of bar
    args[11] = type;          // type of bar (filled, line ...)
    args[12] = fill_type;     // look of bar (line-breadth ...)

    sendcommand('B', 'R', args, 0, 13, 0, LCD_I2C_ADDR); // draw bargraph

    // problematic !! seems to lead to incomplete data packages beeing sent
    /*
     args[0] = 2;
     sendcommand('A', 'Q', args, 0, 1, 0, LCD_I2C_ADDR); // bargraph does write to buffer immediately when changed
    */

    if (touch != 0) {
      args[0] = barcounter;
      sendcommand('A', 'B', args, 0, 1, 0, LCD_I2C_ADDR); // bargraph is touch
    }

    args[0] = barcounter++;
    args[1] = init_val;
    sendcommand('B', 'A', args, 0, 2, 0, LCD_I2C_ADDR); // bargraph is set to 50

    return barcounter - 1;
  }
  else return -1;
}

int g_setbar (int barnum, int value) {
  int args[2];

  args[0] = barnum;
  args[1] = value;
  sendcommand('B', 'A', args, 0, 2, 0, LCD_I2C_ADDR); // bargraph is set to 50

  return 0;
}


int g_makeswitch (const char* str, int x1, int y1, int x2, int y2, int down, int up) {
  int args[10];

  args[0] = x1;
  args[1] = x1 >> 8;
  args[2] = y1;
  args[3] = y1 >> 8;
  args[4] = x2;
  args[5] = x2 >> 8;
  args[6] = y2;
  args[7] = y2 >> 8;
  args[8] = down;
  args[9] = up;
  sendcommand('A', 'K', args, str, 10, strlen(str) + 1 , LCD_I2C_ADDR); // define touch switch

  return 0;
}

int g_makemenubutton (const char* str, int x1, int y1, int x2, int y2, int down, int up, int select, int space) {
  int args[11];

  args[0] = x1;
  args[1] = x1 >> 8;
  args[2] = y1;
  args[3] = y1 >> 8;
  args[4] = x2;
  args[5] = x2 >> 8;
  args[6] = y2;
  args[7] = y2 >> 8;
  args[8] = down;
  args[9] = up;
  args[10] = select;
  sendcommand('A', 'M', args, str, 11, strlen(str) + 1, LCD_I2C_ADDR); // define menubutton

  if (space > 0) {
    sendcommand('N', 'Y', &space, 0, 1, 0, 111);
  }

  return 0;
}

int g_makeradiogroup(int group_number) {
  sendcommand('A', 'R', &group_number, 0, 1, 0, LCD_I2C_ADDR); // define radiogroup

  return 0;
}


/* --------------------------------------
   Convenience functions in Terminal Mode
   -------------------------------------- */

// print text at current cursor position
int t_print (const char* str) {
  sendcommand('Z', 'T', 0, str, 0, strlen(str), LCD_I2C_ADDR);
  wait (8000);
  return 0;
}

int t_printInt(int a) {
  char tempString[20];
  intToStr(a, tempString);
  t_print(tempString);
  return 0;
}

int t_printHex(int value, int digits) {
  char tempString[10];
  intToHexStr(value, tempString, digits);
  t_print("0x");
  t_print(tempString);
  return 0;
}

int t_cursor (int onoff) {
  sendcommand('T', 'C', &onoff, 0, 1, 0, LCD_I2C_ADDR);

  return 0;
}

int t_enable (int onoff) {
  if (onoff) sendcommand('T', 'E', 0, 0, 0, 0, LCD_I2C_ADDR);
  else sendcommand('T', 'A', 0, 0, 0, 0, LCD_I2C_ADDR);

  return 0;
}

int t_saveCursorPosition() {
  sendcommand('T', 'S', 0, 0, 0, 0, LCD_I2C_ADDR);
  return 0;
}

int t_restoreLastSavedCursorPosition() {
  sendcommand('T', 'R', 0, 0, 0, 0, LCD_I2C_ADDR);
  return 0;
}


/* -----------------
   Readback Commands
   ----------------- */

/*
  int c_readbar (int barnum) {
    int args[1];
    int check = 0;

    args[0] = barnum;
    sendcommand('B', 'S', args, 0, 1, 0, LCD_I2C_ADDR); // read bargraph value
    wait (8000);

    do check = checkbuffer();
    while(check == 0);

    return check;
  }

  int c_readswitch (int switchnum) {
    int args[1];
    int check = 0;

    args[0] = switchnum;
    sendcommand('A', 'X', args, 0, 1, 0, LCD_I2C_ADDR); // read switch value
    wait (8000);

    do check = checkbuffer();
    while(check == 0);

    return check;
  }
*/


/* ----------------
   Display Commands
   ---------------- */

int d_clear() {
  sendcommand('D', 'L', 0, 0, 0, 0, LCD_I2C_ADDR);  // clear display
  wait (2500000);

  return 0;
}
