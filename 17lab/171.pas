PROGRAM ReadEndSummDigits(INPUT, OUTPUT);
VAR
  Digit, Result: INTEGER;
  Ch: CHAR;

PROCEDURE ReadDigit(VAR F: TEXT; VAR Digit: INTEGER);
BEGIN
  Digit := -1;
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch);
      IF Ch = '0' THEN Digit := 0 ELSE
      IF Ch = '1' THEN Digit := 1 ELSE
      IF Ch = '2' THEN Digit := 2 ELSE
      IF Ch = '3' THEN Digit := 3 ELSE
      IF Ch = '4' THEN Digit := 4 ELSE
      IF Ch = '5' THEN Digit := 5 ELSE
      IF Ch = '6' THEN Digit := 6 ELSE
      IF Ch = '7' THEN Digit := 7 ELSE
      IF Ch = '8' THEN Digit := 8 ELSE
      IF Ch = '9' THEN Digit := 9        
    END     
END;

BEGIN
  Result := 0;
  ReadDigit(INPUT, Digit);
    
  WHILE (Digit <> -1)
  DO
    BEGIN    
      Result := Result + Digit;
      ReadDigit(INPUT, Digit)
    END;
    WRITELN(OUTPUT, 'Result = ', Result)
END.
