#define SIZE 20
int array[SIZE] = { 45, 75, 342, 54, 7, 86, 92, 235, 4, 42, 99, 78, 63, 352, 21, 634, 6, 77, 346, 23 };

void bubbleSort(const unsigned int startIndex, const unsigned int endIndex) {
  unsigned int *j, *next_j, *innerLoopEnd;
  unsigned int i, tmp, value_j, value_next_j;

  innerLoopEnd = array+endIndex - 1;
  i = startIndex;
  while (i < endIndex) {

    j = array+startIndex;
    value_j = *j;
    next_j = j;

    while (j < innerLoopEnd) {

      value_j = __builtin_brownie32_SWAPGTE(value_j, (unsigned int)j);
  /*__asm__ volatile (
                "SWAPGTE %[my_out], %[my_op1], %[my_op2]\n"
                : [my_out] "=&r" (value_j)
                : [my_op1] "r" (value_j),[my_op2] "r" (j)
        );
*/

      j++;
    }
    innerLoopEnd--;
    i++;
  }
  array[SIZE] = value_j;

}

int main() {
  bubbleSort(0, SIZE-1);
  return 0;
}
