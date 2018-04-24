PREFIX = $(CURDIR)/installed

CBE  = $(PREFIX)/bin/llvm-cbe

CC  = clang-3.9

ARMFLAGS = -target arm-none-eabi -mcpu=cortex-m0 -mthumb -mfloat-abi=soft
#-mcpu=arm7tdmi
#-mcpu=cortex-m0+ -mthumb

#CFLAGS += -Os
#CFLAGS += -Ofast
CFLAGS += -O1

CXX = clang++-3.9

CXXFLAGS += -std=gnu++11
CXXFLAGS += $(CFLAGS)

sample: source cortex.bc
source: source.cpp Makefile
	$(CXX) $(CXXFLAGS) -o $@ $< && chmod +x $@
	
cortex.bc cortex.S: cortex.c Makefile
	$(CC) $(CFLAGS) $(ARMFLAGS) -S -emit-llvm -o cortex.bc $<
	$(CC) $(CFLAGS) $(ARMFLAGS) -S            -o cortex.S  $<
	arm-none-eabi-gcc $(CFLAGS) -mcpu=cortex-m0 -mthumb -S -o cortex.gcc.S  $<

CBEFLAGS += -march=arm
CBEFLAGS += -O=0

target: target.c
	gcc -I./llvm/projects/llvm-cbe/test/ -std=gnu89 -o $@ $< -lc 
target.c: target.bc Makefile
	$(CBE) $(CBEFLAGS) -o $@ $<
#	$(LLC) -march=c -o $@ $<
target.bc: source.cpp
	clang++ -emit-llvm -c $< -o $@  

.PHONY: doc
doc:
	doxygen doxy.gen
	
.PHONY: install
install: $(CBE)

LLVM_SRC	= llvm-3.9.1.src
LLVM_GZ		= $(LLVM_SRC).tar.xz

LLVM_CLANG += -DCMAKE_INSTALL_PREFIX=$(PREFIX)
LLVM_CLANG += -DCMAKE_BUILD_TYPE=Release
#LLVM_CLANG += -DCMAKE_C_FLAGS="-O0"
#LLVM_CLANG += -DCMAKE_CXX_FLAGS="-O0"

LLVM_CLANG += -DLLVM_TARGETS_TO_BUILD=ARM
LLVM_CLANG += -DLLVM_TARGET_ARCH=ARM
LLVM_CLANG += -DLLVM_DEFAULT_TARGET_TRIPLE=arm-none-eabi

$(CBE): build
build: llvm/projects/llvm-cbe/README.md
	rm -rf llvm/build ; mkdir llvm/build
	cd llvm/build ; \
		CC=gcc CXX=g++ cmake $(LLVM_CLANG) -G "Unix Makefiles" ..
	cd llvm/build ; \
		make && make install

llvm/projects/llvm-cbe/README.md: llvm/README.txt
	cd llvm/projects ; git clone --depth=1 https://github.com/gapkalov/llvm-cbe.git 

llvm/README.txt:
	wget -O src/$(LLVM_GZ) -c http://releases.llvm.org/3.9.1/$(LLVM_GZ)
	xzcat src/$(LLVM_GZ) | tar x ; mv $(LLVM_SRC) llvm ; touch $@

packages:
	sudo apt-get install clang-3.9 cmake

