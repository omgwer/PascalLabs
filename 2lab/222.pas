PROGRAM What(INPUT, OUTPUT);
VAR
  Ch: CHAR;
BEGIN {What}
  READ(Ch);
  WRITELN('First symbol of you entered: ', Ch, '. He is a number ?');
  IF '0' <= Ch
  THEN
    IF Ch <= '9'
    THEN
      WRITELN('YES')
    ELSE
      WRITELN('NO')
  ELSE
    WRITELN('NO')
END. {What}
