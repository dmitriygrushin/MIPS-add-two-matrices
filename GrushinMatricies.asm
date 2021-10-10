.data
	Matrix1: 	.space 81
	Matrix2: 	.space 81
	Matrix3: 	.space 81
	
	inputRows: 	.asciiz "\nHow many rows (max 9)?"
	inputCols: 	.asciiz "\nHow many cols (max 9)?"
	
	results:	.asciiz "\nRESULTS\n"
	plus:		.asciiz "\nPLUS\n"
	equals:		.asciiz "\nEQUALS\n"
	
	forMatrix1:	.asciiz "\nFor Matrix 1\n"
	forMatrix2:	.asciiz "\nFor Matrix 2\n"
	
	enterRowX:	.asciiz " Enter Row "
	enterColX:	.asciiz " Col "
	colon:		.asciiz	": "
	spaces:		.asciiz "		"
	nl:			.asciiz "\n"
	hola:		.asciiz "\nHOLA\n"
.text

main:
li $v0, 4							# asks for rows
la $a0, inputRows
syscall

li $v0, 5							# [ t0 ] holds how many rows
syscall
move $t0, $v0

li $v0, 4							# ask for cols
la $a0, inputCols		
syscall

li $v0, 5							# [ t1 ] holds how many cols
syscall
move $t1, $v0

li $v0, 4							# Print "For Matrix 1"
la $a0, forMatrix1
syscall

jal InputRowWise

li $v0, 4							# Print "For Matrix 2"
la $a0, forMatrix2
syscall

jal InputColWise

li $v0, 4							# Print "RESULTS"
la $a0, results
syscall

jal PrintMatrix1

li $v0, 4							# Print "PLUS"
la $a0, plus
syscall

jal PrintMatrix2

li $v0, 4							# Print "EQUALS"
la $a0, equals
syscall

jal AddMatricies

jal PrintMatrix3

li $v0, 10							# END
syscall

############################################################################################################################################################	
############################################################################################################################################################

InputRowWise:
mul $t2 $t0, $t1					# row x col = [ t2 ] later used to jump out of loop
li $t3, 0							# counter for the main loop will be compared with t2 to jump out of loop

li $t4, 1							# counter for [ ROWS ]DISPLAYED FOR USER
li $t5, 1							# counter for [ COLS ] DISPLAYED FOR USER

li $t6, 0							# counter for [ ROWS ] used for row-wise algorithm	row-wise: i * nCols + j		i = rows j = cols
li $t7, 0							# counter for [ COLS ] used for row-wise algorithm	row-wise: t6 * t1 + $t7

WhileFillingCols:
beq $t3, $t2, ExitLoop1				# Branch if mainLoop == matrixLength 

mul $t8, $t6, $t1					# (rows * inputedCols)
add $s0, $t7, $t8					#  			||		  + cols

#li $v0, 1							# Checks if the algorith is correct 
#move $a0, $s0						# <------------------------------------------ UNCOMMENT THIS TO SEE WHAT POSITION IN THE ARRAY MATRIX THE VALUE IS STORED IN ****
#syscall							# <------------------------------------------ UNCOMMENT THIS TO SEE WHAT POSITION IN THE ARRAY MATRIX THE VALUE IS STORED IN ****

li $v0, 4							# "Enter Row "
la $a0, enterRowX
syscall

li $v0, 1							# Prints: Row#
move $a0, $t4
syscall

li $v0, 4							# " Col: "
la $a0, enterColX
syscall

li $v0, 1							# Prints: Col#
move $a0, $t5
syscall

li $v0, 4							# ": "
la $a0, colon
syscall

li $v0, 5							# GET input #
syscall

sb $v0, Matrix1($s0)

addi $t3, $t3, 1					# mainLoop++
addi $t5, $t5, 1					# col++ DISPLAYED FOR USER
addi $t7, $t7, 1					# col++ for algorithm
ble	$t5, $t1, WhileFillingCols		# Branch if colCounter <= inputedCols

addi $t4, $t4, 1					# row++ DISPLAYER FOR USER
addi $t6, $t6, 1					# row++ for algorithm
li $t5, 1							# col# reset
li $t7, 0							# col# reset algorithm

	j WhileFillingCols
	
ExitLoop1:
	jr $ra
	
############################################################################################################################################################	
############################################################################################################################################################	

InputColWise:
mul $t2 $t0, $t1					# row x col = [ t2 ] later used to jump out of loop
li $t3, 0							# counter for the main loop will be compared with t2 to jump out of loop

li $t4, 1							# counter for [ ROWS ]DISPLAYED FOR USER
li $t5, 1							# counter for [ COLS ] DISPLAYED FOR USER

li $t6, 0							# counter for [ ROWS ] used for col-wise algorithm	col-wise: j * nRows + i		i = rows j = cols
li $t7, 0							# counter for [ COLS ] used for col-wise algorithm	col-wise: t7 * t0 + t6

WhileFillingCols2:
beq $t3, $t2, ExitLoop2				# Branch if mainLoop == matrixLength 

mul $t8, $t7, $t0					# cols * inputedRows
add $s1, $t6, $t8					# 		||			+ rows

#li $v0, 1							# Checks if the algorith is correct 
#move $a0, $s1						# <------------------------------------------ UNCOMMENT THIS TO SEE WHAT POSITION IN THE ARRAY MATRIX THE VALUE IS STORED IN ****
#syscall							# <------------------------------------------ UNCOMMENT THIS TO SEE WHAT POSITION IN THE ARRAY MATRIX THE VALUE IS STORED IN ****

li $v0, 4							# "Enter Row "
la $a0, enterRowX
syscall

li $v0, 1							# Prints: Row#
move $a0, $t4
syscall

li $v0, 4							# " Col: "
la $a0, enterColX
syscall

li $v0, 1							# Prints: Col#
move $a0, $t5
syscall

li $v0, 4							# ": "
la $a0, colon
syscall

li $v0, 5							# GET input #
syscall

sb $v0, Matrix2($s1)

addi $t3, $t3, 1					# mainLoop++
addi $t5, $t5, 1					# col++ DISPLAYED FOR USER
addi $t7, $t7, 1					# col++ for algorithm
ble	$t5, $t1, WhileFillingCols2		# Branch if colCounter <= inputedCols

addi $t4, $t4, 1					# row++ DISPLAYER FOR USER
addi $t6, $t6, 1					# row++ for algorithm
li $t5, 1							# col# reset
li $t7, 0							# col# reset algorithm

	j WhileFillingCols2
	
ExitLoop2:
	jr $ra
	
############################################################################################################################################################	
############################################################################################################################################################

PrintMatrix1:
mul $t2 $t0, $t1					# row x col = [ t2 ] later used to jump out of loop
li $t3, 0							# counter for the main loop will be compared with t2 to jump out of loop
li $t5, 1							# counter for [ COLS ] DISPLAYED FOR USER
li $s0, 0							# reset Matrix1 counter
WhileFillingCols3:
beq $t3, $t2, ExitLoop3				# Branch if mainLoop == matrixLength 
	lb	$a0, Matrix1($s0)
	
	li $v0, 1						# Prints Value from Matrix
	syscall
	
	li $v0, 4						# "	"
	la $a0, spaces
	syscall
	 
	addi $s0, $s0, 1				# Matrix++ to go to the next value
	addi $t3, $t3, 1				# mainLoop++
	addi $t5, $t5, 1				# col++ DISPLAYED FOR USER
	
	ble $t5, $t1, WhileFillingCols3	# Branch if colCounter <= inputedCols
	
	li $v0, 4						# "\n"
	la $a0, nl
	syscall
	
	li $t5, 1						# col# reset
	
	j WhileFillingCols3
	
	ExitLoop3:
	jr $ra
	
############################################################################################################################################################	
############################################################################################################################################################

PrintMatrix2:
mul $t2 $t0, $t1					# row x col = [ t2 ] later used to jump out of loop
li $t3, 0							# counter for the main loop will be compared with t2 to jump out of loop

li $t4, 1							# counter for [ ROWS ]DISPLAYED FOR USER
li $t5, 1							# counter for [ COLS ] DISPLAYED FOR USER

li $t6, 0							# counter for [ ROWS ] used for col-wise algorithm	 col-wise: j * nRows + i		i = rows j = cols
li $t7, 0							# counter for [ COLS ] used for col-wise algorithm	 col-wise: t7 * t0 + t6
li $s1, 0							# reset Matrix2 counter
WhileFillingCols4:
mul $t8, $t7, $t0					# t7 * t0
add $s1, $t6, $t8					# (t7 * t0) + t6

beq $t3, $t2, ExitLoop4				# Branch if mainLoop == matrixLength 
	lb	$a0, Matrix2($s1)
	
	li $v0, 1						# Prints value from matrix
	syscall
	
	li $v0, 4						# "	"
	la $a0, spaces
	syscall
	
	addi $t3, $t3, 1				# mainLoop++
	addi $t5, $t5, 1				# col++ DISPLAYED FOR USER
	addi $t7, $t7, 1				# col++ For algorithm
	
	ble $t5, $t1, WhileFillingCols4	# Branch if colCounter <= inputedCols
	
	li $v0, 4						# "\n"
	la $a0, nl
	syscall
	
	addi $t6, $t6, 1				# col++ for algorithm
	li $t5, 1						# col# reset
	li $t7, 0						# reseting cols to algorithm
	j WhileFillingCols4
	
	ExitLoop4:
	jr $ra

############################################################################################################################################################	
############################################################################################################################################################

AddMatricies:
mul $t2 $t0, $t1					# row x col = [ t2 ] later used to jump out of loop
li $t3, 0							# counter for the main loop will be compared with t2 to jump out of loop

li $t4, 1							# counter for [ ROWS ]DISPLAYED FOR USER
li $t5, 1							# counter for [ COLS ] DISPLAYED FOR USER

li $t6, 0							# counter for [ ROWS ] used for col-wise algorithm		col-wise: j * nRows + i		i = rows j = cols
li $t7, 0							# counter for [ COLS ] used for col-wise algorithm		col-wise: t7 * t0 + t6
li $s0, 0							# reset matrix1 value
li $s1, 0							# reset matrix2 value
WhileFillingCols5:
mul $t8, $t7, $t0					# (t7 * t0)
add $s1, $t6, $t8					# (t7 * t0) + t6

beq $t3, $t2, ExitLoop5
	lb	$a0, Matrix2($s1)
	lb 	$a1, Matrix1($s0)
	
	add $a3, $a0, $a1				# Add Matrix1[x][y] + Matrix2[x][y]
	sb $a3, Matrix3($s3)

	addi $s0, $s0, 1				# Matrix1++ go to the next value
	addi $s3, $s3, 1				# Matrix3++ go to the next value
	addi $t3, $t3, 1				# mainLoop++
	addi $t5, $t5, 1				# col++ DISPLAYED FOR USER
	addi $t7, $t7, 1				# col++ For algorithm
	
	ble $t5, $t1, WhileFillingCols5	# Branch if colCounter <= inputedCols

	addi $t6, $t6, 1
	li $t5, 1						# col# reset
	li $t7, 0						# reseting cols to algorithm
	j WhileFillingCols5
	
	ExitLoop5:
	jr $ra
	
############################################################################################################################################################	
############################################################################################################################################################	

PrintMatrix3:
mul $t2 $t0, $t1					# row x col = [ t2 ] later used to jump out of loop
li $t3, 0							# counter for the main loop will be compared with t2 to jump out of loop
li $t5, 1							# counter for [ COLS ] DISPLAYED FOR USER
li $s3, 0							# reset Matrix3 counter
WhileFillingCols6:
beq $t3, $t2, ExitLoop6				# Branch if mainLoop == matrixLength 
	lb	$a0, Matrix3($s3)
	
	li $v0, 1						# Prints Value from Matrix
	syscall
	
	li $v0, 4						# "	"
	la $a0, spaces
	syscall
	 
	addi $s3, $s3, 1				# Matrix++ to go to the next value
	addi $t3, $t3, 1				# mainLoop++
	addi $t5, $t5, 1				# col++ DISPLAYED FOR USER
	
	ble $t5, $t1, WhileFillingCols6	# Branch if colCounter <= inputedCols
	
	li $v0, 4						# "\n"
	la $a0, nl
	syscall
	
	li $t5, 1						# col# reset
	
	j WhileFillingCols6
	
	ExitLoop6:
	jr $ra
