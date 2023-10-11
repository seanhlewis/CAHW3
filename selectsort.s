# Author: Sean Lewis
# Class: COSE222 Computer Architecture
# Taught by: Prof. Taeweon Suh
# Date: 2023-10-11

#Initial code (given)
.data
.align 4
Input_data:  .word 2, 0, -7, -1, 3, 8, -4, 10
             .word -9, -16, 15, 13, 1, 4, -3, 14
             .word -8, -10, -15, 6, -13, -5, 9, 12
             .word -11, -14, -6, 11, 5, 7, -2, -12
Output_data: .word 0, 0, 0, 0, 0, 0, 0, 0
             .word 0, 0, 0, 0, 0, 0, 0, 0
             .word 0, 0, 0, 0, 0, 0, 0, 0
             .word 0, 0, 0, 0, 0, 0, 0, 0

.text #read only section w/ executable code
.globl __start #setting __start to be global entry point for program
__start:  #starting point of program execution
  la a0, Input_data  #loading address of Input_data into a0
  la a1, Output_data #loading address of Output_data into a1
  li t0, 32          #initializing array size counter to 32

#copying data from Input_data to Output_data
copy_array:
  lw t1, 0(a0)  #loading word from a0 into t1
  sw t1, 0(a1)  #storing word from t1 into a1
  addi a0, a0, 4  #incrementing address of Input_data by 4
  addi a1, a1, 4  #incrementing address of Output_data by 4
  addi t0, t0, -1 #decrementing the counter by 1
  bnez t0, copy_array  #looping if counter is not zero

  la a0, Output_data  #loading address of Output_data into a0
  li t0, 128          #resetting array size counter to 128 (4*32)

#selection sort - descending
outer_loop:
  mv t1, a0  #initializing t1 as address of current element
  mv t2, a0  #initializing t2 as address of current element
  
  li t3, 4   #resetting innerlooping counter to 4 (to start comparing from second element)
inner_loop:
  add a1, a0, t3  #calculating address of next element
  lw t4, 0(a1)    #loading next element into t4
  lw t5, 0(t2)    #loading current minimum into t5

  blt t4, t5, new_min  #if next element is less than current min, jump to new_min

  j cont  #continue to next iteration
  
new_min:
  mv t2, a1  #updating address of current minimum element

cont:
  addi t3, t3, 4  #incrementing to address of next element by 4
  blt t3, t0, inner_loop  #looping if counter is less than array size
  
  #swapping current element with minimum element
  lw t4, 0(a0)  #loading current element into t4
  lw t5, 0(t2)  #loading minimum element into t5
  
  sw t5, 0(a0)  #storing minimum element at current position
  sw t4, 0(t2)  #storing original element at min position
  
  addi a0, a0, 4  #moving to next element in array (4 byte elements)
  addi t0, t0, -4 #updating array size for outerlooping by decrementing by 4
  
  bnez t0, outer_loop  #looping if counter is not zero

