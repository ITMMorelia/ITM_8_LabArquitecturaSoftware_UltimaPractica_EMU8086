.model small
.data
    msg db 13, 10, "Ingrese su nombre (max 25 caracteres): $"
    buffer db 25, ?, 25 dup(0) ; Estructura del buffer para la cadena
.code
main:
    mov ax, @data
    mov ds, ax

    ; Imprimir el mensaje
    mov ah, 09h
    lea dx, msg
    int 21h

    ; Leer la cadena
    mov ah, 0Ah
    lea dx, buffer
    int 21h

    ; Revisar la cadena para letras mayusculas
    mov bx, dx ; bx apunta al inicio del buffer
    add bx, 2 ; Saltar los dos primeros bytes del buffer
    mov cl, [bx] ; Obtener la longitud de la cadena
    revisar_cadena:
        mov al, [bx] ; Obtener el caracter actual
        cmp al, 'A' ; Comprobar si es una letra mayascula
        jb guardar_caracter ; Si no es una letra mayascula, guardar el carácter
        cmp al, 'Z'
        jbe convertir_a_null ; Si es una letra mayascula, convertirla en null
        guardar_caracter:
            inc bx ; Avanzar al siguiente carácter
            loop revisar_cadena ; Revisar el siguiente caracter

    ; Agregar un caracter de dlar al final de la cadena
    mov byte ptr [bx], '$' ; Agregar un carácter de dalar al final de la cadena

    ; Imprimir la cadena leida
    mov ah, 09h
    lea dx, buffer+2 ; Puntero a la cadena dentro del buffer
    int 21h

    ; Terminar el programa
    mov ah, 4Ch
    int 21h

convertir_a_null:
    mov byte ptr [bx], 0 ; Convertir la letra mayuscula en null
    jmp guardar_caracter ; Continuar con el siguiente caracter

end main
