PROGRAM CountWords(INPUT, OUTPUT);
TYPE
  Test = ARRAY [1.. 100000] OF Char;
VAR
  Kek : Test;
  I: INTEGER;
BEGIN  
  FOR I:= 1 TO 100000
  DO
  Kek[I] := 'b'
END.                        