PROGRAM TextFormat(INPUT, OUTPUT);
VAR
  Condition, Ch: CHAR; { Q - close program, B - begin, E - end, W - write, w - writeln, R - read, r - readln, S - ��������� ������ ������ ������, e - ������ }
BEGIN
  Condition := 'S';
  WHILE NOT EOLN(INPUT) { ��������������� ������ ������� � ������ }
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
        WHILE Ch = ' '   { ������� ������ ������� }
        DO
          IF NOT EOLN(INPUT)
          THEN
            READ(INPUT, Ch)
          ELSE
            BEGIN
              Condition := 'Q';
              Ch := 'e'
            END;           { ����� �������� �������� }  
        IF Condition = 'S' 
        THEN
          IF Ch = 'B'
          THEN
            BEGIN
              Condition := ' ';
              READ(Ch, Ch, Ch, Ch);   { ����������� ������� �� N }
              IF NOT EOLN(INPUT)      { ���� ����� BEGIN �� ����� ������, ��������� }
              THEN
                READ(INPUT, Ch);             { ���������� ������ ������� ����� BEGIN }
              WRITELN(OUTPUT, 'BEGIN');              
            END
        ELSE            
          Condition := 'Q';       
        WHILE Ch = ' '   { ������� ������ ������� }  { �������� ����� ��������� - ��������� ��������� ������ ;, R, W, E }
        DO
          IF NOT EOLN(INPUT)
          THEN
            READ(INPUT, Ch)
          ELSE
            BEGIN
              Condition := 'Q';
              Ch := 'e'
            END;
        IF Ch = 'E' { ������� END. }
        THEN
          BEGIN
            REWRITE(INPUT);
            WRITELN('END.');  
          END
        ELSE
          WRITE(' ', ' ');      
        IF Ch = ';' { ������� ��� ';' � ����� ������, ����� ������� }
        THEN
          BEGIN                    
            WHILE Ch = ';'
            DO
              BEGIN
                WRITE(OUTPUT, Ch);
                IF NOT EOLN(INPUT) { �������� ��� ����� ';' }
                THEN
                  BEGIN
                    READ(INPUT, Ch);
                    WHILE Ch = ' '   { ������� �������, ���� ���� }
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
         IF Ch <> 'E' { ����������� �������� ����� ���������� }
        THEN          
          WRITE(' ', ' ');                   
        IF Ch = 'W'  { ������� WRITE ��� WRITELN }
        THEN
          BEGIN            
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
            WRITE(OUTPUT, Ch); {���������� ����� WRITE }
            IF NOT EOLN(INPUT)
            THEN              
              READ(INPUT, Ch)
            ELSE
              BEGIN
                REWRITE(INPUT);
                Condition := 'Q'
              END;            
            IF Ch = 'L'   { ���� ������ 'L' ���������� LN }
            THEN
              BEGIN
                WRITE(OUTPUT, Ch);
                IF NOT EOLN(INPUT)
                THEN
                  BEGIN
                    READ(INPUT, Ch);
                    WRITE(OUTPUT, Ch) { ���������� LN }
                  END                      
              END;
            IF NOT EOLN(INPUT) { ��������� ������ ��������� ������ ��c�� WRITE\LN }
            THEN                              
              READ(INPUT, Ch);               
              WHILE Ch = ' '   { ������� ������ ������� }
              DO
                IF NOT EOLN(INPUT)
                THEN
                  READ(INPUT, Ch)
                ELSE
                  BEGIN
                    Condition := 'Q';
                    Ch := 'e'
                  END;          { ����� �������� �������� }
            IF Ch = '('         { ���� ��������� ������ '(' }
            THEN
              BEGIN
                WRITE(OUTPUT, Ch);
                WHILE Ch <> ')'   { ������� ��� ������� � �������, �������� ������� }
                DO
                  BEGIN                              
                    WHILE Ch = ' '   { ������� ������ ������� }
                    DO
                      IF NOT EOLN(INPUT)
                      THEN
                        READ(INPUT, Ch)
                      ELSE
                        BEGIN
                          Condition := 'Q';
                          Ch := 'e'
                        END;         { ����� �������� �������� }
                    IF NOT EOLN(INPUT) { ����� �������� ��������, ���������� ������ }
                    THEN
                      BEGIN                        
                        READ(INPUT, Ch);
                        WRITE(OUTPUT, Ch);
                        IF Ch = ','
                        THEN
                          WRITE(' ')   
                      END                   
                  END
              END
          END;
          IF Ch <> 'E' { ����������� �������� ����� ���������� }
          THEN          
            WRITE(' ', ' ');  
         IF Ch = 'R'  { ������� READ ��� READLN }
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
