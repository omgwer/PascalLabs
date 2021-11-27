PROGRAM TextFormat(INPUT, OUTPUT);
VAR
  Condition, Ch: CHAR; { Q - close program, B - begin, E - end, W - write, w - writeln, R - read, r - readln, S - состояние начала чтения строки }
BEGIN
  Condition := 'S';
  WHILE NOT EOLN(INPUT) { последовательно читаем символы в строке }
  DO
    IF Condition <> 'Q'
    THEN
      BEGIN  
        READ(INPUT, Ch);
        WHILE Ch = ' '   { убираем лишние пробелы }
        DO
          IF NOT EOLN(INPUT)
          THEN
            READ(INPUT, Ch); 
        IF Condition = 'S' 
        THEN
          IF Ch = 'B'
          THEN
            BEGIN
              Condition := ' ';
              READ(Ch, Ch, Ch, Ch);   { Передвинуть каретку до N }
              IF NOT EOLN(INPUT)      { Если после BEGIN не конец строки, прочитать }
              THEN
                READ(Ch);  
              WRITELN('BEGIN');
              WRITE(' ', ' ')
            END
          ELSE            
            Condition := 'Q'
        ELSE   { основная часть программы - следующий ожидаемый символ ;, R, W, E }
          BEGIN
            IF Ch = ';' { проверяем на ; }
            THEN
              BEGIN            
                WHILE Ch = ';'  
                DO
                  BEGIN
                    WRITE(';');
                    WHILE Ch = ' '   { убираем лишние пробелы }
                    DO
                      IF NOT EOLN(INPUT)
                      THEN
                        READ(INPUT, Ch); 
                    IF NOT EOLN(INPUT)
                    THEN
                      READ(INPUT, Ch)                
                    ELSE
                      BEGIN
                        Condition := 'Q';
                        Ch := ''
                      END
                  END;
                WRITELN;
                WRITE(' ', ' ') 
              END                       
          END  
      END       
    ELSE
      BEGIN
        REWRITE(INPUT); 
        WRITELN('ERROR PROGRAM INCORRECT')             
      END  
END.
