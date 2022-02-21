PROGRAM CountReverse(INPUT, OUTPUT);
USES
  Count3;
VAR
  V1, V10, V100, Ch1, Ch2, Ch3: CHAR;
BEGIN {CountReverse}
  Start;
  V1 := '0';
  V10 := '0';
  V100 := '0';
    
  IF NOT EOLN(INPUT)
  THEN
    BEGIN
      READ(INPUT, Ch1);
      WRITELN(OUTPUT);
      WRITE('Входные значения - ');
      WRITE(OUTPUT, Ch1)
    END; 
  IF NOT EOLN(INPUT)
  THEN
    BEGIN
      READ(INPUT, Ch2);
      WRITE(OUTPUT, Ch2)
    END;      
  
  WHILE (NOT EOLN(INPUT))
  DO
    BEGIN
      READ(INPUT, Ch3);
      WRITE(OUTPUT, Ch3);	          
		  
	    IF (((Ch2 > Ch1) AND (Ch2 > Ch3)) OR ((Ch2 < Ch1) AND (Ch2 < Ch3)))
	    THEN
	      Bump;
		  Ch1 := Ch2;
		  Ch2 := Ch3 
    END;
  
  Value(V100, V10, V1);
  WRITELN(OUTPUT);
  WRITELN('Количество реверсов - ', V100, V10, V1)
END. {CountReverse}
