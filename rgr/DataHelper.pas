UNIT DataHelper;

INTERFACE
USES
  SharedData, StringHelper;

PROCEDURE Insert(VAR Ptr:Tree; Data: Word);
PROCEDURE PrintTree(Ptr: Tree);
PROCEDURE InitData();
PROCEDURE PrintOverflowError();

IMPLEMENTATION


PROCEDURE Insert(VAR Ptr:Tree; Data: Word);
VAR
  Overflow: BOOLEAN;
  ComparisonResult: CHAR;
BEGIN
  Overflow := FALSE;
  IF NOT Overflow
  THEN
    BEGIN
      IF Ptr = NIL
      THEN
        BEGIN {Создаем лист со значением Data}
          IF TreeDepth < MaxTreeDepth  // Проверяем дерево на переполнение
          THEN
            BEGIN
              NEW(Ptr);
              TreeDepth := TreeDepth + 1;
              Ptr^.Key := Data;
              Ptr^.Count:= 1;
              Ptr^.LLink := NIL;
              Ptr^.RLink := NIL
            END
          ELSE
            NotAddedTreeElementCount := NotAddedTreeElementCount + 1;   
        END
      ELSE
        BEGIN
          ComparisonResult := ComparisonWord(Ptr^.Key, Data);
          IF ComparisonResult = '='
          THEN
            Ptr^.Count:= Ptr^.Count + 1
          ELSE IF ComparisonResult = '>'
          THEN
            Insert(Ptr^.LLink, Data)
          ELSE
            Insert(Ptr^.RLink, Data)
        END        
    END; 
END;

PROCEDURE PrintTree(Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN  {Печатает поддерево слева, вершину, поддерево справа}
    BEGIN
      PrintTree(Ptr^.LLink);
      WRITELN(OUTPUT,Ptr^.Key, ' ', Ptr^.Count);
      PrintTree(Ptr^.RLink)
    END; 
END;  {PrintTree} 

PROCEDURE InitData();
BEGIN
  Root := NIL;
  TreeDepth := 0;
  NotAddedTreeElementCount := 0;
END;

PROCEDURE PrintOverflowError();
BEGIN
  IF NotAddedTreeElementCount > 0
  THEN
    WRITELN('Elements not added for tree - ', NotAddedTreeElementCount);  
END;

BEGIN
END.