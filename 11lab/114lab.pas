PROGRAM Reverse(INPUT, OUTPUT);
VAR
  Ch: CHAR;
  F1, F2: TEXT;
BEGIN
  REWRITE(F1);  
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(INPUT, Ch);      
      IF EOLN(INPUT)
      THEN
        WRITE(OUTPUT, Ch)
      ELSE
        WRITE(F1, Ch)        
    END;
  WRITELN(F1);  
  RESET(F1);    
  WHILE NOT EOLN(F1)
  DO
    BEGIN      
      REWRITE(F2);
      WHILE NOT EOLN(F1)
      DO
        BEGIN               
          READ(F1, Ch);      
          IF EOLN(F1)
          THEN
            WRITE(OUTPUT, Ch)
          ELSE
            WRITE(F2, Ch);
        END;
      RESET(F2);
      REWRITE(F1);
      WHILE NOT EOLN(F2)
      DO
        BEGIN
          READ(F2, Ch);      
            IF EOLN(F2)
            THEN
              WRITE(OUTPUT, Ch)
            ELSE
              WRITE(F1, Ch);
        END;
      RESET(F1)  
    END;
  WRITELN
END.
