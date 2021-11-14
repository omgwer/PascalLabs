PROGRAM SelectSort(INPUT, OUTPUT);
{��������� �������, �������������� #, �� INPUT � OUTPUT.
 ��������� ������ ������, ���� � INPUT ����������� #}
VAR
  Ch, Min: CHAR;
  F1, F2: TEXT;
BEGIN {SelectSort}
  {���������� INPUT � F1 � ��� � OUTPUT}
  REWRITE(F1);
  WRITE(OUTPUT, 'INPUT DATA: ');
  READ(INPUT, Ch);
  WRITE(OUTPUT, 'INPUT ECHO: ');
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(F1, Ch);
      WRITE(OUTPUT, Ch);
      READ(INPUT, Ch)
    END;
  WRITELN(OUTPUT);
  WRITELN(F1, '#');
  {����������� F1 � OUTPUT, ��������� ��������� SelectSort}
  {WRITE(OUTPUT, 'SORTED DATA: ');}
  RESET(F1);
  READ(F1, Ch);    
  WHILE Ch <> '#'
  DO { Ch <> '#' � Ch1 - ������ ������ F1}
    BEGIN  {�������� ����������� �� F1 � �������� ������� F1 � F2}
      REWRITE(F2);     
      Min := Ch;
      WRITE(OUTPUT, 'Min = ');
      WRITE(OUTPUT, Min);
      WRITE(OUTPUT, ' F2 = ');      
      READ(F1, Ch);            
      WHILE Ch <> '#'
      DO { Ch <> '#' � Ch1 - ������ ������ F1}
        BEGIN {�������� ����������� �� (Ch, Min) �������� ������ ������ � F2}                    
          WRITE(F2, Ch);
          WRITE(OUTPUT, Ch);            
          READ(F1, Ch)                             
        END;      
      WRITELN(F2, '#');
      {WRITE(OUTPUT, Min);}
      {�������� F2 � F1}
      RESET(F2);
      REWRITE(F1);
      READ(F2, Ch);
      WRITELN(OUTPUT);
      WRITE(OUTPUT, 'F1 = ');
      WHILE Ch <> '#'
      DO
        BEGIN
          WRITE(F1, Ch);
          WRITE(OUTPUT, Ch);
          READ(F2, Ch)                    
        END;
      WRITELN(F1, '#');
      WRITE(OUTPUT, ' ');
      {�������� F2 � F1}
      RESET(F1);
      READ(F1, Ch)
    END;
  WRITELN(OUTPUT)  
END. {SelectSort} 
