%{

#include "calc.tab.h"

enum Token {
	EXIT, OPSUM, OPREST, OPPROD, OPDIV, OPDIVI, OPMOD, OPPOW,
	ID,
	OPASIGN,
	KWSIN, KWCOS, KWTAN, KWSQRT, KWLOG,
	LITNUM,
	LPAR, RPAR
};

%}

LITNUM ([+\-])?([0-9]+\.[0-9]+|([0-9]+\.)|(\.[0-9]+)|([0-9]+))([Ee][+\-]?[0-9]+)?
ID [A-Za-z_][A-Za-z_0-9]*

%%

"+"           { return OPSUM; }
"-"           { return OPREST; }
"*"           { return OPPROD; }
"/"           { return OPDIV; }
"\\"          { return OPDIVI; }
"%"           { return OPMOD; }
"^"           { return OPPOW; }
"="           { return OPASIGN; }
"("           { return LPAR; }
")"           { return RPAR; }
sin           { return KWSIN; }
cos           { return KWCOS; }
tan           { return KWTAN; }
sqrt          { return KWSQRT; }
log           { return KWLOG; }
{ID}          { return ID; }
{LITNUM}      { return LITNUM; }
[ \n\r\t]     { /* ignoring this */ }
.             { return -1; /* unknown token */ }

%%

/*
int main(int argc, char** argv) {
	++argv, --argc;
	if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
	else
		yyin = stdin;

	int token;
	while (token = yylex()) {
		printf("Token: %d (%s)\n", token, yytext);
	}

	return 0;
}

*/
