.data
	userInput: .space 1001 #Reserve 1001 bytes for input
	ans: .space 4
	mistake: .asciiz "Not recognized"
	add: .word 0 #store the value of the users input
  
  .text
# N = 33, M = 23 which is W
	main:
		li $v0, 8 #Command to read a string
		la $a0, buffer #storing space for the string
		li $a1, 1001 #allocating byte space for string to be stored
		syscall #executing command
		
		

		

	
