PROGRAM ProgramTextFormat(INPUT, OUTPUT);
VAR
  Condition, Delemiter, Ch : CHAR; { Q - error }
BEGIN
  Condition := 'S'; 
  WHILE NOT EOLN(INPUT) { ��������������� ������ ������� � ������ }
  DO    
    BEGIN
      IF NOT EOLN(INPUT)
      THEN  
        READ(INPUT, Ch)
      ELSE          
        REWRITE(INPUT);         
      WHILE Ch = ' '   { ������� ������ ������� }
      DO
        IF NOT EOLN(INPUT)
        THEN
          READ(INPUT, Ch)
        ELSE
          REWRITE(INPUT);                { ����� �������� �������� }  
      IF Ch = 'B'  { �������� Begin }
      THEN
        BEGIN
          WHILE Ch <> 'N'     { ������ �������  �� N }      
          DO   
            IF NOT EOLN(INPUT)      
            THEN
              READ(INPUT, Ch)
            ELSE
              REWRITE(INPUT);            
          WRITELN(OUTPUT, 'BEGIN')              
        END;            
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
                    READ(INPUT, Ch)
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
                    READ(INPUT, Ch);                              
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
                    READ(INPUT, Ch)
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
                    READ(INPUT, Ch);                              
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
            END                
          END;
      IF Ch = 'E' { ������� END. }
      THEN
        BEGIN
          REWRITE(INPUT);
          WRITELN('END.')  
        END
    END    
END.
