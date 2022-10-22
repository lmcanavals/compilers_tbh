%{

#include "calc.tab.h"

%}

LITNUM ([0-9]+\.[0-9]+|([0-9]+\.)|(\.[0-9]+)|([0-9]+))([Ee][+\-]?[0-9]+)?
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
{ID}          { strcpy(yylval.name, yytext); return ID; }
{LITNUM}      { yylval.num = atof(yytext); return LITNUM; }
[\n]          { return NL; }
[ \t]         ;
.             ; /* unknown token */

%%

/* scanner para se usado con bison */
