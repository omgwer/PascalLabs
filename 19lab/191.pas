PROGRAM Prime(INPUT, OUTPUT);
CONST
  Max = 100;
TYPE
  SetType = SET OF 2 .. MAX;  
VAR
  Sieve: SetType;
  Number, Iterable: INTEGER;   
BEGIN
  Number := 2;
  Sieve := [2 .. 100];
  WHILE (Sieve <> [])
  DO
    BEGIN
      IF (Number IN Sieve)
      THEN
        WRITE(OUTPUT, Number, ' ');        
      Iterable := Number;
      WHILE (Iterable <= Max)
      DO
        BEGIN          
          Sieve := Sieve - [Iterable];
          Iterable := Iterable + Number        
        END;
      Number:= Number + 1 
    END
END.
