# Code Under Test
# CUT = stuff.c things.c
CUT = 

TESTS = $(CUT:.c=_test.cpp)
ifeq ($(strip $(TESTS)),)
$(error No tests found)
endif

TEST_OBJS = check_all.o
TEST_OBJS += $(TESTS:.cpp=.o)

CUT_OBJS = $(CUT:.c=.o)

OBJS = $(TEST_OBJS) $(CUT_OBJS)

INCLUDE += -I $(PROJECT_PATH)/src
INCLUDE += -I $(CPPUTEST_HOME)/include

CPPFLAGS += $(INCLUDE)

CFLAGS += -O0 -g
CFLAGS += --coverage
CFLAGS += -pg

CXXFLAGS = $(CFLAGS)

LD_LIBRARIES = -L$(CPPUTEST_HOME)/lib -lCppUTest -lCppUTestExt

vpath %.c $(PROJECT_PATH)/src

TEST_RUNNER = check_all

all: $(TEST_RUNNER)
	$(TEST_RUNNER)

$(TEST_RUNNER): $(OBJS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $^ $(LD_LIBRARIES)

coverage: $(CUT_OBJS)
	gcov $^

clean:
	rm -rf *.o *.d *~ $(TEST_RUNNER) gmon.out *.gcov *.gcda *.gcno

-include $(OBJS:.o=.d)

