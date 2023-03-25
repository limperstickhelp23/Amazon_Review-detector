; Exam2ASMPart.s  
; ECE319K/ECE319H Exam2, Spring 2023
; ***Jacob Joseph***
; This is the assembly Part of Exam 2 (See Exam2ASMPart.c for C part)
; The assembly part is not related to the C part
; The assembly part has one function
     PRESERVE8
     AREA    |.text|, CODE, READONLY, ALIGN=2
     THUMB 
     EXPORT CountandRemoveX
;(30) Question 3: array manipulation	 
; Write an assembly subroutine that counts and removes all occurrences 
;   of number X from an array. 
;   The value -32768 marks the end of the array.
; Inputs: R0 is a pointer to array of signed 16-bit integers
;         R1 is X, the 16-bit integer to count and remove
; Output: R0 is the count of the occurrences that were removed
;   You will modify the array that was passed to you
; Note: R1 will never be -32768
; Note: you get half points for just counting the number of occurances
; Follow AAPCS
; Example test cases
; Case 0: R0->{-32768}, R1=5                   (empty)
;             {-32768} and return R0=0         (empty)
; Case 1: R0->{ 1,-2,5,10,-32768}, R1=5        (size is 4)
;             { 1,-2,10,-32768} and return R0=1(reduces to size 3)
; Case 2: R0->{ 1,1,1,-3,1,7,1,8,-32768}, R1=1 (size is 8)
;             { -3,7,8,-32768} and return R0=5 (reduces to size 3)
; Case 3: R0->{ 7,-3,0,7,-3,-32768}, R1=-1     (size is 5)
;             { 7,-3,0,7,-3,-32768} and return R0=0 (remains 5) 
CountandRemoveX
;remove the following line and replace with your solution
	PUSH{R4-R7}
	
	LDR R3, =0; INDEX
	LDR R4, =0; COUNT
	LDR R5, =-32768
	LDR R7, = 0; SUB COUNT
LOOP
	LDRSH R2,[R0, R3, LSL #1]
	CMP R2, R5
	BEQ DONE
	CMP R2, R1
	BNE SKIP
	ADD R4, #1
FORWARD
	ADD R3, #1
	LDRSH R6, [R0, R3, LSL #1]
	SUB R3, #1
	STRH R6, [R0, R3, LSL #1]
	CMP R6, R5
	BEQ FIN
	ADD R3, #1
	ADD R7, #1
	B FORWARD
FIN
	ADD R7, #1
	SUB R3, R7
SKIP
	ADD R3, #1
	LDR R7, =0
	B LOOP
DONE
	MOV R0, R4	
	POP{R4-R7}
   BX LR
  END
