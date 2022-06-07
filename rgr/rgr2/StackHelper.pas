Unit StackHelper;

INTERFACE

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

PROCEDURE Push(Key: STRING; Count: INTEGER);
BEGIN
  NEW(NewPtr);
  NewPtr^.Key := Key;
  NewPtr^.Count := Count;  
  Curr := FirstPtr;     
  NewPtr^.Next := Curr;
  FirstPtr := NewPtr   
END;

PROCEDURE Pop(VAR FirstPtr: NodePtr; VAR SharedFile: TEXT);
VAR
  NewPtr: NodePtr;
BEGIN
  NewPtr := FirstPtr;  
  WRITELN(SharedFile, NewPtr^.Key, ' ', NewPtr^.Count);
  FirstPtr := NewPtr^.Next;       
  Dispose(NewPtr)    
END;

PROCEDURE PrintStackForFile(VAR SharedFile: TEXT);
BEGIN
  WHILE FirstPtr <> NIL
  DO
    Pop(FirstPtr, SharedFile);
END;

BEGIN
  FirstPtr := NIL;  
END.