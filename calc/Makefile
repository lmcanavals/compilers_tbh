CC := gcc
CP := cp
RM := rm -rf
MD := mkdir -p
YACC := bison
LEX := flex

CCFLAGS += -lfl
YACCFLAGS += -d

all: calc.tab.c lex.yy.c
	$(CC) calc.tab.c lex.yy.c $(CCFLAGS)

run:
	./a.out

calc.tab.c:
	$(YACC) $(YACCFLAGS) calc.y

lex.yy.c:
	$(LEX) calc.l

clean:
	RM a.out
	RM calc.tab.c
	RM calc.tab.h
	RM lex.yy.c

