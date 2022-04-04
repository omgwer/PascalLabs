PROGRAM Stat(INPUT, OUTPUT);
USES
  Base;

VAR
  NumberCount, MinNumber, MaxNumber, Average, NumbersSumm, IterableNumber, Accuracy: INTEGER;
  Overflow : BOOLEAN;

BEGIN
  Accuracy := 2; // точность для среднего
  NumberCount := 0;
  MinNumber := MAXINT;
  MaxNumber := 0;  
  NumbersSumm := 0;
  Overflow := FALSE; 

  WHILE NOT EOLN(INPUT) AND NOT Overflow
  DO
    BEGIN
      ReadNumber(INPUT, IterableNumber); // Читаем первое число        
      IF (IterableNumber >= 0 )
      THEN
        BEGIN
          NumberCount := NumberCount + 1;
          IF (MinNumber > IterableNumber)
          THEN
            MinNumber := IterableNumber;
          IF (MaxNumber < IterableNumber)
          THEN
            MaxNumber := IterableNumber;
          SaveInc(NumbersSumm, IterableNumber);
          IF (NumbersSumm < 0)
          THEN
            Overflow := TRUE;
        END
      ELSE
        Overflow := TRUE;  
    END;
    // Получив необходимые данные получаем среднее значение
    
  IF (NOT Overflow)
  THEN
    BEGIN
    WRITELN("Numbers count : ", NumberCount);
    WRITELN("Min number : ", MinNumber);
    WRITELN("Max number : ", MaxNumber);
    WRITELN("Arrange is : ",NumbersSumm DIV NumberCount, '.', (NumbersSumm MOD NumberCount * 100 DIV NumberCount DIV 10), (NumbersSumm MOD NumberCount * 100 DIV NumberCount MOD 10) )
    END
  ELSE
    WRITELN("ERROR WITH INPUT STRING");
END.
