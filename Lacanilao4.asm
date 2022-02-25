# Lacanilao4.asm
# CSCI 213 - Spring 2022
# Last edited Feb. 21, 2022 by M. Lacanilao
# Purpose of program is to calculate an employee's weekly pay

.data
prompt: .asciiz "Please enter the employee's hourly wage: "
prompt1: .asciiz "Please enter the hours worked: "
output: .asciiz "The employee's total pay is $"
floatHolder: .float 0.00 # initialize memory with a single-precison value
newLine: .asciiz "\n" # add a new line
errorMessage: .asciiz "INVALID INPUT! ENTER A VALUE GREATER THAN 0.00"

.text
firstprompt:
	lwc1 $f10, floatHolder # stores 0.00 float at $f1
	la	$a0, prompt # gets user's hourly wage
	li	$v0, 4 # sets syscall code for printing a string
	syscall
	
	# $f0-$f31 are used to store floating point numbers
	li	$v0, 6 # sets syscall code for reading a float
	syscall
	
	# we'll type this every time we need a new line
	la $a0, newLine
	li $v0, 4
	syscall
	
	add.s $f1, $f0, $f10 # stores 1st input (wage) into $f1
	
	loop:
	# while loop that determines validity of user input
	# if input is < 0, program will repeat question
	c.le.s $f1, $f10
	bc1f newprompt
	# error message below
	la	$a0, errorMessage
	li	$v0, 4
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	la	$a0, prompt #repeats 1st prompt
	li	$v0, 4
	syscall 	
	
	li	$v0, 6
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	add.s $f1, $f0, $f10
	
	j loop
	
newprompt:
	la $a0, prompt1 #we go to new prompt if last one was completed correctly
	li $v0, 4
	syscall
	
	li $v0, 6
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	add.s $f2, $f0, $f10
	
	loop1:
	# same while loop as the first one except for the hours input
	# we'll recycle the same error messsage if incorrect!
	c.le.s $f2, $f10
	bc1f finalprompt
	
	la	$a0, errorMessage
	li	$v0, 4
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	la $a0, prompt1 # 2nd prompt once more
	li $v0, 4
	syscall
	
	li $v0, 6 #reads user input
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	add.s $f2, $f0, $f4
	
	j loop1
	
	la	$a0, prompt1 # gets hours worked as 2nd user input
	li	$v0, 4
	syscall
	
finalprompt:
	la $a0, output # displays weekly pay to user
	li $v0, 4
	syscall
	
	mul.s $f12, $f1, $f2 # floats have special arithmetic commands
	# will get product of hours worked and wage

	li $v0, 2
	syscall
	
	li $v0, 10 # closes program
	syscall