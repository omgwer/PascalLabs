PROGRAM SarahRevere(INPUT, OUTPUT);
CONST
  IndexOfStart = 1;
  ArrayLength = 4;  
  DidntSay = 'Sarah didn''t say';
  SarahSay = 'The British coming by ';  
TYPE
  Arr = ARRAY [IndexOfStart .. ArrayLength] OF CHAR;    
VAR
  WindowArray : Arr;
  IsFind : BOOLEAN;
  I : INTEGER;
  ResultWay : STRING; 

BEGIN {SarahRevere}
  IsFind := FALSE;
  I := IndexOfStart;  
  WHILE NOT EOLN(INPUT) AND NOT IsFind
  DO
    BEGIN
      READ(INPUT, WindowArray[I]);
      I := I + IndexOfStart;
      IF ((I <= ArrayLength) AND NOT EOLN(INPUT))
      THEN
        Continue;
      I := I - IndexOfStart;  

      IF ((WindowArray[1] + WindowArray[2] + WindowArray[3]) = 'sea')
      THEN
        BEGIN
          ResultWay := 'sea';
          IsFind := TRUE
        END    
      ELSE IF ((WindowArray[1] + WindowArray[2] + WindowArray[3]) = 'air')
      THEN
        BEGIN
          ResultWay := 'air';
          IsFind := TRUE
        END
      ELSE IF ((WindowArray[1] + WindowArray[2] + WindowArray[3] + WindowArray[4]) = 'land')
      THEN
        BEGIN
          ResultWay := 'land';
          IsFind := TRUE
        END;    

      // Window strafe
      WindowArray[1] := WindowArray[2];
      WindowArray[2] := WindowArray[3];
      WindowArray[3] := WindowArray[4];      
    END;
  // Print result  
  IF (NOT IsFind)
  THEN
    WRITELN(OUTPUT, DidntSay)
  ELSE
    WRITELN(OUTPUT, SarahSay + ResultWay)
END. {Sarah revere}
