PROGRAM PrintSymbolChar(INPUT, OUTPUT);
USES
  SymbolConverter;
VAR
  NewTest: XSet;
  Ch: CHAR;

BEGIN
  WHILE NOT EOLN
  DO
    BEGIN
      READ(INPUT, Ch); 
      PrintLetterSet(Letter2Set(Ch));
      WRITELN      
    END  
END.