#ifndef COSY
#  include <stdio.h>
#endif

#define SIZE 20

unsigned int array[SIZE] = { 45, 75, 342, 54, 7, 86, 92, 235, 4, 42, 99, 78, 63, 352, 21, 634, 6, 77, 346, 23 };

#ifndef COSY
void printArray() {
  unsigned int i;
  printf("\nArray: ");
  for (i=0; i<SIZE; i++)
    printf("%u  ", array[i]);
  printf("\n");
}
#endif

void bubbleSort(const unsigned int startIndex, const unsigned int endIndex) {
  unsigned int *j, *next_j, *innerLoopEnd;
  unsigned int i, tmp, value_j, value_next_j;

  innerLoopEnd = array+endIndex;
  i = startIndex;
  while (i < endIndex) {
    #ifndef COSY
      printArray();
      printf("Inner-loop will go from %u to %u.\n", startIndex, endIndex-i);
    #endif

    j = array+startIndex;
    value_j = *j;
    next_j = j;

    while (j < innerLoopEnd) {
      next_j++;
      value_next_j = *next_j;
      if (value_next_j < value_j) {
        #ifndef COSY
          printf("exchanging %u:%u with %u:%u\n", j-array, value_j, next_j-array, value_next_j);
        #endif
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
  bubbleSort(0, SIZE-1);
  #ifndef COSY
    printArray();
  #endif
  return 0;
}

