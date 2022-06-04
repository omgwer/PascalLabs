Unit IntegerHelper;

INTERFACE
USES
  SharedData;

FUNCTION GetValue(VAR inpFile: Text): INTEGER;

IMPLEMENTATION
VAR
  Ch: CHAR;
  Digit: INTEGER;

PROCEDURE ReadDigit(VAR F: TEXT; VAR Digit: INTEGER);  {читает 1 символ в строке}
BEGIN
  Digit := -1;
  IF NOT EOLN(F) AND NOT EOF(F)
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

FUNCTION GetValue(VAR inpFile: Text): INTEGER;
VAR
  Overflow: BOOLEAN;  
BEGIN
  Overflow := FALSE;
  GetValue := 0;
  IF NOT EOF(inpFile) AND NOT EOLN(inpFile)
  THEN
    READ(inpFile)
  ELSE
    Overflow := TRUE;
  ReadDigit(inpFile, Digit);
  IF (Digit = -1)
  THEN
    GetValue := Digit;  

  WHILE (Digit <> -1) AND NOT Overflow
  DO
    BEGIN    
      IF (GetValue <= ((MAXINT - Digit) DIV 10))
      THEN
        BEGIN
            GetValue := GetValue * 10 + Digit;
            ReadDigit(inpFile, Digit)
        END
      ELSE
        BEGIN          
          Overflow := TRUE;
          GetValue := -2
        END                  
    END 
END;


BEGIN
END.