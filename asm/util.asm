section .text
global print
global print_hex

; input rsi: str ptr
; input rdx: str len
print:
    push rax
    push rdi
    mov rax, 1
    mov rdi, 1
    syscall
    pop rdi
    pop rax
    ret

; subroutine to print a hex number.
; ```
; rdi = the hexadecimal value to print
; ```
; Usage
; ```
; mov rdi, 0x01EF
; call print_hex
; ```
print_hex:
    ; push all registers onto the stack
    push rsi
    push rcx
    push rbx

    ; use rsi to keep track of the current char in our template string
    mov rsi, hex_out

    ; start a counter of how many nibbles we've processed, stop at 16
    mov rcx, 0

next_character:
    ; increment the counter for each nibble
    inc rcx

    ; isolate this nibble
    mov rbx, rdi
    shr rbx, 60

    ; add 0x30 to get the ASCII digit value
    add rbx, 0x30

    ; If our hex digit was > 9, it'll be <= 0x39, so add 7 to get
    ; ASCII letters
    cmp rbx, 0x39
    jle add_character_hex

    ; add 7 to our current nibble's ASCII value, in order to get letters
    add rbx, 0x7

add_character_hex:
    ; put the current nibble into our string template
    mov [rsi], bl

    ; increment our template string's char position
    inc rsi

    ; shift dx by 4 to start on the next nibble (to the right)
    shl rdi, 4

    ; exit if we've processed all 16 nibbles, else process the next
    ; nibble
    cmp rcx, 16
    jnz next_character

_done:
    ; print our template string
    mov rsi, hex_out
    mov rdx, hex_len
    call print

    ; pop all arguments
    pop rbx
    pop rcx
    pop rsi

    ; return from subroutine
    ret

section .data
hex_out:
    db "0000000000000000", 10
hex_len: equ $ - hex_out