UNIT DataHelper;

INTERFACE
USES
  SharedData, StringHelper, ListHelper, RootOfWordHelper;

PROCEDURE GetCountWordInfo(VAR InsertText, OutputFile: Text);

IMPLEMENTATION
VAR
  Root: Tree;

// Печать всего дерева по указателю
PROCEDURE PrintTree(Ptr: Tree; VAR OutFile: TEXT);
BEGIN
  IF Ptr <> NIL
  THEN
    BEGIN
      PrintTree(Ptr^.LLink, OutFile);
      PrintList(Ptr^.WordList, OutFile);
      PrintTree(Ptr^.RLink,OutFile);
    END;
END; 

//добавление 1-го элемента в дерево 
PROCEDURE Insert(VAR Ptr:Tree; Count: INTEGER; RootOfWord, Word: ValidWord);
VAR
  Overflow: BOOLEAN;
  NewList : List;
BEGIN
  Overflow := FALSE;
  IF NOT Overflow
  THEN
    BEGIN
      IF Ptr = NIL
      THEN
        BEGIN {Создание нового узла дерева, key - основание слова}         
          NEW(Ptr); 
          Ptr^.Key := RootOfWord;           
          NewList := InitNewList();  
          InsertToList(NewList, Word, Count); 
          Ptr^.WordList := NewList;        
          Ptr^.LLink := NIL;
          Ptr^.RLink := NIL         
        END
      ELSE
        BEGIN          
          IF Ptr^.Key = RootOfWord
          THEN
            InsertToList(Ptr^.WordList, Word, Count)
          ELSE IF Ptr^.Key > RootOfWord
          THEN
            Insert(Ptr^.LLink, Count, RootOfWord,Word)
          ELSE
            Insert(Ptr^.RLink, Count, RootOfWord,Word)
        END        
    END
END;

PROCEDURE PrintDataForFile(VAR SharedFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN
  REWRITE(OutFile);
  RESET(SharedFile);
  WHILE NOT EOF(SharedFile)
  DO
    IF EOLN(SharedFile)
    THEN
      BEGIN
        READLN(SharedFile);
        WRITELN(OutFile)
      END
    ELSE
      BEGIN
        READ(SharedFile, Ch);
        WRITE(OutFile, Ch)
      END  
END;

PROCEDURE PrintData(Root: Tree; VAR OutputFile: TEXT); 
VAR
  OutFile : TEXT;
BEGIN
  Assign(OutFile, 'data/out.txt');
  REWRITE(OutFile);
  PrintTree(Root, OutFile);
  PrintDataForFile(OutFile, OutputFile);
END;

PROCEDURE GetCountWordInfo(VAR InsertText, OutputFile: Text);
VAR
  NewWord: ValidWord;
  NewCount: INTEGER;
  RootOfWord: ValidWord;  
BEGIN  
  WHILE NOT (EOF(InsertText))
  DO
    BEGIN
      NewWord := GetWord(InsertText);
      RootOfWord := GetRootOfWord(NewWord);
      IF NewWord <> ''
      THEN
        BEGIN
          READ(InsertText, NewCount);
          Insert(Root, NewCount, RootOfWord, NewWord);
        END;                     
    END;
  PrintData(Root, OutputFile); 
END;

BEGIN
  Root := NIL;
END.