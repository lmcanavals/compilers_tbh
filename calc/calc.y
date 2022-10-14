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

%}

%start input

%union { double a; }

%type<a> exp LITNUM

%token EXIT OPSUM OPREST OPPROD OPDIV OPDIVI OPMOD OPPOW
%token ID
%token OPASIGN
%token KWSIN KWCOS KWTAN KWSQRT KWLOG
%token LITNUM
%token LPAR RPAR
%token NL

%%

input
	: /* empty */
	| input line
	;

line
	: NL
	| exp NL           { printf("= %f\n", $1); }
	;

exp
	: LITNUM             { $$ = $1; }
	| exp exp OPSUM      { $$ = $1 + $2; }
	| exp exp OPREST     { $$ = $1 - $2; }
	| exp exp OPPROD     { $$ = $1 * $2; }
	| exp exp OPDIV      { $$ = $1 / $2; }
	| exp exp OPPOW      { $$ = pow($1, $2); }
	;

%%

int main() {
	yyparse();
	return 0;
}
