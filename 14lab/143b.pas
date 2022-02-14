PROGRAM ReverseSort(INPUT, OUTPUT);
VAR
  FileToSort: TEXT;

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

PROCEDURE RecursiveSort(VAR F1: Text);
VAR  
  F2, F3: TEXT;
  Ch: CHAR;

  {Разбивает F1 на F2 и F3} 
  PROCEDURE Split(VAR F1, F2, F3: TEXT);
  VAR 
    Ch, Switch: CHAR;
  BEGIN {Split}
    RESET(F1);
    REWRITE(F2);
    REWRITE(F3);    

    Switch := '2';
    WHILE NOT (EOLN(F1))
    DO
      BEGIN
        READ(F1, Ch);
        IF (Switch = '2')
        THEN
          BEGIN
            WRITE(F2, Ch);
            Switch := '3'
          END
        ELSE
          BEGIN
            WRITE(F3, Ch);
            Switch := '2'
          END
      END;
    WRITELN(F2);
    WRITELN(F3)
  END; {Split}

  PROCEDURE Merge(VAR F1, F2, F3: TEXT); 
  {Сливает F2, F3 в F1  в сортированном порядке}
  VAR 
    Ch2, Ch3: CHAR;
  BEGIN {Merge}
    RESET(F2);
    RESET(F3);
    REWRITE(F1);   
    
    READ(F2, Ch2);    
    READ(F3, Ch3);
      

    WHILE (NOT(EOLN(F2))) AND (NOT(EOLN(F3)))
    DO
      BEGIN
        IF Ch2 < CH3
        THEN 
          BEGIN
            WRITE(F1, Ch2);
            READ(F2, Ch2)
          END
        ELSE
          BEGIN
            WRITE(F1, Ch3);
            READ(F3, Ch3)
          END
      END;

    


        

    WHILE NOT (EOLN(F2)) {копировать остаток F2 в F1}
    DO
      BEGIN
        WRITE(F1, Ch2);
        READ(F2, Ch2)
      END; 
    WHILE NOT (EOLN(F3)) {копировать остаток F3 в F1}
    DO
      BEGIN
        WRITE(F1, Ch3);
        READ(F3, Ch3)
      END;      
    WRITELN(F1)
  END; {Merge}

BEGIN
  {RecursiveSort}
  RESET(F1);    
  IF NOT (EOLN(F1))
  THEN
    BEGIN
      IF NOT (EOLN(F1))
      THEN {Файл имеет как минимум 2 символа}
        BEGIN          
          Split(F1, F2, F3);
          {RecursiveSort(F2);
          RecursiveSort(F3);}
          Merge(F1, F2, F3);
          RESET(F2);
          RESET(F3);
          RESET(F1);          
          CopyFile(F2, OUTPUT);          
          CopyFile(F3, OUTPUT);
          CopyFile(F1, OUTPUT);
        END
    END
END;   {RecursiveSort}

BEGIN
  REWRITE(FileToSort);
  CopyFile(INPUT, FileToSort); 
  RESET(FileToSort);   
  RecursiveSort(FileToSort);   
END.
