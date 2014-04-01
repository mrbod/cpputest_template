# Code Under Test
# 
# Define and export variable CODE_UNDER_TEST in your top level makefile
# like so:
# export CODE_UNDER_TEST = stuff.c things.c
#
# Inform about where your test modules are stored like so:
# TESTS_PATH = some/path

TESTS = $(CODE_UNDER_TEST:.c=_test.cpp)
ifeq ($(strip $(TESTS)),)
$(error No tests found)
endif

ifeq ($(strip $(TESTS_PATH)),)
$(error No TESTS_PATH defined)
endif

TEST_OBJS = check_all.o
TEST_OBJS += $(TESTS:.cpp=.o)

CUT_OBJS = $(CODE_UNDER_TEST:.c=.o)

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
vpath %.cpp $(TESTS_PATH)

TEST_RUNNER = check_all

.PHONY: run_tests coverage

all: $(TEST_RUNNER) run_tests coverage

$(TEST_RUNNER): $(OBJS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $^ $(LD_LIBRARIES)

run_tests:
	$(TEST_RUNNER)

coverage: $(CUT_OBJS)
	gcov --function-summaries $^

clean:
	rm -rf *.o *.d *~ $(TEST_RUNNER) gmon.out *.gcov *.gcda *.gcno

-include $(OBJS:.o=.d)

