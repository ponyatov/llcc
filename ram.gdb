target remote :4242
displ /i $pc
displ /x $r0
displ /x $r1
displ /x $r2
displ /x $r3
displ /x $sp
displ
b Reset_Handler
b SystemInit
