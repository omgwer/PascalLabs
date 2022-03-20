UNIT Base;

INTERFACE

{PROCEDURE GetNumberCount(VAR NumberCount);
PROCEDURE GetMinNumber(VAR MinNumber);
PROCEDURE GetMaxNumber(VAR MaxNumber); }
PROCEDURE GetAverage(VAR Average: INTEGER);

IMPLEMENTATION
VAR
  Ch: CHAR;
  Digit, mNumberCount, mMinNumber, mMaxNumber, mAverage: INTEGER;

PROCEDURE ReadDigit(VAR F: TEXT; VAR Digit: INTEGER);  {читает 1 символ в строке}
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

PROCEDURE ReadNumber(VAR F: TEXT; VAR N: INTEGER);{Преобразует строку цифр из файла до первого нецифрового символа,  в соответствующее целое число N}
VAR
  Overflow: BOOLEAN;
BEGIN
  Overflow := FALSE;
  N := 0;
  ReadDigit(INPUT, Digit);
  IF (Digit = -1)
  THEN
    N := Digit;  

  WHILE (Digit <> -1) AND NOT Overflow
  DO
    BEGIN    
      IF (N <= ((MAXINT - Digit) DIV 10))
      THEN
        BEGIN
            N := N * 10 + Digit;
            ReadDigit(INPUT, Digit)
        END
      ELSE
        BEGIN          
          Overflow := TRUE;
          N := -2
        END                  
    END 
END;

PROCEDURE GetAverage(VAR Average: INTEGER);
BEGIN  
  Average := mAverage;
END;




BEGIN
END.