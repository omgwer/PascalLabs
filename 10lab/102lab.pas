PROGRAM TextFormat(INPUT, OUTPUT);
VAR
  Condition, Ch: CHAR; { Q - close program, B - begin, E - end, W - write, w - writeln, R - read, r - readln, S - состояние начала чтения строки, e - ошибка }
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
              READ(Ch, Ch, Ch, Ch);   { Передвинуть каретку до N }
              IF NOT EOLN(INPUT)      { Если после BEGIN не конец строки, прочитать }
              THEN
                READ(INPUT, Ch);             { защищенное чтение символа после BEGIN }
              WRITELN(OUTPUT, 'BEGIN');
              WRITE(' ', ' ')
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
        IF Ch = ';' { выводим все ';' в одной строке, после перенос }
        THEN
          BEGIN                    
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
            WRITELN;                
          END;
        IF Ch = 'E' { выводим END. }
        THEN
          BEGIN
            REWRITE(INPUT);
            WRITELN('END.')  
          END;
        IF Ch = 'W'  { ожидаем WRITE или WRITELN }
        THEN
          BEGIN
            WRITE(OUTPUT, ' ', ' ');
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
              BEGIN
                READ(INPUT, Ch);
                IF Ch = 'L'
                THEN
                  BEGIN
                    WRITE(OUTPUT, Ch);
                    IF NOT EOLN(INPUT)
                    THEN
                      READ(INPUT, Ch);
                    WRITE(OUTPUT, Ch); { дописываем LN }
                    IF NOT EOLN(INPUT)
                    THEN
                      READ(INPUT)
                  END
              END
          END;
         IF Ch = 'R'  { ожидаем READ или READLN }
        THEN
          BEGIN
            
          END
      END       
    ELSE
      BEGIN
        REWRITE(INPUT); 
        WRITELN('ERROR PROGRAM INCORRECT')             
      END  
END.
