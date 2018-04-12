build:
	git clone -b release_39 https://github.com/llvm-mirror/llvm
	cd llvm ; git checkout release_39
#	git clone --depth=1 https://github.com/gapkalov/llvm-cbe.git

target.c: source.bc
	llc -march=cpp -o $@ $<
source.bc: source.cpp
	clang++ -emit-llvm -c $< -o $@  
