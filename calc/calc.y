/* cometarios */

%{

/* código C, importar scanner */
#include <math.h>
#include <ctype.h>
#include <stdio.h>

#define YYSTYPE double

int yylex();

int yyerror(char* s) {
	printf("%s\n", s);
}

%}

%token EXIT OPSUM OPREST OPPROD OPDIV OPDIVI OPMOD OPPOW
%token ID
%token OPASIGN
%token KWSIN KWCOS KWTAN KWSQRT KWLOG
%token LITNUM
%token LPAR RPAR

%%

input
	: /* empty */
	| input line
	;

line
	: '\n'
	| exp '\n'
	;

exp
	: LITNUM
	| exp exp OPSUM
	| exp exp OPREST
	| exp exp OPPROD
	| exp exp OPDIV
	| exp exp OPPOW
	;

%%

int main() {
	yyparse();
	return 0;
}
