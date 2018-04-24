#CFLAGS += -Wl,T,ld/QEMU_CortexM3_RAM.ld

MCU = STM32L073xx

TARGET = arm-none-eabi

CC = $(TARGET)-gcc
CC = clang-3.9 -target $(TARGET)

AS = $(TARGET)-as

OBJDUMP = $(TARGET)-objdump

CFLAGS += -mcpu=cortex-m0
#CFLAGS += -mcpu=cortex-m0+
#CFLAGS += -mcpu=cortex-m3

CFLAGS += -mthumb -mfloat-abi=soft

CFLAGS += -I../include -D$(MCU)

libSTM32_RAM.a: startup_RAM.o system_stm32l0xx.o

#libSTM32_RAM.a: startup_RAM.o system_stm32l0xx.o

%.o: ../src/STM32/%.S Makefile
	$(CC) $(CFLAGS) -c -o $@ $^ && $(OBJDUMP) -x $@ > $@.objdump
%.o: ../src/STM32/%.c Makefile
	$(CC) $(CFLAGS) -c -o $@ $^ && $(OBJDUMP) -x $@ > $@.objdump
