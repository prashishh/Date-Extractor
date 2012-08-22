Date Extractor using lex and yacc.

This was a small task given to us in our Information Retrieval Class. Not a complete version, can be used as a foundation for a better date extractor.

To compile:
  flex date.lex 
  yacc -d date.y 
  ./a.out test.txt

