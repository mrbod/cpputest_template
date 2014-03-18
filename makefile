export PROJECT_PATH = $(shell pwd)

export TARGET = $(PROJECT_PATH)/libstuff.a

INCLUDE = -I $(PROJECT_PATH)/include
export INCLUDE

CPPFLAGS = -MP -MMD -MT $@ -MT $(@:.o=.d)
CPPFLAGS += $(INCLUDE)
export CPPFLAGS

CFLAGS = -Wall
CFLAGS += -O0 -g
CFLAGS += --coverage
CFLAGS += -pg
export CFLAGS

SUBTARGETS = src tests

.PHONY: $(SUBTARGETS)

all: $(SUBTARGETS)

$(SUBTARGETS):
	$(MAKE) -C $@

coverage:
	(cd src && gcov *.o)

clean:
	rm -rf *~ $(TARGET)
	@for t in $(SUBTARGETS); do $(MAKE) -C $$t clean; done

