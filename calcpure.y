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

%token NUM

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
	: NUM
	| exp exp '+'
	| exp exp '-'
	| exp exp '*'
	| exp exp '/'
	| exp exp '^'
	;

%%

int yylex() {
	int c;

	while ((c = getchar()) == ' ' || c == '\t');
	if (c == '.' || c >= '0' && c <= '9') {
		ungetc(c, stdin);
		scanf("%lf", &yylval);
		return NUM;
	}
	if  (c == EOF) {
		return 0;
	}

	return c;
}

int main() {
	yyparse();
	return 0;
}
