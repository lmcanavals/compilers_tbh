%{

#define LINT 1
#define WORD 2

%}

LINT [0-9]+
WORD [A-Za-z]+

%%

{LINT} { return LINT; }
{WORD} { return WORD; }
[ \n\r\t] { /**/ }
.      { return -1; }

%%

int main(int argc, char** argv) {
	++argv, --argc;  /* skip over program name */
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


