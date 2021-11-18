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
		jal const              #jump to constants
		
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
		beq $a2,0,leave                   #check for a NULL value
		addi $t7,$t7,1                    #increment my iterator by 1
		addi $t4,$t4,1                    #increaseing the value of string length
		j count                           #loop
	leave: 
		jr $ra
	const:

		li $t0, 87                   # subtract 87 from my lowercse letters
		li $t1,55                    # subtract 55 from my upper case letters
		li $t2,48                    # subtract 48 from the value of my numbers
		li $t6, 0                    #string length.

		li $t8,33                    #base 33
	calcuate:

		li $t3,0

		addu $t3, $t3, $t7          #adds x to t3
		addu $t3, $t3, $a1          #t3 = a[x]
		lbu $a2, ($t3)              #load ascii value of $t3 to $a2

		bltz $t3,End                #If position x is less than 0
		ble $a2,32,choice         #If a2 <= 32 jump to choice
		beq $t6,4, OOR       #If $t6 is 4 then it is OOR.

		bgt $a2,119,OOR      #if a2 is larger than 119 it is not in my base system

		bge $a2,97, S_L   #if a2 is less than 119 and more than 97 go to S_L function

		bgt $a2,87, OOR
		bge $a2,65, S_U  #go to S_U

		bge $a2,57,OOR
		bge $a2,48,num  #If a2 is less than 57 and more than 48 jump to num.

		j OOR               #If a2 is less than 48 jump to OOR
		
	S_U:
		subu $a2,$a2,$t1      #subtract 55 to et the decimal value

	S_L:                  
		subu $a2,$a2,$t0 #subtract 87 to get the decimal value


	num:
		subu $a2,$a2,$t2       #subtract 48 to get decimal value
		
	DoMath:
		multu $a2,$t5           #Multiplying by 33 raised to my exponent.
		mflo $a2                    #Stores last math into a2

		addu $a0,$a0,$a2                #adds current summation to my final sum
		multu $t5,$t8                   #incrementing my exponent

		mflo $t5                        #stores last math into t3

		subu $t7,$t7,1                  #increment x
		addu $t6,$t6,1                  #increment length

		j calculate                     #starts at the beginning of calculate

	OOR:
		j Invalid       #Prints invalid
		
	choice:
		beq $t6, 4, End     # ends program
		j OOR                # jump to OOR

	End: 
		jr $ra
		
		

		

	
