Unit ListHelper;

INTERFACE
USES
  SharedData;

//Добавить элемент в лист
PROCEDURE InsertToList(VAR FirstPtr: List; Word: ValidWord; Count: INTEGER);
//Печатает весь лист по указателю на лист
PROCEDURE PrintList(FirstPtr: List; VAR OutFile: TEXT);
// Создает указатель на новый лист
FUNCTION InitNewList() : List;

IMPLEMENTATION
VAR
  NewPtr, Curr, Prev: List;
  Found: BOOLEAN;
  Count: INTEGER;

PROCEDURE InsertToList(VAR FirstPtr: List; Word: ValidWord; Count: INTEGER);  
BEGIN
  NEW(NewPtr);
  NewPtr^.Word := Word;
  NewPtr^.Count := Count;
  Prev := NIL;
  Curr := FirstPtr;
  Found := FALSE;
  WHILE (Curr <> NIL) AND NOT Found
  DO
    IF NewPtr^.Word > Curr^.Word
    THEN
      BEGIN
        Prev := Curr;
        Curr := Curr^.Next
      END
    ELSE
      Found := TRUE;
  NewPtr^.Next := Curr;
  IF Prev = NIL 
  THEN
    FirstPtr := NewPtr
  ELSE
    Prev^.Next := NewPtr 
END;

PROCEDURE PrintList(FirstPtr: List; VAR OutFile: TEXT);
BEGIN
  NewPtr := FirstPtr;
  Count := 0;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      WRITE(OutFile, NewPtr^.Word);
      Count := NewPtr^.Count + Count;
      NewPtr := NewPtr^.Next;
      IF NewPtr <> NIL
      THEN
        WRITE(OutFile, ', ')
    END;
  WRITELN(OutFile,' : ', Count);  
END; 

FUNCTION InitNewList() : List;
BEGIN
  InitNewList := NIL;
END;  

BEGIN  
END.
