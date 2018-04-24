/// @file
/// @brief sample C++ program will be transpiled to ANSI C code in target.c

/// minimal empty function
void none(void) {}

/// sum two ints: @test with input and output parameters
int sum(int a,int b) { return a+b; }

#include <iostream>
using namespace std;

/// public class with some methods: generic Object implementation
struct Object {
	/// type/class tag
	string tag;
	/// single item value
	string val;
	/// constructor
	Object(string T,string V);
	Object(string V);
};

Object::Object(string T,string V) {
	tag = T; val = V;
}
Object::Object(string V):Object("object",V){}

/// static initializer test
Object *o = new Object("generic");

/// `main()` sample
int main() {}
