PROGRAM SarahRevere(INPUT, OUTPUT);
{����� ᮮ�饭�� � ⮬ ��� ���� ��⠭��, � ����ᨬ���
�� ⮣�, ���� �� �室� ����砥��� 'land' ��� 'sea'.}
VAR
  W1, W2, W3, W4, Looking: CHAR;
BEGIN {SarahRevere}
  BEGIN {���樠������ W1,W2,W3,W4,Looking}
    W1 := ' ';
    W2 := ' ';
    W3 := ' ';
    W4 := ' ';
    Looking := 'Y'
  END;	
  WHILE Looking = 'Y'
  DO
    BEGIN {������� ����, �஢����� ����� ������}
      {�஢�ઠ ���� ���  'land'}
      IF W1 = 'l'
      THEN
        IF W2 = 'a'
        THEN
          IF W3 = 'n'
          THEN
            IF W4 = 'd'
            THEN {'land' �������}
              Looking := 'L';
      {�஢�ઠ ���� ��� 'sea'}
      IF W1 = 's'
      THEN
        IF W2 = 'e'
        THEN
          IF W3 = 'a'
          THEN {'sea' �������}
	    Looking := 'S';           
      IF Looking = 'Y' {������ �������⥫쭮� �ࠢ����� � ��६����� Looking ��� ��������� ��१����}
      THEN
        BEGIN
          W1 := W2;
          W2 := W3;
          W3 := W4;
          READ(W4);
          IF W4 = '#'
          THEN {����� ������}            
            IF W3 = 'a'
            THEN
              IF W2 = 'e'
              THEN
                IF W1 = 's'
                THEN
                  Looking := 'S'                               		
                ELSE
                  Looking := 'N'
              ELSE
                Looking := 'N'
            ELSE
              Looking := 'N'               
        END     
    END;
  IF Looking = 'L'
  THEN
    WRITELN('The British are coming by land.')
  ELSE
    IF Looking = 'S'
    THEN
      WRITELN('The British are coming by sea.')
    ELSE
      WRITELN('Sarah didn''t say')
END. {Sarah revere}
