CC := gcc
CP := cp
RM := rm -rf
MD := mkdir -p
YACC := bison
LEX := flex

CCFLAGS += -lfl
YACCFLAGS += -d

all: calc.tab.c lex.yy.c
	$(CC) -o calc calc.tab.c lex.yy.c $(CCFLAGS)

run:
	./calc

calc.tab.c:
	$(YACC) $(YACCFLAGS) calc.y

lex.yy.c:
	$(LEX) calc.l

clean:
	RM calc
	RM calc.tab.c
	RM calc.tab.h
	RM lex.yy.c

