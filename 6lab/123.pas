PROGRAM Split(INPUT, OUTPUT);
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;
BEGIN {Split}
  Next := 'O';
  REWRITE(Odds);
  REWRITE(Evens);
  READ(INPUT, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN      
      IF Next = 'O'
      THEN
        BEGIN
          WRITE(Odds, Ch);
          Next := 'E'
        END           
      ELSE {evens}
        Next := 'O';
    END;
  WRITELN(Odds, '#');
  RESET(Odds);
  READ(Odds, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(OUTPUT, Ch);
      READ(Odds, Ch)
    END;
  WRITELN(OUTPUT)  
END.
