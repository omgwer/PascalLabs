PROGRAM Split(INPUT, OUTPUT);
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;
BEGIN {Split}
  Next := 'O';
  READ(INPUT, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(OUTPUT, Next);
      IF Next = 'O'
      THEN                
        Next := 'E'
      ELSE        
        Next := 'O';
      READ(INPUT, Ch)    
    END
END.

