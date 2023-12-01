

main: parser.tab.c lex.yy.c
	cc parser.tab.c lex.yy.c -lfl -o parser
clean:
	rm -f parser
