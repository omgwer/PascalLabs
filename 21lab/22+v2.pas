PROGRAM SarahRevere(INPUT, OUTPUT);
VAR
  W1, W2, W3, W4 : CHAR;
  IsFind : BOOLEAN;
BEGIN {SarahRevere}
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';    
  WHILE NOT EOLN(INPUT) AND NOT IsFind
  DO
    BEGIN
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(INPUT, W4);
      IsFind := TRUE;          
      IF ((W1 + W2 + W3 + W4) = 'land')
      THEN     
        WRITELN('The British are coming by land.')   
      ELSE 
        IF ((W2 + W3 + W4) = 'sea')      
        THEN 
          WRITELN('The British are coming by sea.')
        ELSE 
          IF ((W2 + W3 + W4) = 'air')     
          THEN
            WRITELN('The British are coming by air.')
          ELSE
            IsFind := FALSE
    END;  
  IF (NOT IsFind)
  THEN          
    WRITELN('Sarah didn''t say')
END. {SarahRevere}
  
