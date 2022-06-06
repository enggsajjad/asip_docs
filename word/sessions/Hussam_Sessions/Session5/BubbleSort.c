#include "lib_uart.h"
#include "string.h"
#include "clockCounter.h"

#define SIZE 20

unsigned int array[SIZE] = { 45, 75, 342, 54, 7, 86, 92, 235, 4, 42, 99, 78, 63, 352, 21, 634, 6, 77, 346, 23 };


int printArray() {
  int i;
  int sorted=1;

  u_print("Array:");

  for (i=0; i<SIZE; i++) {
    if ( (i&0x7) == 0) u_print("\r\n");
    u_printInt(array[i]);
    u_print(" ");
    if (i>0) sorted &= array[i-1] <= array[i];
  }
  u_print("\r\n");

  return sorted;
}


void bubbleSort(const unsigned int startIndex, const unsigned int endIndex) {
  unsigned int *j, *next_j, *innerLoopEnd;
  unsigned int i, tmp, value_j, value_next_j;

  innerLoopEnd = array+endIndex;
  i = startIndex;
  while (i < endIndex) {
    j = array+startIndex;
    value_j = *j;
    next_j = j;

    while (j < innerLoopEnd) {
      next_j++;
      value_next_j = *next_j;
      if (value_next_j < value_j) {       
        *j = value_next_j;
        *next_j = value_j;
        tmp = value_j;
        value_j = value_next_j;
        value_next_j = tmp;
      }
      j = next_j;
      value_j = value_next_j;
    }
    innerLoopEnd--;
    i++;
  }

}

int main() {
  int time;
  int sorted;
  
  sorted = printArray();

  u_print("BubbleSort: sorting...\r\n");
  
  
  time = readClockCounter();  // one dummy reading, because sometimes there is a glitch on the first read
                              // (i.e. some of the upper 16 bits are mistakenly '1')
  time = readClockCounter();
  bubbleSort(0, SIZE-1);
  time = readClockCounter() - time;

  sorted = printArray();

  u_print("Array Sorted: ");
  if (sorted==0) u_print("NO!!   ERROR!!");
  else u_print("YES");
  u_print("\r\nNumber of cycles needed: ");
  u_printInt(time);
  u_print("\r\n");
  
  return 0;
}


