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
  
  PROCEDURE Split(VAR F1, F2, F3: TEXT); {Разбивает F1 на F2 и F3} 
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

  PROCEDURE Merge(VAR F1, F2, F3: TEXT); {Сливает F2, F3 в F1  в сортированном порядке}  
  VAR 
    Ch2, Ch3: CHAR;
  BEGIN {Merge}
    RESET(F2);
    RESET(F3);
    REWRITE(F1);
    READ(F2, Ch2);
    READ(F3, Ch3);

    IF EOLN(F2) AND EOLN(F3)
    THEN
      IF Ch2 < Ch3
      THEN
        WRITELN(F1, Ch2, Ch3)
      ELSE
        WRITELN(F1, Ch3, Ch2);

    WHILE (NOT(EOLN(F2))) AND (NOT(EOLN(F3)))
    DO
    BEGIN 
      IF Ch2 < Ch3
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

    WHILE (NOT(EOLN(F2))) OR (NOT(EOLN(F3)))
    DO
      BEGIN        
        IF Ch3 > Ch2
        THEN
          BEGIN
            WRITE(F1, Ch2);
            IF NOT EOLN(F2)
            THEN
              BEGIN
                READ(F2, Ch2);
                IF EOLN(F2)
                THEN
                  IF Ch2 > Ch3
                  THEN
                    WRITE(F1, Ch3, Ch2)
                  ELSE
                    WRITE(F1, Ch2, Ch3)
              END 
            ELSE
              BEGIN
                WRITE(F1, Ch3);
                WHILE NOT EOLN(F3)
                DO
                  BEGIN
                    READ(F3, Ch3);
                    WRITE(F1, Ch3)
                  END
              END
          END
        ELSE
          BEGIN
            WRITE(F1, Ch3);
            IF NOT EOLN(F3)
            THEN
              BEGIN
                READ(F3, Ch3);
                IF EOLN(F3)
                THEN
                  IF Ch2 > Ch3
                  THEN
                    WRITE(F1, Ch3, Ch2)
                  ELSE
                    WRITE(F1, Ch2, Ch3)
              END      
            ELSE
              BEGIN
                WRITE(F1, Ch2);
                WHILE NOT EOLN(F2)
                DO
                  BEGIN
                    READ(F2, Ch2);
                    WRITE(F1, Ch2)
                  END
              END
          END                                      
      END; 

    WRITELN(F1)  
  END; {Merge}
BEGIN {RecursiveSort}   
  RESET(F1);    
  IF NOT (EOLN(F1))
  THEN
    BEGIN
      READ(F1, Ch);
      IF NOT (EOLN(F1))
      THEN {Файл имеет как минимум 2 символа}
        BEGIN
          RESET(F1);                              
          Split(F1, F2, F3); { in :  F1 - READ, F2 - ?, F3 - ? 
                               out : F1 - READ, F2 - WRITE, F3 - WRITE}         
          RecursiveSort(F2);          
          RecursiveSort(F3);          
          Merge(F1, F2, F3);                    
          WRITELN(F1);          
        END
      ELSE
        RESET(F1)          
    END   
END;   {RecursiveSort}

BEGIN      
  REWRITE(FileToSort);
  CopyFile(INPUT, FileToSort); 
  RESET(FileToSort);   
  RecursiveSort(FileToSort);
  RESET(FileToSort);
  CopyFile(FileToSort, OUTPUT);     
END.
