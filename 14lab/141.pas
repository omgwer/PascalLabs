PROGRAM CopyTwice(INPUT, OUTPUT);

PROCEDURE Reverse(VAR INPUT: TEXT);
VAR
  Ch: CHAR;
BEGIN
  IF NOT EOLN(INPUT)
  THEN
    BEGIN
      READ(INPUT, Ch);
      REVERSE(INPUT);
      WRITE(OUTPUT, Ch)
    END
END;

BEGIN
  Reverse(INPUT);
  WRITELN(OUTPUT)
END.
