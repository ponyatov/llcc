QEMU_RELEASE = v2.5.0-pebble4
.PHONY: qemu
qemu:
	git clone -o gh --depth=1 -b $(QEMU_RELEASE) https://github.com/pebble/qemu.git
	cd qemu ; git checkout -b $(QEMU_RELEASE)

CBE = ./installed/bin/llvm-cbe

CBEFLAGS += -march=arm
CBEFLAGS += -O=0

target: target.c
	gcc -I./llvm/projects/llvm-cbe/test/ -std=gnu89 -o $@ $< -lc 
target.c: source.bc Makefile
	$(CBE) $(CBEFLAGS) -o $@ $<
#	$(LLC) -march=c -o $@ $<
source.bc: source.cpp
	clang++ -emit-llvm -c $< -o $@  


.PHONY: install
install: $(CBE)

LLVM_SRC	= llvm-3.9.1.src
LLVM_GZ		= $(LLVM_SRC).tar.xz

LLVM_CLANG += -DCMAKE_INSTALL_PREFIX=$(CURDIR)/installed
LLVM_CLANG += -DCMAKE_BUILD_TYPE=Release
#LLVM_CLANG += -DCMAKE_C_FLAGS="-O0"
#LLVM_CLANG += -DCMAKE_CXX_FLAGS="-O0"

LLVM_CLANG += -DLLVM_TARGETS_TO_BUILD=ARM
LLVM_CLANG += -DLLVM_TARGET_ARCH=ARM
#LLVM_CLANG += -DLLVM_DEFAULT_TARGET_TRIPLE=arm-none-eabi

build: llvm/projects/llvm-cbe/README.md
	rm -rf llvm/build ; mkdir llvm/build
	cd llvm/build ; \
		CC=clang-3.9 CXX=clang++-3.9 cmake $(LLVM_CLANG) -G "Unix Makefiles" ..
	cd llvm/build ; \
		make 

llvm/projects/llvm-cbe/README.md: llvm/README.txt
	cd llvm/projects ; git clone --depth=1 https://github.com/gapkalov/llvm-cbe.git 

llvm/README.txt:
	wget -O src/$(LLVM_GZ) -c http://releases.llvm.org/3.9.1/$(LLVM_GZ)
	xzcat src/$(LLVM_GZ) | tar x ; mv $(LLVM_SRC) llvm ; touch $@

packages:
	sudo apt-get install clang-3.9 cmake

