#ifndef  _lib_lcd_h_wercghewqzeuioghwk8ezscguildhaxe
#define  _lib_lcd_h_wercghewqzeuioghwk8ezscguildhaxe

#define LCD_ADDR 0x2000000
//#define LCD_I2C_ADDR 111
#define LCD_I2C_ADDR 0xDE	//222

int t_printInt(int a);

// with 'digits' you can force each value to be printed as n-digit hex number.
// '0' digits mean: print just as many as required
int t_printHex(int value, int digits);

int checkbuffer();

// read specified amount of data from display, returns amount of bytes read
int getbytes(char* dest, int bytes_to_read);

/* ------------------------
   Send individual commands
   ------------------------ */

int sendcommand (const char cmd0, const char cmd1, const int options[], const char text[], int intcount, int charcount, int address);

/* --------------------------------------
   Convenience functions in Terminal Mode
   -------------------------------------- */

// print text at current cursor position
int t_print (const char* str);

int t_cursor (int onoff);

int t_enable (int onoff);

int t_saveCursorPosition();

int t_restoreLastSavedCursorPosition();

/* -------------------------------------
   Convenience functions in Graphic Mode
   ------------------------------------- */

int g_print (const char* str, int x, int y);

int g_drawrect (int x1, int y1, int x2, int y2);

int g_drawline (int x1, int y1, int x2, int y2);

int g_makebar (int x1, int y1, int x2, int y2, int low_val, int high_val, int init_val,  int type, int fill_type, int touch);

int g_setbar (int barnum, int value);

int g_makeswitch (const char* str, int x1, int y1, int x2, int y2, int down, int up);

int g_makemenubutton (const char* str, int x1, int y1, int x2, int y2, int down, int up, int select, int space);

int g_makeradiogroup(int group_number);


/* ----------------
   Display Commands
   ---------------- */

int d_clear();


#endif
