%{

#include "calc.h"
#include "calc.tab.h"

%}

NUM ([0-9]+\.[0-9]+|([0-9]+\.)|(\.[0-9]+)|([0-9]+))([Ee][+\-]?[0-9]+)?
VAR [A-Za-z_][A-Za-z_0-9]*
OP [+\-*/=\^()\n]

%%

{OP}          { return yytext[0]; }
{VAR}         {
	symrec* s = getsym(yytext);
	if (!s) s = putsym(yytext, VAR);
	yylval.VAR = s;
	return VAR; }
{NUM}         { yylval.NUM = atof(yytext); return NUM; }
[ \t]         ;
.             ; /* unknown token */

%%

/* scanner para se usado con bison */
