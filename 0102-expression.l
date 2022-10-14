
NUMBER [0-9]+(.[0-9]+)?(E[+\-]?[0-9]+)?
ID     [A-Za-z_]([A-Za-z_]|[0-9])*
ARIOP  (\+)|(\-)|(\*)|(\/)
RELOP  (<)|(>)|(>=)|(<=)|(==)|(!=)
WS     [ \n\t\r]+

%%

{NUMBER} {
	printf("Number: %s\n", yytext);
}

{ID} {
	printf("Identifier: %s\n", yytext);
}

{ARIOP} {
	printf("Arithmetic operator: %s\n", yytext);
}

{RELOP} {
	printf("Relational operator: %s\n", yytext);
}

{WS} {}

. {
	printf("Unknown token: %s\n", yytext); 
}

%%

int main(int argc, char** argv) {
	++argv, --argc;
	yyin = argc > 0? fopen(argv[0], "r"): stdin;

	yylex();

	return 0;
}

