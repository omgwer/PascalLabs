PROGRAM TextFormat(INPUT, OUTPUT);
VAR
  Condition, Ch: CHAR; { Q - close program, B - begin, E - end, W - write, w - writeln, R - read, r - readln, S - ��������� ������ ������ ������ }
BEGIN
  Condition := 'S';
  WHILE NOT EOLN(INPUT) { ��������������� ������ ������� � ������ }
  DO
    IF Condition <> 'Q'
    THEN
      BEGIN  
        READ(INPUT, Ch);
        WHILE Ch = ' '   { ������� ������ ������� }
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
              READ(Ch, Ch, Ch, Ch);   { ����������� ������� �� N }
              IF NOT EOLN(INPUT)      { ���� ����� BEGIN �� ����� ������, ��������� }
              THEN
                READ(Ch);  
              WRITELN('BEGIN');
              WRITE(' ', ' ')
            END
          ELSE            
            Condition := 'Q'
        ELSE   { �������� ����� ��������� - ��������� ��������� ������ ;, R, W, E }
          BEGIN
            IF Ch = ';' { ��������� �� ; }
            THEN
              BEGIN            
                WHILE Ch = ';'  
                DO
                  BEGIN
                    WRITE(';');
                    WHILE Ch = ' '   { ������� ������ ������� }
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
