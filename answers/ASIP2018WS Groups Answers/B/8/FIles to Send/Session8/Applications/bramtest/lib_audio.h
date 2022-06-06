
#define AUDIO_R_ADDR 40000004 
#define AUDIO_L_ADDR 40000008



volatile int* const audioAddressR = (int*)AUDIO_R_ADDR;
volatile int* const audioAddressL = (int*)AUDIO_L_ADDR;
