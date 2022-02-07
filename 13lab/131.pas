PROGRAM RunBubbleSort(INPUT, OUTPUT);
VAR
  F1, F2: TEXT;

PROCEDURE CopyFile(VAR InFile, OutFile: TEXT);  { Копируем из InFile в OutFile } 
VAR 
  Ch: CHAR;
BEGIN   
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)           
    END;
  WRITELN(OutFile)  
END;

BEGIN
	REWRITE(F1);
	CopyFile(INPUT, F1);
	RESET(F1);	
	CopyFile(F1, OUTPUT)
END.
