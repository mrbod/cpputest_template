SRCS = $(wildcard *.c)

OBJS = $(SRCS:.c=.o)

$(TARGET): $(OBJS)
	ar -rs $@ $^

clean:
	rm -rf *.o *.d *~ check_all *.gcov *.gcda *.gcno

