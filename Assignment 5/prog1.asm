section .data
msg1: db "File opened successfully.",0x0A
len1: equ $-msg1
msg2: db "File opening failed.",0x0A
len2: equ $-msg2
fname: db "abc.txt",0
val: db 10

section .bss
global length,buffer,temp
fd: resb 8
length : resb 10
temp: resb 10
buffer : resb 1000
%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .text
global main
main:
extern enter,space,occurance

scall 2,fname,2,0777

mov qword[fd],rax

bt rax,63
jc error

scall 1,1,msg1,len1
scall 0,[fd],buffer,1000

mov qword[length],rax
mov qword[temp],rax

call enter
scall 1,1,val,1

mov rax,qword[temp]
mov qword[length],rax

call space
scall 1,1,val,1

mov rax,qword[temp]
mov qword[length],rax

call occurance
scall 1,1,val,1

exit:
mov rax,60
mov rdi,0
syscall

error:
scall 1,1,msg2,len2
jmp exit
