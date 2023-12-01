%{
#include "parser.tab.h"
#include "shared.h"

#include <stdio.h>

%}

%%
[a-zA-Z][a-zA-Z0-9]*   {printf("%s", yytext); return ID;}
[0123456789]+          {printf("%s", yytext); return INTEGER;}
\n                     {return NEWLINE;}
[ \t]                  {printf("%s", yytext);} // print white space and move on.
.                      {
                           printf("%s", yytext);
                           return *yytext;                       
                       }
%%
