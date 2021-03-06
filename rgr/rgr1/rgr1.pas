PROGRAM CountWords(INPUT, OUTPUT);
USES
  StringHelper, DataHelper, SharedData;  

PROCEDURE CountWords(InputText: Text);
VAR
  NewWord: Word;
BEGIN
  WHILE NOT (EOF(InputText))
  DO
    BEGIN
      NewWord := GetWord(InputText);
      IF NewWord <> ''
      THEN
        InsertWord(NewWord)
    END  
END;
  
BEGIN  
  InitData();
  CountWords(INPUT);
  PrintAllTree();
  PrintOverflowError();  
END.