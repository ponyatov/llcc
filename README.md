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
