unsigned int array[10] = { 0x22, 0x12,0,0,0,0,0,0,0};
int main() {

  __asm__ volatile (
                "avg %[my_out], %[my_op1], %[my_op2]\n"
                : [my_out] "=&r" (array[3])
                : [my_op1] "r" (array[0]),[my_op2] "r" (array[1])
        );


  __asm__ volatile (
                "minmax %[my_out1], %[my_out2], %[my_op1], %[my_op2]\n\t"
                : [my_out1] "=&r" (array[4]), [my_out2] "=&r" (array[5])
                : [my_op1] "r" (array[0]), [my_op2] "r" (array[1])
        );


  return 0;
}




