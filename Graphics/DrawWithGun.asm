.286
.model huge
.stack 64

.data

;dimensions of the screen
row dw 0
col dw 0


; colors
WHITE EQU 0FH
RED EQU 0CH
YELLOW EQU 0EH
BLACK EQU 0H
GRAY EQU 7H
LBLUE EQU 9H
BLUE EQU 1H


; Variables for Gun

;iterators for draw gun
; gun starts at row 80d 
rowGun dw 80d
colGun dw 20d
; gun start row and end  row are constants
gunEndRowPosition EQU 90d
; gun start column is variable
; This variable changes the position of my gun
gunStartColumnPosition dw 70d 
gunWidth EQU 20d
;Other Variables for Gun
;iterators for draw gun
; gun start column is variable
; This variable changes the position of Other gun
gunStartColumnPositionOther dw 200d

rowTarget dw 0d
colTarget dw 20d
; target start row and end  row are constants
targetEndRowPosition EQU 7d
; target start column is variable
; This variable changes the position of my target
targetStartColumnPosition dw 10d 
targetWidth EQU 10d
; gun start column is variable
; This variable changes the position of Other target
targetStartColumnPositionOther dw 200d

;data for the char to draw (x,y,char,color)
charToDraw db ?
charToDrawColor db ?
charToDrawx db ?
charToDrawy db ?


;global variable for printing line (x)
linex dw ?

;position of my registers
myAXx db 3h
myAXy db 3h
myBXx db 3h
myBXy db 4h
myCXx db 3h
myCXy db 6h
myDXx db 3h
myDXy db 7h
mySIx db 0Bh
mySIy db 3h
myDIx db 0Bh
myDIy db 4h
mySPx db 0Bh
mySPy db 6h
myBPx db 0Bh
myBPy db 7h
;other's register positions
otherAXx db 18h
otherAXy db 3h
otherBXx db 18h
otherBXy db 4h
otherCXx db 18h
otherCXy db 6h
otherDXx db 18h
otherDXy db 7h
otherSIx db 20h
otherSIy db 3h
otherDIx db 20h
otherDIy db 4h
otherSPx db 20h
otherSPy db 6h
otherBPx db 20h
otherBPy db 7h


;function to draw the background color of the main screen
drawBackGround MACRO
LOCAL rowLoop 
  rowLoop:
  mov ah, 0ch    ;write pixels on screen
  mov bh, 0      ;page
  mov dx, row    ;row
  mov cx, col    ;column
  mov al, GRAY   ;colour
  int 10h
  ;need to mov the row 
  inc col
  mov ax,col
  mov dx,320d
  cmp ax,dx
  jnz rowLoop
  mov col,0
  inc row
  mov ax,row
  mov dx,200d
  cmp ax,dx
  jnz rowLoop
ENDM

; draw gun macro 
drawGun MACRO
    local rowLoopGun
    local RemoverowLoop
    local RemoverowLoopOther
    local rowLoopGunOther

    mov colGun,0
    RemoverowLoop:
    mov ah, 0ch    ;write pixels on screen
    mov bh, 0      ;page
    mov dx, rowGun    ;row
    mov cx, colGun    ;column
    mov al, RED   ;colour
    int 10h
    ;need to mov the row 
    inc colGun
    mov ax,colGun
    mov dx,125d
    cmp ax,dx
    jnz RemoverowLoop
    mov colGun,0
    inc rowGun
    mov ax,rowGun
    mov dx,gunEndRowPosition
    cmp ax,dx
    jnz RemoverowLoop

    mov rowGun,80d
    mov colGun,163d
    RemoverowLoopOther:
    mov ah, 0ch    ;write pixels on screen
    mov bh, 0      ;page
    mov dx, rowGun    ;row
    mov cx, colGun    ;column
    mov al, RED   ;colour
    int 10h
    ;need to mov the row 
    inc colGun
    mov ax,colGun
    mov dx,287d
    cmp ax,dx
    jnz RemoverowLoopOther
    mov colGun,163d
    inc rowGun
    mov ax,rowGun
    mov dx,gunEndRowPosition
    cmp ax,dx
    jnz RemoverowLoopOther

    mov rowGun,80d


    mov ax, gunStartColumnPosition
    mov colGun, ax
    
    rowLoopGun:
    mov ah, 0ch    ;write pixels on screen
    mov bh, 0      ;page
    mov dx, rowGun    ;row
    mov cx, colGun    ;column
    mov al, BLUE     ;colour
    int 10h

    ;need to mov the row 
    inc colGun
    mov ax,colGun
    mov dx,gunStartColumnPosition
    add dx, gunWidth
    cmp ax,dx
    jnz rowLoopGun

    mov ax,gunStartColumnPosition
    mov colGun,ax
    inc rowGun
    mov ax,rowGun
    mov dx,gunEndRowPosition
    cmp ax,dx
    jnz rowLoopGun

    mov rowGun,80d
    mov colGun,0


    mov rowGun,80d
    mov ax, gunStartColumnPositionOther
    mov colGun, ax
    
    rowLoopGunOther:
    mov ah, 0ch    ;write pixels on screen
    mov bh, 0      ;page
    mov dx, rowGun    ;row
    mov cx, colGun    ;column
    mov al, BLUE     ;colour
    int 10h

    ;need to mov the row 
    inc colGun
    mov ax,colGun
    mov dx,gunStartColumnPositionOther
    add dx, gunWidth
    cmp ax,dx
    jnz rowLoopGunOther

    mov ax,gunStartColumnPositionOther
    mov colGun,ax
    inc rowGun
    mov ax,rowGun
    mov dx,gunEndRowPosition
    cmp ax,dx
    jnz rowLoopGunOther

    mov rowGun,80d
    mov colGun,0
ENDM

drawTarget MACRO
    local RemoverowLoopTarget
    local RemoverowLoopOtherTarget
    local rowLoopMyTarget
    local rowLoopOtherTarget
    mov colTarget,0
    RemoverowLoopTarget:
    mov ah, 0ch    ;write pixels on screen
    mov bh, 0      ;page
    mov dx, rowTarget    ;row
    mov cx, colTarget    ;column
    mov al, RED   ;colour
    int 10h
    ;need to mov the row 
    inc colTarget
    mov ax,colTarget
    mov dx,125d
    cmp ax,dx
    jnz RemoverowLoopTarget
    mov colTarget,0
    inc rowTarget
    mov ax,rowTarget
    mov dx,targetEndRowPosition
    cmp ax,dx
    jnz RemoverowLoopTarget

    mov rowTarget,0d
    mov colTarget,163d
    RemoverowLoopOtherTarget:
    mov ah, 0ch    ;write pixels on screen
    mov bh, 0      ;page
    mov dx, rowTarget    ;row
    mov cx, colTarget    ;column
    mov al, RED   ;colour
    int 10h
    ;need to mov the row 
    inc colTarget
    mov ax,colTarget
    mov dx,287d
    cmp ax,dx
    jnz RemoverowLoopOtherTarget
    mov colTarget,163d
    inc rowTarget
    mov ax,rowTarget
    mov dx,targetEndRowPosition
    cmp ax,dx
    jnz RemoverowLoopOtherTarget

    mov rowTarget,0d




  ;Draw my target
    mov ax, targetStartColumnPosition
    mov colTarget, ax
    
    rowLoopMyTarget:
    mov ah, 0ch    ;write pixels on screen
    mov bh, 0      ;page
    mov dx, rowTarget    ;row
    mov cx, colTarget    ;column
    mov al, YELLOW     ;colour
    int 10h

    ;need to mov the row 
    inc colTarget
    mov ax,colTarget
    mov dx,targetStartColumnPosition
    add dx, targetWidth
    cmp ax,dx
    jnz rowLoopMyTarget

    mov ax,targetStartColumnPosition
    mov colTarget,ax
    inc rowTarget
    mov ax,rowTarget
    mov dx,targetEndRowPosition
    cmp ax,dx
    jnz rowLoopMyTarget



    ;Draw other player target
    mov rowTarget,0d
    mov ax, targetStartColumnPositionOther
    mov colTarget, ax

    rowLoopOtherTarget:
    mov ah, 0ch    ;write pixels on screen
    mov bh, 0      ;page
    mov dx, rowTarget    ;row
    mov cx, colTarget    ;column
    mov al, YELLOW     ;colour
    int 10h

    ;need to mov the row 
    inc colTarget
    mov ax,colTarget
    mov dx,targetStartColumnPositionOther
    add dx, targetWidth
    cmp ax,dx
    jnz rowLoopOtherTarget

    mov ax,targetStartColumnPositionOther
    mov colTarget,ax
    inc rowTarget
    mov ax,rowTarget
    mov dx,targetEndRowPosition
    cmp ax,dx
    jnz rowLoopOtherTarget
    mov rowTarget, 0d
ENDM



;function to draw a given char at given location with given color
drawCharWithGivenVar  MACRO
  ;set the cursur
  mov ah,2
  mov dl,charToDrawx      ;x
  mov dh,charToDrawy      ;y
  mov bh,0
  int 10h
  ;draw the char
  mov  al, charToDraw
  mov  bl, charToDrawColor
  mov  bh, 0                ;Display page
  mov  ah, 0Eh              ;Teletype
  int  10h
ENDM

;function to draw memory lines (called once at the begining)
drawMemoryLines MACRO
  ;draw the memory lines
  mov linex,125d
  drawLine
  mov linex,147d
  drawLine
  mov linex,162d
  drawLine
  mov linex,287d
  drawLine
  mov linex,307d
  drawLine
ENDM
drawLine macro
LOCAL LineLoop
  mov di,0
  LineLoop:
  mov ah, 0ch     ;write pixels on screen
  mov bh, 0       ;page
  mov dx, di      ;row
  mov cx, linex   ;column
  mov al, BLACK   ;colour
  int 10h
  inc di
  mov ax,200d
  cmp di,ax
  jnz LineLoop
endm

;function to draw the register names (AX,BX,..etc)
drawRegNames MACRO
  ;draw my
  mov charToDraw,'A'
  mov charToDrawColor,WHITE
  mov charToDrawx,0
  mov al,myAXy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,15h
  drawCharWithGivenVar
  mov charToDraw,'X'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,1
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'B'
  mov charToDrawColor,WHITE
  mov charToDrawx,0
  mov al,myBXy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,15h
  drawCharWithGivenVar
  mov charToDraw,'X'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,1
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'C'
  mov charToDrawColor,WHITE
  mov charToDrawx,0
  mov al,myCXy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,15h
  drawCharWithGivenVar
  mov charToDraw,'X'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,1
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'D'
  mov charToDrawColor,WHITE
  mov charToDrawx,0
  mov al,myDXy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,15h
  drawCharWithGivenVar
  mov charToDraw,'X'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,1
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'S'
  mov charToDrawColor,WHITE
  mov charToDrawx,8
  mov al,mySIy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,1Dh
  drawCharWithGivenVar
  mov charToDraw,'I'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,9
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'D'
  mov charToDrawColor,WHITE
  mov charToDrawx,8
  mov al,myDIy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,1Dh
  drawCharWithGivenVar
  mov charToDraw,'I'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,9
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'S'
  mov charToDrawColor,WHITE
  mov charToDrawx,8
  mov al,mySPy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,1Dh
  drawCharWithGivenVar
  mov charToDraw,'P'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,9
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'B'
  mov charToDrawColor,WHITE
  mov charToDrawx,8
  mov al,myBPy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,1Dh
  drawCharWithGivenVar
  mov charToDraw,'P'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,9
  drawCharWithGivenVar
ENDM

;function to draw the memory adresses
drawMemoryAdresses MACRO 
mov charToDraw,'0'
mov charToDrawColor, LBLUE
mov charToDrawx,27h
mov charToDrawy,0
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'1'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'2'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'3'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'4'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'5'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'6'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'7'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'8'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'9'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'A'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'B'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'C'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'D'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'E'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'F'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar
ENDM

;function to draw the intial '0' of memory
;my memory postion (10h,0h),  other memory postion (24h,0h)
drawMemoryIntial macro
LOCAL MEMINTIALLOOP,MEMINTIALLOOPH,MEMINTIALEXIT
  ;draw my
  mov charToDraw,'0'
  mov charToDrawx,10h
  mov charToDrawy,0
  mov charToDrawColor,RED
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,24h
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  MEMINTIALLOOP:
  inc charToDrawy
  ;draw my
  mov charToDrawx,10h
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,24h
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  mov al,charToDrawy
  mov dl,15d
  cmp al,dl
  jnz MEMINTIALLOOPH
  jmp MEMINTIALEXIT
  MEMINTIALLOOPH: jmp MEMINTIALLOOP
  MEMINTIALEXIT:
ENDM

;function to draw intial '0' of registers
drawRegIntial MACRO
  ;draw the ax zeros
  mov charToDraw,'0'
  mov charToDrawColor,YELLOW
  mov al,myAXx
  mov charToDrawx,al
  mov al,myAXy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,otherAXx
  mov charToDrawx,al
  mov al,otherAXy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,myBXx
  mov charToDrawx,al
  mov al,myBXy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,otherBXx
  mov charToDrawx,al
  mov al,otherBXy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,myCXx
  mov charToDrawx,al
  mov al,myCXy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,otherCXx
  mov charToDrawx,al
  mov al,otherCXy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,myDXx
  mov charToDrawx,al
  mov al,myDXy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,otherDXx
  mov charToDrawx,al
  mov al,otherDXy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,mySIx
  mov charToDrawx,al
  mov al,mySIy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,otherSIx
  mov charToDrawx,al
  mov al,otherSIy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,myDIx
  mov charToDrawx,al
  mov al,myDIy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,otherDIx
  mov charToDrawx,al
  mov al,otherDIy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,mySPx
  mov charToDrawx,al
  mov al,mySPy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,otherSPx
  mov charToDrawx,al
  mov al,otherSPy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,myBPx
  mov charToDrawx,al
  mov al,myBPy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar

  mov al,otherBPx
  mov charToDrawx,al
  mov al,otherBPy
  mov charToDrawy,al
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar
  inc charToDrawx
  drawCharWithGivenVar


ENDM

.code
main proc
  mov ax,@data
  mov ds,ax
  mov es,ax

  ;set video mode   (320x200)
  mov ah, 00h
  mov al, 13h     
  int 10h 

  drawBackGround
  drawRegNames
  drawRegIntial
  drawMemoryAdresses
  drawMemoryLines
  drawMemoryIntial

  drawGun
  drawTarget
  ;for the main loop,   note: outside the loop called one time
  home:

    drawGun
    drawTarget
  
  jmp home
  hlt
main endp
end main