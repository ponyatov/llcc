# llcc
## LLVM-powered C/C++ toolchain for Cortex-M
### cpp -> llvm -> ansi C transpiler

- LLVM 3.9 (co-system with Debian GNU/Linux prepackaged `clang-3.9`)
- `qemu-system-arm` (Debian GNU/Linux prepackaged)
- uses Julia llvm-cbe backend fork & LLVM 3.9:

```
~$ git clone https://github.com/ponyatov/llcc.git
~$ cd llcc
~/llcc$ make install
```

## supported hardware

### Luminary Micro Stellaris LM3S811EVB /qemu-arm emulated/

- Cortex-M3 CPU core
- 64k Flash and 8k SRAM
- Timers, UARTs, ADC and I^2C interface
- OSRAM Pictiva 96×16 OLED with SSD0303 controller on I^2C bus

### Luminary Micro Stellaris LM3S6965EVB /qemu-arm emulated/

- Cortex-M3 CPU core
- 256k Flash and 64k SRAM
- Timers, UARTs, ADC, I^2C and SSI interfaces
- OSRAM Pictiva 128×64 OLED with SSD0323 controller connected via SSI

### STM32 MCU line

- AcSIP S76S: STM32L073VZ + SX1276 LoRaWAN SoC module
  - 192K Flash, 20K SRAM
  - Semtech SX1276 LoRaWAN RF
- stm32f0Discovery: STM32F051R8T6
