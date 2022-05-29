UNIT DataHelper;

INTERFACE
USES
  SharedData, StringHelper;

PROCEDURE Insert(VAR Ptr:Tree; Data: Word);
PROCEDURE PrintTree(Ptr: Tree);

IMPLEMENTATION

PROCEDURE Insert(VAR Ptr:Tree; Data: Word);
VAR
  Overflow: BOOLEAN;
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
        IF ComparisonWord(Ptr^.Key, Data) = '='
        THEN
          Ptr^.Count:= Ptr^.Count + 1
        ELSE IF ComparisonWord(Ptr^.Key, Data) = '>'
        THEN
          Insert(Ptr^.LLink, Data)
        ELSE
          Insert(Ptr^.RLink, Data)
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

BEGIN
END.