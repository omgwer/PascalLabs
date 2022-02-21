PROGRAM Split(INPUT, OUTPUT); {Копирует INPUT в OUTPUT,сначала нечетные,а затем четные элементы}
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;

PROCEDURE CopyOut(VAR F1: TEXT; VAR Ch: CHAR);
BEGIN
  RESET(F1);
  WHILE NOT EOF(F1)
  DO
    BEGIN
      WHILE NOT EOLN(F1)
      DO
        BEGIN
          READ(F1, Ch);
          WRITE(OUTPUT, Ch)
        END;
      READLN(F1)
    END      	
END;

BEGIN
  {Разделяет INPUT в Odds и Evens}
  REWRITE(Odds);
  REWRITE(Evens);
    Next := 'O';
    WHILE NOT EOF(INPUT)
    DO
      BEGIN
        WHILE NOT EOLN(INPUT)
        DO
          BEGIN
            READ(INPUT, Ch);
            IF Next = 'O'
            THEN
              BEGIN
                WRITELN(Odds, Ch);
                Next := 'E'
              END  	
            ELSE
              BEGIN
                WRITELN(Evens, Ch);
                Next := 'O'
              END
          END;
        READLN(INPUT);
        WRITELN(Odds);
        WRITELN(Evens)
      END;
    WRITELN(Odds);
    WRITELN(Evens);
  CopyOut(Odds,Ch);
  CopyOut(Evens,Ch);
  WRITELN(OUTPUT)
END.
