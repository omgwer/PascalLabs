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
        BEGIN
          WRITE(Evens, Ch);       
          Next := 'O';
        END;
      READ(INPUT, Ch)    
    END;
  WRITELN(Odds, '#');
  WRITELN(Evens, '#');
  RESET(Odds);
  READ(Odds, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(OUTPUT, Ch);
      READ(Odds, Ch)
    END;
  RESET(Evens);
  READ(Evens, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(OUTPUT, Ch);
      READ(Evens, Ch)
    END;    
END.
