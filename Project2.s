.data
	userInput: .space 1001 #Reserve 1001 bytes for input
	ans: .space 4
	mistake: .asciiz "Not recognized"
	add: .word 0 #store the value of the users input
  
  .text
# N = 33, M = 23 which is W
	main:
		li $v0, 4   #Command to print a string
		la $a0, userInput   #Loading the string into the argument to enable printing
		syscall #executing command

		

	
