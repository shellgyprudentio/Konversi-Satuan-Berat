.MODEL SMALL
.STACK 100H
.DATA

MSG1 DB '*=========================*$'
MSG2 DB 10,13,'||KONVERSI SATUAN BERAT||$'
MSG3 DB 10,13,'*=========================*$'
MSG4 DB 10,13,'|| KG -> HG KETIK    : 1  ||$'
MSG5 DB 10,13,'|| KG -> DAG KETIK   : 2  ||$'
MSG6 DB 10,13,'|| KG -> G KETIK     : 3  ||$'
MSG7 DB 10,13,'|| KG -> DG KETIK    : 4  ||$'
MSG8 DB 10,13,'*=========================*$'
MSG9 DB 10,13,'MASUKKAN PILIHAN :$'
MSG10 DB 10,13,10,13,'MASUKKAN KG:$'
MSG11 DB 10,13,10,13,'HASILNYA ADALAH:$'

NUM1 DB ?
HASIL DW ?
OP DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 9
    LEA DX, MSG1
    INT 21H
    MOV AH, 9
    LEA DX, MSG2
    INT 21H
    MOV AH, 9
    LEA DX, MSG3
    INT 21H
    MOV AH, 9
    LEA DX, MSG4
    INT 21H
    MOV AH, 9
    LEA DX, MSG5
    INT 21H
    MOV AH, 9
    LEA DX, MSG6
    INT 21H
    MOV AH, 9
    LEA DX, MSG7
    INT 21H
    MOV AH, 9
    LEA DX, MSG8
    INT 21H

    MOV AH, 9
    LEA DX, MSG9
    INT 21H
    MOV AH, 1
    INT 21H
    SUB AL, '0' 
    MOV OP, AL

    ; Input KG
    MOV AH, 9
    LEA DX, MSG10
    INT 21H
    MOV AH, 1
    INT 21H
    SUB AL, '0'    
    MOV NUM1, AL

    ; Proses konversi
    CMP OP, 1
    JE  KG_HG
    CMP OP, 2
    JE  KG_DAG
    CMP OP, 3
    JE  KG_G
    CMP OP, 4
    JE  KG_DG

    KG_HG:
    MOV AX, 0
    MOV AL, NUM1
    MOV BL, 10       
    MUL BL           
    MOV HASIL, AX   
    JMP  HASIL_AKHIR
    
    KG_DAG:
    MOV AX, 0         
    MOV AL, NUM1
    MOV CX, 100     
    MUL CX           
    MOV HASIL, AX
    JMP  HASIL_AKHIR
   
    KG_G:
    MOV AX, 0         
    MOV AL, NUM1
    MOV CX, 1000     
    MUL CX           
    MOV HASIL, AX
    JMP  HASIL_AKHIR
    
    KG_DG:
    MOV AX, 0         
    MOV AL, NUM1
    MOV CX, 10000    
    MUL CX           
    MOV HASIL, AX
    JMP  HASIL_AKHIR


    HASIL_AKHIR:

    
    MOV AH, 9
    LEA DX, MSG11
    INT 21H

    
    MOV BX, 10
    MOV CX, 0
    MOV AX, HASIL
    
    ANGKA: 
    MOV DX, 0
    DIV BX 
    PUSH DX
    INC CX
    CMP AX, 0 
    JNE ANGKA
    
    CETAK:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    DEC CX
    JNZ CETAK

    
    MOV AH, 4CH  
    INT 21H

MAIN ENDP
END MAIN
