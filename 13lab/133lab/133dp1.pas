PROGRAM Split(INPUT, OUTPUT); {�������� INPUT � OUTPUT,������� ��������,� ����� ������ ��������}
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;
PROCEDURE CopyOut(VAR F1: TEXT; VAR Ch: CHAR);
BEGIN	
END;

BEGIN
  {��������� INPUT � Odds � Evens}
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
                WRITELN(OUTPUT, Ch, ' - write to Odds');
                Next := 'E'
              END  	
            ELSE
              BEGIN
                WRITELN(OUTPUT, Ch, ' - write to Evens');
                Next := 'O'
              END
          END;
        READLN;
        WRITELN(Odds);
        WRITELN(Evens)
      END;
    WRITELN(Odds);
    WRITELN(Evens);
  CopyOut(Odds,Ch);
  CopyOut(Evens,Ch);
  WRITELN(OUTPUT)
END.
