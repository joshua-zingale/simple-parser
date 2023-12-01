%{
#include <stdio.h>
#include "shared.h"
%}

%token ID
%token NEWLINE
%token INTEGER

%define parse.error verbose

%%
statements: 
| statements statement NEWLINE {printf("%s", "   --valid\n");}
| statements error NEWLINE {printf("   --%s\n", errorMsg);}
;
statement: expression  
| assignment ';'  
;
assignment: ID '=' expression 
;
expression: term 
| expression '+' term 
| expression '-' term 
;
term: factor
| term '*' factor
| term '/' factor
| term '%' factor
;
factor: ID 
| '(' expression ')' 
;

%%

main(int argc, char **argv)
{
   yyparse();
}

yyerror(char *msg)
{
   errorMsg = msg;
}
