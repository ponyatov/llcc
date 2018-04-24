# shared Makefile parts

MCU		?= lm3s811evb

TARGET	= arm-none-eabi

# default RAM-only build
RAM		= _RAM


CC		= clang-3.9
CXX		= clang++-3.9

OBJDUMP	= $(TARGET)-objdump
GDB		= $(TARGET)-gdb
DDD		= ddd --debugger $(GDB) -x ram.gdb

QEMU	= qemu-system-arm -M $(MCU) -cpu cortex-m3 -S -gdb tcp::4242 -kernel

# target MCU variants of Cortex-M
ARMFLAGS	 = -target $(TARGET) -mthumb -mfloat-abi=soft

ARMFLAGS	+= -mcpu=cortex-m0 
#ARMFLAGS	+= -mcpu=cortex-m0+ 
#ARMFLAGS	+= -mcpu=cortex-m3
#ARMFLAGS	+= -mcpu=cortex-m4 -mfloat-abi=hard

# obsoleted
#ARMFLAGS	+= -mcpu=arm7tdmi

# default debug build
ARMFLAGS += -g2

# force compact sections LTO
ARMFLAGS += -Ofast -ffunction-sections -Wl,-gc-sections

# linker script
ARMFLAGS += -Wl,-T,ld/$(MCU)$(RAM).ld 

CXXFLAGS += $(CFLAGS)
