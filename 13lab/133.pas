PROGRAM RunBubbleSort(INPUT, OUTPUT);

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

PROCEDURE CopySwap(VAR F1, F2: TEXT; VAR Sorted: CHAR);
VAR
  Ch1, Ch2: CHAR;
BEGIN
  Sorted := 'Y';
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch1);
      WHILE NOT EOLN(F1)
      DO { По крайней мере два символа остается для Ch1,Ch2 }
        BEGIN
          READ(F1, Ch2);           
          IF Ch1 <= Ch2
          THEN
            BEGIN
              WRITE(F2, Ch1);
              Ch1 := Ch2
            END
          ELSE
            BEGIN
              WRITE(F2, Ch2);
              Sorted := 'N'
            END
        END;        
      WRITELN(F2, Ch1) { Выводим последний символ в F2 }
    END 
END;

PROCEDURE BubbleSort(VAR InFile, OutFile: TEXT);
VAR
  F1, F2: TEXT;
  Sorted: CHAR;
BEGIN
  RESET(InFile);
  REWRITE(F1);
  CopyFile(InFile, F1);  
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      { Копируем F1 в F2,проверяя отсортированность
       и переставляя первые соседние символы по порядку}
      RESET(F1);
      REWRITE(F2);
      CopySwap(F1, F2, Sorted);
      RESET(F2);
      REWRITE(F1);
      CopyFile(F2, F1);
      WRITELN(F1)
    END;
  RESET(F1);
  REWRITE(OutFile);  
  CopyFile(F1, OutFile)
END;

BEGIN
	BubbleSort(INPUT, OUTPUT)
END.
