PROGRAM TestRemove(INPUT, OUTPUT);
USES
  Queue;
VAR
  Ch: CHAR;
PROCEDURE RemoveExtraBlanks;
  {������� �����e ������� ����� ������� �� ����� ������}
BEGIN {RemoveExtraBlanks}
END;  

BEGIN {TestRemove}
  READ(Ch);
  EmptyQ;
  AddQ(Ch);
  READ(Ch);
  AddQ(Ch);
  READ(Ch);
  AddQ(Ch);
  WriteQ;
  {WRITE('����:');
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      WRITE(Ch);
      AddQ(Ch);
    END;
  WRITELN;
  RemoveExtraBlanks;
  WRITE('�����:');
  HeadQ(Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      DelQ;
      HeadQ(Ch)
    END;
  WRITELN }
END. {TestRemove}
