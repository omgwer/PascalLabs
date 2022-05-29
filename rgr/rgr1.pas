PROGRAM CountWords(INPUT, OUTPUT);
USES
  StringHelper, DataHelper, SharedData;  
VAR
  Ch: CHAR;
  NewWord: Word;
  Root: Tree;

BEGIN
  Root := NIL;
  TreeDepth := 0;
  NotAddedTreeElementCount := 0;
  WHILE NOT (EOF(INPUT))
  DO
    BEGIN
      NewWord := GetWord(INPUT);
      IF NewWord <> ''
      THEN
        Insert(Root, NewWord)
    END;
  PrintTree(Root);
  IF NotAddedTreeElementCount > 0
  THEN
    WRITELN('Elements not added for tree - ', NotAddedTreeElementCount);  
END.
