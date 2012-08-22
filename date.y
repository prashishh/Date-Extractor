
%{

#include <stdio.h>
#include <stdlib.h>
#include "lex.yy.c"
#include <ctype.h>

void push( char *s );
int pop( char *r );
void empty();

extern int yylex();
extern int yyparse();
extern FILE *yyin;

%}


%union{
        char *str;
}


// define type (string) of terminals
%token <str> MONTHS COMMA ST RD TH ND OF DELIM
%token <str> NUM1 NUM2 NUM3 YEAR
%token <str> MONST MONND DTST DTND MONRD DTRD

// define type(string) of non-terminals
%type <str> num1 num2 del yr yr2 mon com

// define mainprog as initial grammar
%start mainprog
%%

// recursive or non-recursive
mainprog : S0 mainprog
	|  S0
	;

// various date patterns defined
S0	: S1
	| S2
	| S6
	| S7 
	| error
	;

// pattern with format DD[del]MM[del]YYYY or DD[del]MM[del]YY
S1	: num1 del num1 del yr		{ push($2); if(pop($4)) { printf("Date Accepted: %s%s%s%s%s\n", $1, $2, $3, $4, $5 ); } }
	| num2 del num1 del yr		{ push($2); if(pop($4)) { printf("Date Accepted: %s%s%s%s%s\n", $1, $2, $3, $4, $5 ); } }
	| num1 del num1 del yr2		{ push($2); if(pop($4)) { printf("Date Accepted: %s%s%s%s%s\n", $1, $2, $3, $4, $5 ); } }
	| num2 del num1 del yr2		{ push($2); if(pop($4)) { printf("Date Accepted: %s%s%s%s%s\n", $1, $2, $3, $4, $5 ); } }
	;

// pattern with format YYYY[del]MM[del]DD
S2	: yr del num1 del num1		{ push($2); if(pop($4)) { printf("Date Accepted: %s%s%s%s%s\n", $1, $2, $3, $4, $5 ); } }
	| yr del num1 del num2		{ push($2); if(pop($4)) { printf("Date Accepted: %s%s%s%s%s\n", $1, $2, $3, $4, $5 ); } }
	;

// pattern with format 1st Jan 2012 or 22nd April 2013
S6	:  DTST ST mon yr		{ printf("Date Accepted: %s%s %s %s\n", $1, $2, $3, $4 ); } 
	|  MONST ST mon yr 		{ printf("Date Accepted: %s%s %s %s\n", $1, $2, $3, $4 ); } 
	|  MONND ND mon yr 		{ printf("Date Accepted: %s%s %s %s\n", $1, $2, $3, $4 ); } 
	|  MONRD RD mon yr 		{ printf("Date Accepted: %s%s %s %s\n", $1, $2, $3, $4 ); } 
	|  DTND ND mon yr 		{ printf("Date Accepted: %s%s %s %s\n", $1, $2, $3, $4 ); } 
	|  DTRD RD mon yr 		{ printf("Date Accepted: %s%s %s %s\n", $1, $2, $3, $4 ); } 
	|  num1 TH mon yr 		{ printf("Date Accepted: %s%s %s %s\n", $1, $2, $3, $4 ); } 
	|  num2 TH mon yr 		{ printf("Date Accepted: %s%s %s %s\n", $1, $2, $3, $4 ); } 
	;
	
// pattern with format 1st January, 2012 or 3rd July, 1990
S7	:  DTST ST OF mon com yr 		{ printf("Date Accepted: %s%s %s %s%s %s\n", $1, $2, $3, $4, $5, $6 ); } 
	|  MONST ST OF mon com yr 		{ printf("Date Accepted: %s%s %s %s%s %s\n", $1, $2, $3, $4, $5, $6   ); } 
	|  MONND ND OF mon com yr 		{ printf("Date Accepted: %s%s %s %s%s %s\n", $1, $2, $3, $4, $5, $6   ); } 
	|  MONRD RD OF  mon com yr 		{ printf("Date Accepted: %s%s %s %s%s %s\n", $1, $2, $3, $4, $5, $6   ); } 
	|  DTND ND OF mon com yr 		{ printf("Date Accepted: %s%s %s %s%s %s\n", $1, $2, $3, $4, $5, $6   ); } 
	|  DTRD RD OF mon com yr 		{ printf("Date Accepted: %s%s %s %s%s %s\n", $1, $2, $3, $4, $5, $6   ); } 
	|  num1 TH OF mon com yr 		{ printf("Date Accepted: %s%s %s %s%s %s\n", $1, $2, $3, $4, $5, $6   ); } 
	|  num2 TH OF mon com yr 		{ printf("Date Accepted: %s%s %s %s%s %s\n", $1, $2, $3, $4, $5, $6   ); } 
	;

// takes in date - DTST for date with 'st', ND for date with 'nd' etc
// date takes in number from 13-31
num2	: DTST  { $$ = strdup(yytext); }
	| DTRD { $$ = strdup(yytext); }
	| DTND { $$ = strdup(yytext); }
	| NUM2 { $$ = strdup(yytext); }

	;

// takes in month - DTST for month with 'st', ND for month with 'nd' etc
// month takes in number from 1-12
num1	: MONST { $$ = strdup(yytext); }
	| MONND { $$ = strdup(yytext); }
	| MONRD { $$ = strdup(yytext); }
	| NUM1  { $$ = strdup(yytext); }
	;

// all the delims
del	: DELIM { $$ = strdup(yytext); }
	| COMMA { $$ = strdup(yytext); }
	;

// month is words
mon	: MONTHS { $$ = strdup(yytext); }
	;

// year in format XXXX
yr	: YEAR { $$ = strdup(yytext); }
	;

// year in format XX
yr2	: NUM3 { $$ = strdup(yytext); }
	| NUM2 { $$ = strdup(yytext); }
	| NUM1 { $$ = strdup(yytext); }
	;

com	: COMMA { $$ = strdup(yytext); }
	;

%%


char temp[1];

int main(int argc, char *argv[])
{
	
	yyin = fopen(argv[1], "r");
	
   if(!yyparse())
		printf("\nParsing complete\n");
	else
		printf("\nParsing failed\n");
	
	fclose(yyin);
    return 0;
}          

yyerror(char *s)
{
	printf("%d: %s at %s\n", yylineno, s, yytext);

}

yywrap(){
	return 1;
}

// checks whether same delim is used in a date eg. 12/12/90 but not 12/12-90

void push( char *s ) {
	strncpy(temp, s, sizeof temp );
	
}

int pop( char *r ) {
	if ( strcmp(temp, r) )
		return 0;
	else
		return 1;
}

