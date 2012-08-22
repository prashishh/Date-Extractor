%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"

%}

alpha	[a-zA-Z]
digit	[0-9]

%%
[ \t]				 {}
[ \n]			  { yylineno = yylineno + 1; }
[0][1]|[1]			 {  yylval.str = strdup(yytext); return MONST; }
[2][1]|[3][1]			 {  yylval.str = strdup(yytext); return DTST; }
[0][2]|[2]			 {  yylval.str = strdup(yytext); return MONND; }
[2][2]				 {  yylval.str = strdup(yytext); return DTND; }
[0][3]|[3]			 {  yylval.str = strdup(yytext); return MONRD; }
[2][3]				 {  yylval.str = strdup(yytext); return DTRD; }
[0][0-9]|[1][0-2]		 {  yylval.str = strdup(yytext); return NUM1; }
[1][3-9]|[2][0-9]|[3][0-1]	 {  yylval.str = strdup(yytext); return NUM2; }
[3][2-9]|[4-9][0-9]		 {  yylval.str = strdup(yytext); return NUM3; }
[1-2][0-9][0-9][0-9]	 	 {  yylval.str = strdup(yytext);  return YEAR; }
jan|feb|mar|apr|may|june|july|aug|sept|oct|nov|dec	 {  yylval.str = strdup(yytext); return MONTHS; }
JAN|FEB|MAR|APR|MAY|JUNE|JULY|AUG|SEPT|OCT|NOV|DEC	{  yylval.str = strdup(yytext); return MONTHS; }
Jan|Feb|Mar|Apr|May|June|July|Aug|Sept|Oct|Nov|Dec	{  yylval.str = strdup(yytext); return MONTHS; }
January|February|March|April|May|June|July|August|September|November|December	{  yylval.str = strdup(yytext); return MONTHS; }
"st"|"ST"		 	{  yylval.str = strdup(yytext); return ST; }
"nd"|"ND"			{  yylval.str = strdup(yytext); return ND; }
"rd"|"RD"			{  yylval.str = strdup(yytext); return RD; }
"th"|"TH"			{  yylval.str = strdup(yytext); return TH; }
"of"|"OF"			{  yylval.str = strdup(yytext); return OF; }
"/"|"."|"-"|"\\"		{  yylval.str = strdup(yytext); return DELIM; }
","				{  yylval.str = strdup(yytext); return COMMA; }
{alpha}*			{}
{digit}*			{}
.           			return yytext[0];
%%

