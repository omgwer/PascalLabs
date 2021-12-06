PROGRAM ProgramTextFormat(INPUT, OUTPUT);
VAR
  Condition, Delemiter, Ch : CHAR; { Q - error }
BEGIN
  Condition := 'S'; 
  WHILE NOT EOLN(INPUT) { последовательно читаем символы в строке }
  DO
    IF Condition <> 'Q'
    THEN
      BEGIN
        IF NOT EOLN(INPUT)
        THEN  
          READ(INPUT, Ch)
        ELSE
          BEGIN
            REWRITE(INPUT);
            Condition := 'Q'
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
            END;           { конец убирания пробелов }  
        IF Condition = 'S' 
        THEN
          IF Ch = 'B'
          THEN
            BEGIN
              Condition := ' ';
              WHILE Ch <> 'N'
              DO
                BEGIN                    { Передвинуть каретку до N }
                  IF NOT EOLN(INPUT)      { Если после BEGIN не конец строки, прочитать }
                  THEN
                    READ(INPUT, Ch)
                  ELSE
                    Ch := 'N'    
                END;             { защищенное чтение символа после BEGIN }
              WRITELN(OUTPUT, 'BEGIN')              
            END
        ELSE            
          Condition := 'Q';       
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
                        END;                                      
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
                      BEGIN
                        READ(INPUT, Ch);
                        IF Ch = ';'
                        THEN
                          WRITE(';')
                      END                     
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
                      READ(INPUT, Ch)
                    ELSE
                      Ch := ')';                              
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
              END;
            
            WHILE Ch = ' '
            DO
              IF NOT EOLN(INPUT)
              THEN
                READ(Ch);                  
            IF Ch = '{'
            THEN
              BEGIN
                WRITE(OUTPUT, Ch);
                WHILE Ch <> '}'
                DO
                  BEGIN
                    IF NOT EOLN(INPUT)
                    THEN
                      BEGIN
                        READ(INPUT, Ch);
                        WRITE(OUTPUT, Ch)
                      END
                    ELSE
                      Ch := '}'
                  END;                 
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
                      BEGIN
                        READ(INPUT, Ch);
                        IF Ch = ';'
                        THEN
                          WRITE(';')
                      END
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
                WHILE Ch <> ')'  { выводим все символы в скобках, исключая пробелы }
                DO
                  BEGIN
                    IF NOT EOLN(INPUT)
                    THEN
                      READ(INPUT, Ch)
                    ELSE
                      Ch := ')';                              
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
              END;              
            WHILE Ch = ' '
            DO
              IF NOT EOLN(INPUT)
              THEN
                READ(Ch);                  
            IF Ch = '{'
            THEN
              BEGIN
                WRITE(OUTPUT, Ch);
                WHILE Ch <> '}'
                DO
                  BEGIN
                    IF NOT EOLN(INPUT)
                    THEN
                      BEGIN
                        READ(INPUT, Ch);
                        WRITE(OUTPUT, Ch)
                      END
                    ELSE
                      Ch := '}'
                  END;                 
              END    
          END;
        IF Ch = '{'
        THEN
          BEGIN
            WRITE(OUTPUT, Ch);
            WHILE Ch <> '}'
            DO
              BEGIN
                IF NOT EOLN(INPUT)
                THEN
                  BEGIN
                    READ(INPUT, Ch);
                    WRITE(OUTPUT, Ch)
                  END
                ELSE
                  Ch := '}'
              END;
            WRITELN  
          END;    
        IF Ch = 'E' { выводим END. }
        THEN
          BEGIN
            IF Delemiter = 'T'
            THEN
              WRITELN;
            WRITELN('END.')  
          END
      END
    ELSE
      BEGIN
        REWRITE(INPUT); 
        WRITELN('ERROR PROGRAM INCORRECT')             
      END  
END.
