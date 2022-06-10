Unit StackHelper;

INTERFACE
USES
  SharedData;

PROCEDURE Push(Ptr: Tree);
PROCEDURE PrintStackForFile(VAR SharedFile: TEXT);

IMPLEMENTATION
TYPE
  NodePtr = ^Node;
  Node = RECORD           
           Next: NodePtr;
           Ptr: Tree;
         END;
VAR
  FirstPtr, NewPtr, Curr, Prev: NodePtr;  

PROCEDURE Push(Ptr: Tree);
BEGIN
  NEW(NewPtr);   
  NewPtr^.Ptr := Ptr; 
  Curr := FirstPtr;     
  NewPtr^.Next := Curr;
  FirstPtr := NewPtr   
END;

PROCEDURE Pop(VAR FirstPtr: NodePtr; VAR SharedFile: TEXT);
VAR
  NewPtr: NodePtr;
  TmpStack: Tree;
BEGIN
  NewPtr := FirstPtr;
  TmpStack := FirstPtr^.Ptr;
  WRITELN(SharedFile, TmpStack^.Key, ' ', TmpStack^.Count);
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