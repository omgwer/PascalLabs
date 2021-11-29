PROGRAM ProgramTextFormat(INPUT, OUTPUT);
VAR
  Condition, Delemiter, Ch : CHAR; { Q - error }
BEGIN
  Condition := 'S'; 
  WHILE NOT EOLN(INPUT) { последовательно читаем символы в строке }
  DO    
    BEGIN
      IF NOT EOLN(INPUT)
      THEN  
        READ(INPUT, Ch)
      ELSE          
        REWRITE(INPUT);         
      WHILE Ch = ' '   { убираем лишние пробелы }
      DO
        IF NOT EOLN(INPUT)
        THEN
          READ(INPUT, Ch)
        ELSE
          REWRITE(INPUT);                { конец убирания пробелов }  
      IF Ch = 'B'  { печатаем Begin }
      THEN
        BEGIN
          WHILE Ch <> 'N'     { Читаем символы  до N }      
          DO   
            IF NOT EOLN(INPUT)      
            THEN
              READ(INPUT, Ch)
            ELSE
              REWRITE(INPUT);            
          WRITELN(OUTPUT, 'BEGIN')              
        END;            
      WHILE Ch = ' '   { убираем лишние пробелы }  { основная часть программы - следующий ожидаемый символ ;, R, W, E }
      DO
        IF NOT EOLN(INPUT)
        THEN
          READ(INPUT, Ch)
        ELSE
          BEGIN
            Condition := 'Q';
            Ch := 'e'
          END;                
      IF Ch = ';' { ожидаем ; }
      THEN
        BEGIN
          IF Delemiter <> 'T'
          THEN
            BEGIN
              WRITE(OUTPUT, ' ', ' ');
              Delemiter := 'F'
            END;
          WHILE Ch = ';'
          DO
            BEGIN
              WRITE(OUTPUT, Ch);
              IF NOT EOLN(INPUT) { проверям что после ';' }
              THEN
                BEGIN
                  READ(INPUT, Ch);
                  WHILE Ch = ' '   { убираем пробелы, если есть }
                  DO
                    IF NOT EOLN(INPUT)
                    THEN
                      READ(INPUT, Ch)
                    ELSE
                      BEGIN
                        Condition := 'Q';
                        Ch := 'e'
                      END                   
                END
              ELSE
                BEGIN
                  Ch := 'e';
                  Condition := 'Q'
                END
            END;                     
          WRITELN                           
        END;                          
      IF Ch = 'W'  { ожидаем WRITE или WRITELN }
      THEN
        BEGIN
          WRITE(' ', ' ');
          Delemiter := 'T';            
          WHILE Ch <> 'E'
          DO
            IF NOT EOLN(INPUT)
            THEN
              BEGIN
                WRITE(OUTPUT, Ch);
                READ(INPUT, Ch)                  
              END
            ELSE
              BEGIN
                REWRITE(INPUT);
                Condition := 'Q'
              END;
          WRITE(OUTPUT, Ch); {напечатали слово WRITE }
          IF NOT EOLN(INPUT)
          THEN              
            READ(INPUT, Ch)
          ELSE
            BEGIN
              REWRITE(INPUT);
              Condition := 'Q'
            END;            
          IF Ch = 'L'   { если символ 'L' Дописываем LN }
          THEN
            BEGIN
              WRITE(OUTPUT, Ch);
              IF NOT EOLN(INPUT)
              THEN
                BEGIN
                  READ(INPUT, Ch);
                  WRITE(OUTPUT, Ch); { дописываем LN }
                  IF NOT EOLN(INPUT) { защищенно читаем следующий символ поcле WRITELN }
                  THEN                              
                    READ(INPUT, Ch)
                END                      
            END;                           
          WHILE Ch = ' '   { убираем лишние пробелы }
          DO
            IF NOT EOLN(INPUT)
            THEN
              READ(INPUT, Ch)
            ELSE
              BEGIN
                Condition := 'Q';
                Ch := 'e'
              END;          { конец убирания пробелов }
          IF Ch = '('         { ЕСЛИ следующий символ '(' }
          THEN
            BEGIN
              WRITE(OUTPUT, Ch);
              WHILE Ch <> ')'   { выводим все символы в скобках, исключая пробелы }
              DO
                BEGIN
                  IF NOT EOLN(INPUT)
                  THEN
                    READ(INPUT, Ch);                              
                  WHILE Ch = ' '   { убираем лишние пробелы }
                  DO
                    IF NOT EOLN(INPUT)
                    THEN
                      READ(INPUT, Ch);                      
                  WRITE(OUTPUT, Ch);
                  IF Ch = ','
                  THEN
                    WRITE(' ')                
                END
            END                
          END;
      IF Ch = 'R'  { ожидаем READ или READLN }
      THEN
        BEGIN
          WRITE(' ', ' ');
          Delemiter := 'T';            
          WHILE Ch <> 'D'
          DO
            IF NOT EOLN(INPUT)
            THEN
              BEGIN
                WRITE(OUTPUT, Ch);
                READ(INPUT, Ch)                  
              END
            ELSE
              BEGIN
                REWRITE(INPUT);
                Condition := 'Q'
              END;
          WRITE(OUTPUT, Ch); {напечатали слово WRITE }
          IF NOT EOLN(INPUT)
          THEN              
            READ(INPUT, Ch)
          ELSE
            BEGIN
              REWRITE(INPUT);
              Condition := 'Q'
            END;            
          IF Ch = 'L'   { если символ 'L' Дописываем LN }
          THEN
            BEGIN
              WRITE(OUTPUT, Ch);
              IF NOT EOLN(INPUT)
              THEN
                BEGIN
                  READ(INPUT, Ch);
                  WRITE(OUTPUT, Ch); { дописываем LN }
                  IF NOT EOLN(INPUT) { защищенно читаем следующий символ поcле WRITELN }
                  THEN                              
                    READ(INPUT, Ch)
                END                      
            END;                           
          WHILE Ch = ' '   { убираем лишние пробелы }
          DO
            IF NOT EOLN(INPUT)
            THEN
              READ(INPUT, Ch)
            ELSE
              BEGIN
                Condition := 'Q';
                Ch := 'e'
              END;          { конец убирания пробелов }
          IF Ch = '('         { ЕСЛИ следующий символ '(' }
          THEN
            BEGIN
              WRITE(OUTPUT, Ch);
              WHILE Ch <> ')'   { выводим все символы в скобках, исключая пробелы }
              DO
                BEGIN
                  IF NOT EOLN(INPUT)
                  THEN
                    READ(INPUT, Ch);                              
                  WHILE Ch = ' '   { убираем лишние пробелы }
                  DO
                    IF NOT EOLN(INPUT)
                    THEN
                      READ(INPUT, Ch);                      
                  WRITE(OUTPUT, Ch);
                  IF Ch = ','
                  THEN
                    WRITE(' ')                
                END
            END                
          END;
      IF Ch = 'E' { выводим END. }
      THEN
        BEGIN
          REWRITE(INPUT);
          WRITELN('END.')  
        END
    END    
END.
