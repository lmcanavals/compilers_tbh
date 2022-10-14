%{
	/* includes, constantes, etc.*/
%}

DIGIT    [0-9]
ID       [A-Za-z][A-Za-z0-9]*
STRING   '[^']*'

%%

{DIGIT}+    {
            printf("An integer: %s (%d)\n", yytext, atoi(yytext));
            }

{DIGIT}+"."{DIGIT}*        {
            printf("A float: %s (%g)\n", yytext, atof(yytext));
            }

program|uses|if|then|begin|end|procedure|function        {
            printf("A keyword: %s\n", yytext);
            }

{STRING}    printf("A string: %s\n", yytext);

{ID}        printf("An identifier: %s\n", yytext);

"+"|"-"|"*"|"/"   printf( "An operator: %s\n", yytext );

";"         printf("Semicolon\n");

"."         printf("End of program\n");

"{"[^}\n]*"}"     /* eat up one-line comments */

[ \t\n]+          /* eat up whitespace */

.           printf( "Unrecognized character: %s\n", yytext );

%%

int main(int argc, char** argv) {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;

    yylex();

    return 0;
}
