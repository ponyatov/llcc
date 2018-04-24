INC = ../../include

H += $(INC)/stm32l0xx.h
H += $(INC)/stm32l073xx.h
H += $(INC)/core_cm0plus.h $(INC)/core_cmInstr.h $(INC)/core_cmFunc.h
H += $(INC)/cmsis_gcc.h

.PHONY: files
files: system_stm32l0xx.c $(H)

system_stm32l0xx.c: $(INC)/system_stm32l0xx.h 
 
%.c: $(INC)/%.h
 
$(INC)/%.h: STM32Cube_FW_L0_V1.10.0/Drivers/CMSIS/Device/ST/STM32L0xx/Include/%.h
	cp $< $@
$(INC)/%.h: STM32Cube_FW_L0_V1.10.0/Drivers/CMSIS/Include/%.h
	cp $< $@

%.c: STM32Cube_FW_L0_V1.10.0/Drivers/CMSIS/Device/ST/STM32L0xx/Source/Templates/%.c
	cp $< $@
