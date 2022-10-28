/* cometarios */

%{

/* código C, importar scanner */
#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
#include <math.h>

#include "calc.h"

int yylex(void);
void yyerror(char const* s) {
	fprintf(stderr, "%s\n", s);
}

%}

%define api.value.type union
%token <double> NUM
%token <symrec*> VAR FUN
%nterm <double> exp

%precedence '='
%left '-' '+'
%left '*' '/'
%precedence NEG
%right '^'

%verbose

%define parse.trace

%printer { fprintf(yyo, "%s", $$->name); } VAR;
%printer { fprintf(yyo, "%s()", $$->name); } FUN;
%printer { fprintf(yyo, "%g", $$); } <double>;

%%

input
	: %empty
	| input line
	;

line
	: '\n'
	| exp '\n'                 { printf("= %f\n", $1); }
	| error '\n'               { yyerrok; }
	;

exp
	: NUM
	| VAR                      {
		if ($1->init)
			$$ = $1->value.var;
		else {
			yyerror("undef var");
			exit(1);
		}
	}
	| VAR '=' exp              { $$ = $3; $1->value.var = $3; $1->init = 1; }
	| FUN '(' exp ')'          { $$ = $1->value.fun($3); }
	| exp '+' exp              { $$ = $1 + $3; }
	| exp '-' exp              { $$ = $1 - $3; }
	| exp '*' exp              { $$ = $1 * $3; }
	| exp '/' exp              { $$ = $1 / $3; }
	| '-' exp %prec NEG        { $$ = -$2; }
	| exp '^' exp              { $$ = pow($1, $3); }
	| '(' exp ')'              { $$ = $2; }
	;

%%

struct init {
	char const* name;
	func_t* fun;
};

struct init const funs[] = {
	{ "atan", atan },
	{ "cos", cos },
	{ "exp", exp },
	{ "ln", log },
	{ "sin", sin },
	{ "sqrt", sqrt },
	{ 0, 0 },
};

symrec* sym_table;

static void init_table(void) {
	for (int i = 0; funs[i].name; ++i) {
		symrec* ptr = putsym(funs[i].name, FUN);
		ptr->value.fun = funs[i].fun;
		ptr->init = 1;
	}
}

#include <assert.h>
#include <stdlib.h>
#include <string.h>

symrec* putsym(char const* name, int sym_type) {
	symrec* res = (symrec*) malloc(sizeof(symrec));
	res->name = strdup(name);
	res->type = sym_type;
	res->value.var = 0;
	res->init = 0;
	res->next = sym_table;
	sym_table = res;
	return res;
}

symrec* getsym(char const* name) {
	for (symrec* p = sym_table; p; p = p->next) {
		if (strcmp(p->name, name) == 0) {
			return p;
		}
	}
	return NULL;
}

int main(int argc, char const* argv[]) {
	if (argc == 2 && strcmp(argv[1], "-p") == 0) {
		yydebug = 1;
	}
	init_table();
	return yyparse();
}
