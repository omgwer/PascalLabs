PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 4;
  ClassSize = 4;
TYPE
  Score = 0 .. 100;
VAR
  WhichScore: 1 .. NumberOfScores;
  Student: 1 .. ClassSize;
  NextScore: Score;
  Ave, TotalScore, ClassTotal: INTEGER;
BEGIN {AverageScore}
  ClassTotal := 0;
  WRITELN('Student averages:');
  Student := 1;
  WHILE Student <= ClassSize {  }
  DO 
    BEGIN
      TotalScore := 0;
      WhichScore := 1;
      WHILE WhichScore <= NumberOfScores  { 1 < 3 }
      DO
        BEGIN
          READ(NextScore);
          TotalScore := TotalScore + NextScore;
          WhichScore := WhichScore + 1;
        END;
      READLN;
      TotalScore := TotalScore * 10;
      Ave := TotalScore DIV NumberOfScores;
      WRITE('Average student : ');
      IF Ave MOD 10 >= 5
      THEN
        WRITE(Ave DIV 10 + 1)
      ELSE
        WRITE(Ave DIV 10); 
      WRITELN;
      ClassTotal := ClassTotal + TotalScore;
      Student := Student + 1
    END;
  WRITELN;
  
  //WRITELN('Total points : ', ClassTotal);
  ClassTotal := (ClassTotal) DIV (ClassSize * NumberOfScores);
  WRITELN('Counts points : ', ClassTotal); 
  WRITELN;
  WRITELN ('Class average:');
  WRITELN(ClassTotal DIV 10, '.', ClassTotal MOD 10: 1)
END.  {AverageScore}
