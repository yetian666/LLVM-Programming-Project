# Makefile for hello pass

# Path to top level of LLVM hierarchy
LEVEL = ../..

# Name of the library to build
LIBRARYNAME = cs565opt

# Make the shared library become a loadable module so the tools can
# dlopen/dlsym on the resulting library.
LOADABLE_MODULE = 1

# Might need to change this to .so in LINUX
LIB_EXT = .dylib

TEST_PRINT = $(LEVEL)/../bin/opt -load $(LEVEL)/../lib/$(LIBRARYNAME)$(LIB_EXT) -prettyPrint <

TEST_NAIVE = $(LEVEL)/../bin/opt -load $(LEVEL)/../lib/$(LIBRARYNAME)$(LIB_EXT) -cfgNaive <

TEST_LVA = $(LEVEL)/../bin/opt -load $(LEVEL)/../lib/$(LIBRARYNAME)$(LIB_EXT) -liveVariableAnalysis <

# Include the makefile implementation stuff
include $(LEVEL)/Makefile.common

testPrint:
	$(TEST_PRINT) ../tests/test2.bc > /dev/null

testNaive:
	$(TEST_PRINT) ../tests/test2.bc > /dev/null
	$(TEST_NAIVE) ../tests/test2.bc > ../tests/test2.opt.bc
	$(TEST_PRINT) ../tests/test2.opt.bc > /dev/null

testLVA:
	$(TEST_LVA) ../tests/test10.bc > /dev/null
