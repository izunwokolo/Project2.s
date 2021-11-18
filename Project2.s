.data
	userInput: .space 1001 #Reserve 1001 bytes for input
	ans: .space 4
	mistake: .asciiz "Not recognized"
	add: .word 0 #store the value of the users input
  
  .text
# N = 33, M = 23 which is W
	main:
		li $v0, 8 #Command to read a string
		la $a0, userInput #storing space for the string
		li $a1, 1001 #allocating byte space for string to be stored
		syscall #executing command
		
		addi $t7,$t7,0      #initialize counter
		addi $t6,$t6,1      #1: continues looping
		addi $t5,$t5,1      #exponent of base 33
		addi $t4,$t4,0      #length string
		
		#remove Spaces

		jal string_len #First I'll need to figure out the lenght of my string.
		li $t7,0            #setting my counter to 0
		subu $t7,$t4,1
		
	Spaces:
		li $t3, 0
		addu $t3,$t3,$t7                           #$t0 = x
		addu $t3,$t3,$a1                           #$t0 = $a1 at position x
		lbu $a2,0($t3)                             #load $t0 to $a2
		bgt $a2,32,end_Spaces                      #if a2 is greater than 32, jump to end_space
		subu $t7,$t7,1                             #decrement by 1
		j Spaces                              #starts the loop 
		
	end_Spaces:   
		jal constants                #jump to constants
		
		li $a2,0                #resetting my temp register
		addu $a2,$a2,$a0        #Putting my sum into a2

		li $v0,4
		li $a0,0
		la $a0, ans        #print output
		syscall                 
	error:

		li $v0,4                        #print string
		li $a0,0                        #a0 = 0
		la $a0, ans                #loads answer
		syscall                         #executes

		li $v0,4
		li $a0,0
		la $a0, mistake                #Loads mistake 
		syscall

		li $v0, 10
		syscall                         #terminates Program

	string_len:
		li $t4,0                          #setting the intital value of my string's length to 0 string length
		
	count: 
		li $t3,0
		addu $t3,$t3,$t7                  #my iterator
		addu $t3,$t3,$a1                  # position in my string
		lbu $a2,($t3)                     #loads position to $a2
		beq $a2,0,exit                    #check for a NULL value
		addi $t7,$t7,1                    #increment my iterator by 1
		addi $t4,$t4,1                    #increaseing the value of my string length
		j count                           #restarts my count loop
	exit: 
		jr $ra

		
		

		

	
