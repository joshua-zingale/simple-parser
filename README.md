Author: Joshua Zingale (824996218)
Edoras Account: cssc2640
Class: CS 530
Assignmen: Project #3
File name: README.md

# PARSER
This project is a simple parser that accepts assignments and expressions,
specifying errors when they are encountered.

## FILE MANIFEST:
- Makefile -- Compile routine
- README.md -- Contains information about this project
- lex.yy.c -- Flex generated scanner code
- out.txt -- Canvas provided ideal output for test input
- parser.tab.c -- Lightly modified code generated by Bison for syntactic analysis
- parser.tab.h -- Bison generated code for syntactic analysis
- parser.y -- The source code for the Bison generated code
- scanner.l -- The source code for the Flex generated code
- shared.h -- Shared variable between Flex and Bison
- test.txt -- Canvas provided input tests

## COMPILE INSTRUCTIONS
Run "make" in this directory to generate the parser.
The parser will compile to be an executable with the name "parser".

## OPERATING INSTRUCTIONS
After the executable has been created (cf. with compile instructions),
The parser executable may be run. The parser executable accepts to arguments.
The parser functions by reading from standard input and then outputs to the
standard output. For example,
```bash
(Run executable) || ./parser 
(input string) || three = one + two2;
(output) || three = one + two2; --valid
```

or you can use a redirect to read from a file:


```bash
(Run executable) || ./parser < test.txt 
(OUTPUT)
good = one1 + two2 - three3 / four4 ; --valid
good = one1 / two2 * three3 ; --valid
good = one1 * two2 + three3 ; --valid
good = ONE + twenty - three3 ; --valid
good = old * thirty2 / b567 ; --valid
good * i8766e98e + bignum --valid
good % a4 + bignum --valid
good * one - two2 / three3 --valid
good = four4 * two2 * three3 ; --valid
good * (one + two) * three --valid
good * one + two * three / four - five + six --valid
good * one - two2 / three3 --valid
bad = = one1 + two2 - three3 / four4 ; --syntax error, unexpected '=', expecting ID or '('
bad = one1 + two2 - three3 / four4 --syntax error, unexpected NEWLINE, expecting ';'
bad = 1 + - two2 - three3 / four4 ; --syntax error, unexpected INTEGER, expecting ID or '('
bad = one1 + two2 ? three3 / four4 ; --syntax error, unexpected '?', expecting ';'
bad = one1 + 24 - three3 : --syntax error, unexpected INTEGER, expecting ID or '('
bad +- delta --syntax error, unexpected '-', expecting ID or '('
bad + - delta --syntax error, unexpected '-', expecting ID or '('
bad / min = fourth ; --syntax error, unexpected '=', expecting NEWLINE
bad = a ! b --syntax error, unexpected '!', expecting ';'
bad * 2two + 3three --syntax error, unexpected INTEGER, expecting ID or '('
```

Therefore, to test my parser on an abritrary file 'file.txt', run
```bash
./parser < file.txt
```

## GRAMMAR
Here is the grammar in BNF for a single statement, i.e. single line:
```bash
statement: expression  
| assignment ';'  

assignment: ID '=' expression 

expression: term 
| expression '+' term 
| expression '-' term 

term: factor
| term '*' factor
| term '/' factor
| term '%' factor

factor: ID 
| '(' expression ')' 
```

## DESIGN DECISIONS
Input is received from standard input and ouput goes to standard output.
This allows for flexability on the user's end, allowing him to redirect them
as he may desire.

A valid statement, in the output, is appended on its line with " --valid".
An invalid statement, in the output, is appended on its line with a syntax error message
explaining the first error detected.

To implement this parser, I wrote a scanner with Flex that can detect ID's and INTEGER's,
but left the parsing of operators and of other tokens to Bison.
In Bison, I defined a grammar that accepts a file with one assignment or expression per line.
When a statement, either an assignment or expression, is read, it is printed along with a valid indicator.
When a statement is malformed, an error message is printed.
Either case is handeled by Bison's ability to run code upon discovery of a rule, including an error.
The code generated by Bison did not generate syntax errors that were super useful
because unknown tokens would always appear in the error message as '$undefined'.
I therefore slightly modified the Bison generated code parser.tab.c such that the error messages
display the character that caused the first error.
For this reason, that I modified the code, the Bison and Flex source code are precompiled for this submission.

## Extra Features
While they are not accepted in valid statements, INTEGER tokens are detected by the scanner,
which leads to better error messages. For example,
```bash
bad = one1 + 24 - three3 : --syntax error, unexpected INTEGER, expecting ID or '('
```
identifies that an unexpected INTEGER was detected, not just that an unexpected '2' was detected.


## KNOWN DEFICIENCIES OR BUGS
There is none of which I am aware.

## LESSONS LEARNED
Before this project, I had used neither Flex nor Bison; but I now understand how to use the tools.
Since I had to modify the output code of Bison to imrpove the error messages,
I had to learn a decent bit about how Bison functions, i.e. how the code is layed out.
This learning of the Bison code also gave me more epxerience modifying code that I did not write myself.
