Unit StackHelper;

INTERFACE
USES
  SharedData;

PROCEDURE Push(Ptr: Tree);
FUNCTION Pop(): Tree;
//PROCEDURE PrintStackForFile(VAR SharedFile: TEXT);

IMPLEMENTATION
TYPE
  NodePtr = ^Node;
  Node = RECORD
           Next: NodePtr;
           Ptr: Tree;
         END;
VAR
  FirstPtr, NewPtr, Curr, Prev: NodePtr;  

PROCEDURE Push(Ptr: Tree); //Key: STRING; Count: INTEGER
BEGIN
  NEW(NewPtr);   
  NewPtr^.Ptr := Ptr; 
  Curr := FirstPtr;     
  NewPtr^.Next := Curr;
  FirstPtr := NewPtr   
END;

FUNCTION Pop(): Tree;
VAR
  NewPtr: NodePtr;
  TmpStack: Tree;
BEGIN
  NewPtr := FirstPtr;
  TmpStack := FirstPtr^.Ptr;
  FirstPtr := NewPtr^.Next;
  Dispose(NewPtr);  
  Pop := TmpStack;
  END;

// PROCEDURE PrintStackForFile(VAR SharedFile: TEXT);
// BEGIN
//   WHILE FirstPtr <> NIL
//   DO
//     Pop();
// END;

BEGIN
  FirstPtr := NIL;  
END.