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
  unsigned int i, j, tmp;

  for (i=0; i<endIndex-startIndex; i++) {
    #ifndef COSY
      printArray();
      printf("Inner-loop will go from %u to %u.\n", startIndex, endIndex-i);
    #endif
    for (j=startIndex; j<endIndex-i; j++) {
      if (array[j+1]<array[j]) {
        #ifndef COSY
          printf("exchanging %u:%u with %u:%u\n", j, array[j], j+1, array[j+1]);
        #endif
        tmp=array[j];
        array[j]=array[j+1];
        array[j+1]=tmp;
      }
    }
  }

}

int main() {
  bubbleSort(0, SIZE-1);
  #ifndef COSY
    printArray();
  #endif
  return 0;
}

