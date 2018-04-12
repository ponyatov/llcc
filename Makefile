LLVM_SRC	= llvm-3.9.1.src
LLVM_GZ		= $(LLVM_SRC).tar.xz

build: llvm/README.txt

llvm/README.txt:
	xzcat src/$(LLVM_GZ) | tar x ; mv $(LLVM_SRC) llvm ; touch $@
#	wget -O src/$(LLVM_GZ) -c http://releases.llvm.org/3.9.1/$(LLVM_GZ)
	
#	git clone -b release_39 https://github.com/llvm-mirror/llvm
#	cd llvm ; git checkout release_39
#	git clone --depth=1 https://github.com/gapkalov/llvm-cbe.git

export CC=clang-3.9
export CXX=clang++-3.9

packages:
	sudo apt-get install clang-3.9 cmake

target.c: source.bc
	llc -march=cpp -o $@ $<
source.bc: source.cpp
	clang++ -emit-llvm -c $< -o $@  
