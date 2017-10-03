; $1 start memory address of array
; $2 no. elements in array
; $3 height of tree
; $4 root index in array
; $5 temporary storage
; $6 temporary storage
; $7 left total
; $8 right total

sw $31, -4($30)		; store program return
lis $6
.word 4
sub $30, $30, $6

add $4, $0, $0		; root index
lis $5
.word getTreeHeight
jalr $5

lw $3, 0($30)		; load function result
lis $6
.word 4
add $30, $30, $6
lw $31, 0($30)
jr $31




getTreeHeight:
sw $31, -4($30)		; store return address
sw $4, -8($30)		; store root index
lis $6
.word 8
sub $30, $30, $6

lis $6
.word -1
bne $4, $6, traverseTree	; if node index = -1 return 0
	lis $6
	.word 4
	add $30, $30, $6	; delete other info, only leave value
	lis $6
	.word 0
	sw $6 , 0($30)		; store value = 0
	jr $31				; return

traverseTree:
; call left node
lis $6				; get array index of left node
.word 4
mult $4, $6
mflo $5
add $5, $5, $1
lis $6
.word 4
add $5, $5, $6
lw $4, 0($5)

lis $6
.word getTreeHeight
jalr $6

; call right node
lw $4, 4($30)
lis $6                          ; get array index of right node
.word 4
mult $4, $6
mflo $5
add $5, $5, $1
lis $6
.word 8
add $5, $5, $6
lw $4, 0($5)

lis $6
.word getTreeHeight
jalr $6

lw $7, 4($30)			; load left total from stack
lw $8, 0($30)			; load right total from stack

slt $5, $7, $8			; find max
beq $5, $0, rightMax
	lis $6
	.word 1
	add $6, $8, $6		; max(left, right) + 1
	beq $0, $0, endMax
rightMax:
	lis $6
	.word 1
	add $6, $7, $6
endMax:

lw $31, 12($30)			; load return address
lis $5
.word 12
add $30, $30, $5		; remove node values, put max
sw $6, 0($30)			; store max
jr $31
