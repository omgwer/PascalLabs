PROGRAM SarahRevere(INPUT, OUTPUT); 
VAR
  W1, W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN; 
 
BEGIN {SarahRevere}   
  {�������������}
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := TRUE;
  Sea := FALSE;
  Land := FALSE;
  Looking := NOT EOLN(INPUT);
  WHILE Looking AND NOT (Land OR Sea)   
  DO
    BEGIN
      {�������� ����}
      W1 := W2;
      W2 := W3;
      W3 := W4;
      IF NOT EOLN(INPUT)
      THEN
        READ(INPUT, W4);
      Looking := NOT EOLN(INPUT);
      {�������� ���� �� land}
      Land := (W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd');
      {�������� ���� �� sea}
      Sea := (W2 = 's') AND (W3 = 'e') AND (W4 = 'a')
    END;
  {�������� ��������� Sarah}
  IF Land
  THEN
    WRITELN('The british are coming for land')
  ELSE IF Sea
  THEN
    WRITELN('The british are coming for sea')
  ELSE
    WRITELN('Sarah didnt say')  
END.  {SarahRevere} 

