PROGRAM ProgramTextFormat(INPUT, OUTPUT);
VAR
  Condition, Delemiter, Ch : CHAR; { Q - error }
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
              WHILE Ch <> 'N'
              DO
                BEGIN                    { ����������� ������� �� N }
                  IF NOT EOLN(INPUT)      { ���� ����� BEGIN �� ����� ������, ��������� }
                  THEN
                    READ(INPUT, Ch)
                  ELSE
                    Ch := 'N'    
                END;             { ���������� ������ ������� ����� BEGIN }
              WRITELN(OUTPUT, 'BEGIN')              
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
        IF Ch = ';' { ������� ; }
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
        IF Ch = 'W'  { ������� WRITE ��� WRITELN }
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
                    WRITE(OUTPUT, Ch); { ���������� LN }
                    IF NOT EOLN(INPUT) { ��������� ������ ��������� ������ ��c�� WRITELN }
                    THEN
                      BEGIN
                        READ(INPUT, Ch);
                        IF Ch = ';'
                        THEN
                          WRITE(';')
                      END                     
                  END                      
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
                END;          { ����� �������� �������� }
            IF Ch = '('         { ���� ��������� ������ '(' }
            THEN
              BEGIN
                WRITE(OUTPUT, Ch);
                WHILE Ch <> ')'   { ������� ��� ������� � �������, �������� ������� }
                DO
                  BEGIN
                    IF NOT EOLN(INPUT)
                    THEN
                      READ(INPUT, Ch)
                    ELSE
                      Ch := ')';                              
                    WHILE Ch = ' '   { ������� ������ ������� }
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
        IF Ch = 'R'  { ������� READ ��� READLN }
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
                    WRITE(OUTPUT, Ch); { ���������� LN }
                    IF NOT EOLN(INPUT) { ��������� ������ ��������� ������ ��c�� WRITELN }
                    THEN                              
                      BEGIN
                        READ(INPUT, Ch);
                        IF Ch = ';'
                        THEN
                          WRITE(';')
                      END
                  END                      
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
                END;          { ����� �������� �������� }
            IF Ch = '('         { ���� ��������� ������ '(' }
            THEN
              BEGIN
                WRITE(OUTPUT, Ch);
                WHILE Ch <> ')'  { ������� ��� ������� � �������, �������� ������� }
                DO
                  BEGIN
                    IF NOT EOLN(INPUT)
                    THEN
                      READ(INPUT, Ch)
                    ELSE
                      Ch := ')';                              
                    WHILE Ch = ' '   { ������� ������ ������� }
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
        IF Ch = 'E' { ������� END. }
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
