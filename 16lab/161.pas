PROGRAM SortMonth(INPUT, OUTPUT);
USES
  DateIO;
  
VAR
  M1, M2 : Month;

BEGIN  
  ReadMonth(INPUT, M1);  
  ReadMonth(INPUT, M2)      
  
  IF (M1 = NoMonth) OR (M2 = NoMonth)
  THEN
    WRITELN('������� ������ �������� �������')
  ELSE IF M1 = M2
  THEN
    BEGIN
      WRITE('��� ������ ');
      WriteMonth(OUTPUT, M1);
      WRITELN(OUTPUT);
    END
  ELSE
    BEGIN
      WriteMonth(OUTPUT, M1);
      IF (M1 > M2)
      THEN
        WRITE(OUTPUT, ' ������� ')
      ELSE        
          WRITE(OUTPUT, ' ������������ ');
      WriteMonth(OUTPUT, M2);
      WRITELN           
    END   
END.  
