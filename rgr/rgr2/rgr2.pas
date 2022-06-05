PROGRAM CountWords(INPUT, OUTPUT);
USES
  StringHelper, DataHelper, SharedData;  

PROCEDURE CountWords(VAR InputText: Text);
VAR
  NewWord: ValidWord;
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
END. 