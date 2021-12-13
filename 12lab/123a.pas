PROGRAM CopyBig(INPUT, OUTPUT);
VAR
  V1, V2: CHAR;
BEGIN
  READ(V1, V2);
  IF V1 < V2
  THEN
    V1 := V2
  ELSE
    IF V1 >= V2
    THEN      
        IF V2 < V1
        THEN
          V2 := V1
        ELSE 
          IF V2 >= V1
          THEN
            ;      
  WRITELN(V1, V2)
END.
