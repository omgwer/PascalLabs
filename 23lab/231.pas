PROGRAM InsertSort2(INPUT, OUTPUT);
TYPE 
  NodePtr = ^Node;
  Node = RECORD
           Next: NodePtr;
           Key: CHAR
         END;
VAR
  FirstPtr, NewPtr, Curr, Prev: NodePtr;
  Found: BOOLEAN;
BEGIN {InsertSort2}
  FirstPtr := NIL;
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      NEW(NewPtr);
      READ(NewPtr^.Key);
     // Prev := NIL;
      Curr := FirstPtr;
      {2.1.1 Найдем значение Prev и Curr, такие что Prev^.Key <= NewPtr^.Key <= Curr^.Key}
      NewPtr^.Next := Curr;
     // IF Prev = NIL 
     // THEN
        FirstPtr := NewPtr
     // ELSE
       // Prev^.Next := NewPtr
    END;
  NewPtr := FirstPtr;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      WRITE(NewPtr^.Key);
      NewPtr := NewPtr^.Next
    END
END.  {InsertSort2}

