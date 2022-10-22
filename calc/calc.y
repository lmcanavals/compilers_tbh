/* cometarios */

%{

/* código C, importar scanner */
#include <ctype.h>
#include <stdio.h>
#include <math.h>

int yylex();

int yyerror(char* s) {
	printf("%s\n", s);
}

double (*func[])(double) = {&sin, &cos, &tan, &sqrt, &log};
double op(double a, double b, int fi) {
	switch (fi) {
	case 0: return a + b;
	case 1: return a - b;
	case 2: return a * b;
	case 3: return a / b;
	case 4: return (int)a / (int)b;
	case 5: return (int)a % (int)b;
	case 6: return pow(a, b);
	}
}

%}

%start start

%union {
	char name[100];
	struct cc {
		int op; // +_*/\% ^ 
		double right;
	} info;
	double num;
	int func;
}

%type<num> exp term factor power call LITNUM
%type<info> expp termp factorp
%type<name> ID
%type<func> func KWSIN KWCOS KWTAN KWSQRT KWLOG

%token EXIT OPSUM OPREST OPPROD OPDIV OPDIVI OPMOD OPPOW
%token ID
%token OPASIGN
%token KWSIN KWCOS KWTAN KWSQRT KWLOG
%token LITNUM
%token LPAR RPAR
%token NL

%%

start
	: /* empty string */
	| start line
	;

line
	: NL
	| assign NL
	| exp NL                   { printf("= %f\n", $1); }
	| ID NL
	;

assign
	: ID OPASIGN exp
	;

exp
	: term expp                { $$ = $2.op < 0? $1 : op($1, $2.right, $2.op); }
	;

expp
	: OPSUM term expp          { $$.op=0;$$.right=($3.op<0?$2:op($2,$3.right,$3.op)); }
	| OPREST term expp         { $$.op=1;$$.right=($3.op<0?$2:op($2,$3.right,$3.op)); }
	| /* empty string */       { $$.op = -1; }
	;

term
	: factor termp             { $$ = $2.op < 0? $1 : op($1, $2.right, $2.op); }
	;

termp
	: OPPROD factor termp      { $$.op=2;$$.right=($3.op<0?$2:op($2,$3.right,$3.op)); }
	| OPDIV factor termp       { $$.op=3;$$.right=($3.op<0?$2:op($2,$3.right,$3.op)); }
	| OPDIVI factor termp      { $$.op=4;$$.right=($3.op<0?$2:op($2,$3.right,$3.op)); }
	| OPMOD factor termp       { $$.op=5;$$.right=($3.op<0?$2:op($2,$3.right,$3.op)); }
	| /* empty string */       { $$.op = -1; }
	;

factor
	: power factorp            { $$ = $2.op < 0? $1 : op($1, $2.right, $2.op); }
	;

factorp
	: OPPOW power factorp      { $$.op=6;$$.right=($3.op<0?$2:op($2,$3.right,$3.op)); }
	| /* empty string */       { $$.op = -1; }
	;

power
	: ID
	| LITNUM
	| OPREST LITNUM            { $$ = -$2; }
	| call
	| LPAR exp RPAR            { $$ = $2; }
	;

call
	: func LPAR exp RPAR       { $$ = func[$1]($3); }
	;

func
	: KWSIN                    { $$ = 0; }
	| KWCOS                    { $$ = 1; }
	| KWTAN                    { $$ = 2; }
	| KWSQRT                   { $$ = 3; }
	| KWLOG                    { $$ = 4; }
	;

%%

int main() {
	yyparse();
	return 0;
}
