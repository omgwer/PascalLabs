PROGRAM CountWords(INPUT, OUTPUT);
USES
  StringHelper, DataHelper, SharedData;  
VAR
  NewWord: Word;
  
BEGIN  
  InitData();
  WHILE NOT (EOF(INPUT))
  DO
    BEGIN
      NewWord := GetWord(INPUT);
      IF NewWord <> ''
      THEN
        Insert(Root, NewWord)
    END;
  PrintTree(Root);
  PrintOverflowError();  
END.