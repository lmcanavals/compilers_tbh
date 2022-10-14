/* cometarios */

%{

/* código C, importar scanner */
#include <math.h>
#include <ctype.h>
#include <stdio.h>

int yylex();

int yyerror(char* s) {
	printf("%s\n", s);
}

double (*func[5])(double) = {&sin, &cos, &tan, &sqrt, &log};

%}

%start start

%union {
	char name[100];
	double num;
	int func;
}

%type<num> exp expp term termp factor factorp power call LITNUM
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
	| exp NL             { printf("= %f\n", $1); }
	| ID NL
	;

assign
	: ID OPASIGN exp
	;

exp
	: term expp
	;

expp
	: OPSUM term expp
	| OPREST term expp
	| /* empty string */
	;

term
	: factor termp
	;

termp
	: OPPROD factor termp
	| OPDIV factor termp
	| OPDIVI factor termp
	| OPMOD factor termp
	| /* empty string */
	;

factor
	: power factorp
	;

factorp
	: OPPOW power factorp
	| /* empty string */
	;

power
	: ID
	| LITNUM
	| OPREST LITNUM
	| call
	| LPAR exp RPAR
	;

call
	: func LPAR exp RPAR       { $$ = func[$1]($3); }
	;

func
	: KWSIN
	| KWCOS
	| KWTAN
	| KWLOG
	| KWSQRT
	;

%%

int main() {
	yyparse();
	return 0;
}
