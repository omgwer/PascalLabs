PROGRAM TestRemove(INPUT, OUTPUT);
USES
  Queue;
VAR
  Ch: CHAR;
PROCEDURE RemoveExtraBlanks;
  {Удаляет лишниe пробелы между словами на одной строке}
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
  {WRITE('Вход:');
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      WRITE(Ch);
      AddQ(Ch);
    END;
  WRITELN;
  RemoveExtraBlanks;
  WRITE('Выход:');
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
