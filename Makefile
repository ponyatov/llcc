target.c: source.bc
	llc -march=cpp -o $@ $<
source.bc: source.cpp
	clang++ -emit-llvm -c $< -o $@  
