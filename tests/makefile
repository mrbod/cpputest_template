TESTS = $(wildcard *_test.cpp)

TEST_OBJS = main.o
TEST_OBJS += $(TESTS:.cpp=.o)

CPPFLAGS += -I $(CPPUTEST_HOME)/include

CXXFLAGS = $(CFLAGS)
#CXXFLAGS += -include $(CPPUTEST_HOME)/include/CppUTest/MemoryLeakDetectorNewMacros.h
#CFLAGS += -include $(CPPUTEST_HOME)/include/CppUTest/MemoryLeakDetectorMallocMacros.h

LD_LIBRARIES = -L$(CPPUTEST_HOME)/lib -lCppUTest -lCppUTestExt

ifeq($(strip TESTS),)
    error "No tests found"
endif

all: check_all
	check_all

check_all: $(TEST_OBJS) $(TARGET)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $^ $(LD_LIBRARIES)

clean:
	rm -rf *.o *.d *~ check_all *.gcov *.gcda *.gcno

-include 

