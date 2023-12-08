# Euclid's algorithm 

.data
	# Integer inputs
	a_value: .asciiz "Enter the value of 'a': "
	b_value: .asciiz "Enter the value of 'b': "
	
	# Module
	result: .asciiz "\nThe module is: \n"
	
	# Ending the program
	final_message: .asciiz "'a' is negative."
	
.text
	# Receiving the first value
	li $v0, 4 # Print the string
	la $a0, a_value # Indicate the address of a_value
	syscall # Execute
	
	li $v0, 5 # Read 'a'
	syscall 
	
	move $t0, $v0 # 'a' will be at t0
	
	# Receiving the second value
	li $v0, 4 
	la $a0, b_value 
	syscall
	
	li $v0, 5 # Read 'b'
	syscall 
	
	move $t1, $v0 # 'b' will stored be at t1
	
	bgez $t0, GCD # If 'a' is greater or equal 0, calculate the GCD
	
	# If 'a' is negative, store 'a' at $v1 and print the final message
	move $v1, $v0
	
	li $v0, 4 
	la $a0, final_message 
	syscall
	
	j finish
	
	GCD: #Greatest Common Divisor
		beqz $t1, finish # Check if 'b' is zero
		
		div $t0, $t1 # Divide 'a' by 'b'
		mfhi $t2 # Stores a mod b at $t2
		
		# Print the result message
		li $v0, 4
		la $a0, result 
		syscall

		# Print the module
		li $v0, 1 
		move $a0, $t2
		syscall	
		
		move $t0, $t1 # Update 'a' with the 'b' value
		move $t1, $t2 # Update 'b' with the module value
		
		j GCD # Recursive call
		
	finish:
		li $v0, 10 # End the program
		syscall	
