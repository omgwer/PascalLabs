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
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(W4);
      IF W4 = '#'
      THEN {����� ������}
        Looking := 'N';
      WRITELN(W1, W2, W3, W4); 
    END;
     {�஢�ઠ ���� ��� 'land'}
     {�஢�ઠ ���� ��� 'sea'}
     {ᮧ���� ᮮ�饭�� Sarah}
END. {Sarah revere}



