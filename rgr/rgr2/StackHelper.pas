Unit StackHelper;

INTERFACE

PROCEDURE InitStack();
PROCEDURE Push(Key: STRING; Count: INTEGER);
PROCEDURE PrintStackForFile(VAR SharedFile: TEXT);

IMPLEMENTATION
TYPE
  NodePtr = ^Node;
  Node = RECORD
           Next: NodePtr;
           Key: STRING;
           Count: INTEGER;
         END;
VAR
  FirstPtr, NewPtr, Curr, Prev: NodePtr;
  IsInit: BOOLEAN;

PROCEDURE InitStack();
BEGIN
  FirstPtr := NIL;
END;

PROCEDURE Push(Key: STRING; Count: INTEGER);
BEGIN
  NEW(NewPtr);
  NewPtr^.Key := Key;
  NewPtr^.Count := Count;  
  Curr := FirstPtr;     
  NewPtr^.Next := Curr;
  FirstPtr := NewPtr   
END;

PROCEDURE Print(NewPtr: NodePtr; VAR SharedFile: TEXT);
BEGIN
  NewPtr := FirstPtr;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      WRITELN(SharedFile, NewPtr^.Key, ' ', NewPtr^.Count);          
      NewPtr := NewPtr^.Next;     
    END
END;

PROCEDURE ClearStack(var Stack : NodePtr);
VAR
  StackElement : NodePtr;
BEGIN
  WHILE Stack <> NIL 
  DO 
    BEGIN
    StackElement := Stack;
    Stack := Stack^.Next;
    Dispose(StackElement)
    END
END;

PROCEDURE PrintStackForFile(VAR SharedFile: TEXT);
BEGIN
  Print(NewPtr, SharedFile);
  ClearStack(FirstPtr)  
END;



BEGIN  
END.