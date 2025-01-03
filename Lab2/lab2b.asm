############################################################################
# 
#                       EC413
#
#    		Assembly Language Lab -- Programming with Loops.
#
############################################################################
#  DATA
############################################################################
        .data           # Data segment
myName:  .asciiz "Jackson Clary"  # declare a zero terminated string
AnInt:	.word	17      # a word initialized to 17
space:	.asciiz	" "	    # declare a zero terminate string
AnotherInt: .word 23	# another word, this time initialized to 23

newLine: .asciiz "\n"	# line break for my sake

WordAvg:   .word 0		#use this variable for part 4
ValidInt:  .word 0		#
ValidInt2: .word 0		#
lf:     .byte	10, 0	# string with carriage return and line feed
InLenW:	.word   4       # initialize to number of words in input1 and input2
InLenB:	.word   16      # initialize to number of bytes in input1 and input2
        .align  4       # pad to next 16 byte boundary (address % 16 == 0)
Input1_TAG: .ascii "Input1 starts on next line"
		.align	4
Input1:	.word	0x01020304,0x05060708
	    .word	0x090A0B0C,0x0D0E0F10
        .align  4
Input2_TAG: .ascii "Input2 starts on next line"
        .align  4
Input2: .word   0x01221117,0x090b1d1f   # input
        .word   0x0e1c2a08,0x06040210
        .align  4
Copy_TAG: .ascii "Copy starts on next line"
        .align  4
Copy:  	.space  128		        # space to copy input word by word
        .align  4
Input3_TAG: .ascii "Input3 starts on next line"
        .align  4
Input3:	.space	400		# space for data to be transposed

inLen3: .word 100		# length of Input3

Transpose_TAG: .ascii "Transpose starts on next line"
        .align  4
Transpose: .space 400	        # space for transposed data

inLenT: .word 100		# length of Transpose
 
############################################################################
#  CODE
############################################################################
        .text                   # code segment
#
# print out greeting.  
# Task 2:  change the message so that it prints out your name.
main:
        la	$a0,myName	    	# address of string to print
        li	$v0,4		    	# system call code for print_str
        syscall			    	# print the string
#
# Print the integer value of AnInt
# Task 3: modify the code so that it prints out two integers
# separated by a space.
		la	$a0, newLine		# new line
		li	$v0, 4		    	# new line
		syscall			    	# new line

		lw	$a0,AnInt	    	# load I/O register with value of AnInt
		li	$v0,1		    	# system call code for print_int
		syscall
# prints a space
		la $a0, space 			# loads address of "space" into $a0
		li $v0, 4		    	# loads syscall code for printing string
		syscall			    	# prints the string
# prints the second integer
		lw $a0, AnotherInt		# loads "AnotherInt" into $a0
		li $v0, 1		    	# system call code to print an integer
		syscall			    	# prints the integer


#
# Print the integer values of each byte in the array Input1
# Task 4a: modify the code so that it prints spaces between the integers

		la	$a0, newLine		# new line
		li	$v0, 4		    	# new line
		syscall				# new line

		la	$s0,Input1	    	# load pointer to array Input1
		lw	$s1,InLenB		# get length of array Input1 in bytes

task4:	
		ble	$s1,$zero,done4		# test if done
		lb	$a0,($s0)	    	# load next byte into I/O register
		li	$v0,1		    	# specify print integer
		syscall			    	# print the integer

# print a space after each int
		
		la $a0, space			# loads address of "space" into $a0
		li $v0, 4		    	# system call code to print an string
		syscall			    	# prints the space

		add	$s0,$s0,1	    	# point to next byte
		sub	$s1,$s1,1   		# decrement index variable
		j	task4		    	# do it again
done4:
#
# Task 4b: copy the Task 4 code and paste here.  Modify the code to print
# the array backwards.

		la	$a0, newLine		# new line
		li	$v0, 4		    	# new line
		syscall			    	# new line

		la $s0, Input1			# set the pointer to Input1 array
		lw $s1, InLenB			# gets the length of Input1
		add $s0, $s0, $s1		# move pointer the the end of the array
		sub $s0, $s0, 1			# InLenB - 1, sets moves pointer to last byte
task4b:	
		ble	$s1,$zero,done4b	# test if done
		lb	$a0,($s0)	    	# load next byte into I/O register
		li	$v0,1		    	# specify print integer
		syscall			    	# print the integer

# print a space after each int
		
		la	$a0, space	    	# loads address of "space" into $a0
		li	$v0, 4		    	# system call code to print an string
		syscall			    	# prints the space

		sub	$s0,$s0,1	    	# point to next byte (previous byte though now)
		sub	$s1,$s1,1	    	# decrement index variable
		j	task4b		    	# do it again

done4b:
#
# Code for Task 5 -- copy the contents of Input2 to Copy
		la	$s0,Input2	    	# load pointer to array Input2
		la	$s1,Copy	    	# load pointer to array Copy
		lw	$s2,InLenB	    	# get length of array Input2 in bytes
task5:
		ble	$s2,$zero,done5		# test if done
		lb	$t0,($s0)	    	# get the next byte
		sb	$t0,($s1)	    	# put the byte
		add	$s0,$s0,1	    	# increment input pointer
		add	$s1,$s1,1	    	# increment output point
		sub	$s2,$s2,1	    	# decrement index variable
		j	task5		    	# continue
done5:
#
# Task 5:  copy the Task 5 code and paste here.  Modify the code to copy
# the data in words rather than bytes.

		la	$a0, newLine		# new line
		li	$v0, 4		    	# new line
		syscall			    	# new line

		la	$s0,Input2	    	# load pointer to array Input2
		la	$s1,Copy	    	# load pointer to array Copy
		lw	$s2,InLenB	    	# get length of array Input2 in bytes
		srl	$s2, $s2, 2	    	# divide by 4 to get number of words

task5b:
		ble	$s2,$zero,done5b	# test if done
		lw	$t0,($s0)	    	# get the next byte
		sw	$t0,($s1)	    	# put the byte
		add	$s0,$s0,4	    	# increment input pointer
		add	$s1,$s1,4	    	# increment output point
		sub	$s2,$s2,4	    	# decrement index variable
		j	task5b			# continue
done5b:
#
# Code for Task 6 -- 
# Print the integer average of the contents of array Input2 (bytes)

		# la	$a0, newLine	# new line
		# li	$v0, 4			# new line
		# syscall			# print new line

task6:
		li	$t0, 0			# set sum to 0
		la	$t1, Input2	    	# pointer to Input2 array
		lw	$t2, InLenB 		# load length of Input2
		move	$t3, $t2		# copy length of $t1 to be our loop counter

# loop to sum everything
sumLoop:
		ble	$t3, $zero, getAverage	# breaks the loop if done
		lb	$t4, ($t1)	    	# load the next byte
		add	$t0, $t0, $t4		# add the currently pointed to byte to the sum
		add	$t1, $t1, 1	    	# move pointer over 1
		sub	$t3, $t3, 1	    	# decrement by 1
		j	sumLoop		    	# repeat loop until $s1 = 0

# calculate the average
getAverage:
		div	$t0, $t0, $t2		# divides the sum $t0 by the length $t1
		move	$a0, $t0		# moves quotient into $a0
		li	$v0, 1		    	# system call code to print an integer
		syscall		    		# print
done6:
#
# Code for Task 7 --  
# Print the first 25 integers that are divisible by 7 (with spaces)

		la $a0, newLine			# new line
		li $v0, 4	    		# new line
		syscall	    			# new line

task7:
# initialize registers
		li	$t0, 0		    	# current number being checked
		li	$t1, 0	    		# keep track of how many numbers divisible by 7
		li	$t2, 25		    	# target amount of numbers

checkIfDivisible:
		beq	$t1, $t2, done7		# break if numbers checked = 25
		
		li	$t3, 7		    	# load 7 into $t3
		rem	$t4, $t0, $t3		# gets the remainder of current number / 7
		bnez	$t4, nextNumber		# move on to next number if remainder isn't 0

# if we've gotten this far, it's divisible by 7, so print
		move	$a0, $t0		# copy $t0 to $a0 to print
		li	$v0, 1		    	# print yadayaya
		syscall		    		# print

# print space after
		la	$a0, space	    	# address of "space" string
		li	$v0, 4		    	# system call to print an integer
		syscall		    		# print

# increment counter
		addi	$t1, $t1, 1		# increase number of numbers checked by 1

# move on to the next number to check
nextNumber:
		addi	$t0, $t0, 1		# increase $t0 by 1
		j	checkIfDivisible	# repeat loop 
		
done7:
#
# The following code initializes Input3 for Task9
		la	$s0,Input3		# load pointer to Input3
		li	$s1,100			# load size of array in bytes
		li	$t0,3		    	# start with 3
init8a:
		ble	$s1,$zero, done8a	# test if done
		sb	$t0,($s0)		# write out another byte
		add	$s0,$s0,1		# point to next byte
		sub	$s1,$s1,1	    	# decrement index variable
		add	$t0,$t0,1		# increase value by 1
		j 	init8a			# continue
done8a:
#
# Code for Task 9 --
# Transpose the 10x10 byte array in Input3 into Transpose

taskExtraCredit:
		li	$t0, 0		    	# row counter i
		li	$t1, 0		    	# column counter j
		la	$s0, Input3	    	# pointer to Input3
		la	$s1, Transpose		# pointer to Transpose

outerLoop:
		li	$t1, 0		    	# resets column counter j to 0 or each row

innerLoop:
# for Input3
		mul	$t2, $t0, 10		# starting position in row i (cuz 10x10 array)
		add	$t2, $t2, $t1		# starting position in column j

# load bytes from Input3[i,j]
		add	$t3, $s0, $t2		# $t3 = address of Input3[i,j]
		lb	$t4, ($t3)		# load byte at the address of $t3 into $t4


# for Transpose
		mul	$t5, $t1, 10		# starting position for row j (Transpose)
		add	$t5, $t5, $t0		# starting position for column i (Transpose)

# store bytes to Transpose[j,i]
		add	$t6, $s1, $t5		# $t6 = address of Transpose[j,i]
		sb	$t4, ($t6)		# stores the bytes at Transpose[j,i]


# increment column counter j
		addi	$t1, $t1, 1		# increment column counter j by 1
		li	$t7, 10	    		# limit of inner counter
		blt	$t1, $t7, innerLoop	# break when j = 10

# increment row counter i
		addi	$t0, $t0, 1		# increment row counter i by 1
		li	$t7, 10		    	# set limit again
		blt	$t0, $t7, outerLoop	# repeat the outer loop until i = 10
doneExtraCredit:

# print for Extra Credit
# two spaces for readability

		la	$a0, newLine		# new line
		li	$v0, 4		    	# new line
		syscall				# new line

		la	$a0, newLine		# new line
		li	$v0, 4		    	# new line
		syscall				# new line

# printer for Input3
		la	$s0, Input3	    	# load pointer to array Input3
		lw	$s1, inLen3		# length of Input3

printIn3:	
		ble	$s1,$zero, donePrint3	# test if done
		lb	$a0,($s0)	    	# load next byte into I/O register
		li	$v0,1		    	# specify print integer
		syscall			    	# print the integer

# print a space after each int
		
		la $a0, space			# loads address of "space" into $a0
		li $v0, 4		    	# system call code to print an string
		syscall			    	# prints the space

		add	$s0,$s0,1	    	# point to next byte
		sub	$s1,$s1,1   		# decrement index variable
		j	printIn3		# do it again
donePrint3:

# two spaces for readability
		la	$a0, newLine		# new line
		li	$v0, 4		    	# new line
		syscall				# new line

		la	$a0, newLine		# new line
		li	$v0, 4		    	# new line
		syscall				# new line

# printer for Transpose
		la $s0, Input3			# set the pointer to Transpose array
		lw $s1, inLen3			# gets the length of Transpose
		add $s0, $s0, $s1		#
		sub $s0, $s0, 1			#
printT:	
		ble	$s1,$zero, donePrintT	# test if done
		lb	$a0,($s0)	    	# load next byte into I/O register
		li	$v0,1		    	# specify print integer
		syscall			    	# print the integer

# print a space after each int
		
		la	$a0, space	    	# loads address of "space" into $a0
		li	$v0, 4		    	# system call code to print an string
		syscall			    	# prints the space

		sub	$s0,$s0,1	    	# point to next byte (previous byte though now)
		sub	$s1,$s1,1	    	# decrement index variable
		j	printT		    	# do it again
donePrintT:

# ALL DONE!
Exit:
jr $ra


