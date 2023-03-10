; EFI Written in FASM ( Flat Assembler )
; fasm bootx64.asm BOOTX64.EFI

format pe64 dll efi
entry efimain

include 'src/consts.inc'
include 'src/structs.inc'

section '.text' code executable readable

include 'src/errorcodes.inc'
include 'src/functions.inc'

efimain:
    INITIALIZE_EFI
    TEXTOUTRESET
    COLOR EFI_YELLOW
    PRINT[welcome]

    ENABLEGOP
    LOADFILESYSTEM
    OPENFILE[kernel],[OSBuffer_Handle],0x00100000,262    ; fileName, Buffer, BufferSize, Seek Position
    
    CLOSEFILE
    
    ; OSBuffer_Handle     <---- We need to jump to the file here. It's in memory at this point.
    
    COLOR EFI_GREEN
    PRINT[hitkey]
    WAITKEY
    
    SETCOLOR GOP_COLOR_ORANGE
    DRAWSQUARE 50, 50, 112, 400
    SETCOLOR GOP_COLOR_GREEN
    DRAWSQUARE 60, 100, 30, 200

    COLOR EFI_LIGHTGREEN
    PRINT[hitkey]
    WAITKEY
    QUIT
   ; COLDREBOOT

section '.reloc' fixups data discardable

section '.data' code readable writeable

include 'src/data.inc'
