UNIT DataHelper;

INTERFACE
USES
  SharedData, StringHelper, IntegerHelper;

PROCEDURE InsertWord(Data: ValidWord);
PROCEDURE PrintAllTree();
PROCEDURE InitData();

IMPLEMENTATION
VAR
  TreeDepth: INTEGER;
  Root: Tree;
  SharedFile: TEXT;
  OutFile: TEXT;

PROCEDURE SwapName();
BEGIN
  Close(SharedFile);
  Close(OutFile);
  Rename(SharedFile, 'data/ch.txt');
  Rename(OutFile, 'data/shared.txt');
  Rename(SharedFile, 'data/out.txt');
  Assign(SharedFile,'data/shared.txt');
  Assign(OutFile,'data/out.txt')
END; 

//Сливает 1 элемент дерева с файлом.
PROCEDURE MergeForSharedFile(Key: STRING; Count: INTEGER; VAR SharedFile: Text; VAR OutFile: Text );
VAR
  OutFileKey: STRING;
  OutFileValue: INTEGER;
  State: CHAR; // S - search, F - finish
BEGIN
  IF (NOT EOF(OutFile))
  THEN
    WHILE (NOT EOF(OutFile)) 
    DO
      BEGIN
        OutFileKey := GetWord(OutFile);               
        OutFileValue := GetValue(OutFile);
        WRITELN(OUTPUT, OutFileKey,'--', OutFileValue);
        IF (Key < OutFileKey) OR (OutFileKey = '') OR (OutFileValue < 0)
        THEN        
          WRITELN(SharedFile, Key, ' ', Count)        
        ELSE IF (Key = OutFileKey)
        THEN        
          WRITELN(SharedFile, Key, ' ', Count + OutFileValue )
        ELSE  // Key > OutFileKey
          BEGIN
            WHILE (Key > OutFileKey)
            DO
              BEGIN
                WRITELN(SharedFile, OutFileKey, ' ', OutFileValue);
                OutFileKey := GetWord(OutFile);
                IF OutFileKey = ''
                THEN
                  BREAK;
                OutFileValue := GetValue(OutFile);
                IF OutFileValue < 0
                THEN
                  BREAK;
                IF Key = OutFileKey
                THEN
                  WRITELN(SharedFile, Key, ' ', Count + OutFileValue );
                IF (Key < OutFileKey)
                THEN        
                  WRITELN(SharedFile, Key, ' ', Count)
              END            
          END      
      END
  ELSE  
    WRITELN(SharedFile, Key, ' ', Count)
END;

PROCEDURE MergeTree(Ptr: Tree; VAR SharedFile: Text; VAR OutFile: Text);
BEGIN 
  IF Ptr <> NIL
  THEN  {Печатает поддерево слева, вершину, поддерево справа}
    BEGIN
      MergeTree(Ptr^.LLink, SharedFile, OutFile);      
      MergeForSharedFile(Ptr^.Key, Ptr^.Count, SharedFile, OutFile);
      //WRITELN(OUTPUT, Ptr^.Key, ' ', Ptr^.Count);
      MergeTree(Ptr^.RLink, SharedFile, OutFile)
    END 
END;

PROCEDURE Insert(VAR Ptr:Tree; Data: ValidWord);
VAR
  Overflow: BOOLEAN;
  ComparisonResult: CHAR;
BEGIN
  Overflow := FALSE;
  IF NOT Overflow
  THEN
    BEGIN
      IF Ptr = NIL
      THEN
        BEGIN {Создаем лист со значением Data}
          IF TreeDepth < MaxTreeDepth  // Проверяем дерево на переполнение
          THEN
            BEGIN
              NEW(Ptr);
              TreeDepth := TreeDepth + 1;
              Ptr^.Key := Data;
              Ptr^.Count:= 1;
              Ptr^.LLink := NIL;
              Ptr^.RLink := NIL
            END
          ELSE
            BEGIN
              // REWRITE(SharedFile);
              // RESET(OutFile);         
              // MergeTree(Root, SharedFile, OutFile); // мерджим Root + OutFile => SharedFile
              // SwapName();
              // TreeDepth := 0;
              // Root := NIL;
            END         
        END
      ELSE
        BEGIN
          ComparisonResult := ComparisonWord(Ptr^.Key, Data);
          IF ComparisonResult = '='
          THEN
            Ptr^.Count:= Ptr^.Count + 1
          ELSE IF ComparisonResult = '>'
          THEN
            Insert(Ptr^.LLink, Data)
          ELSE
            Insert(Ptr^.RLink, Data)
        END        
    END
END;

PROCEDURE InsertWord(Data: ValidWord);
BEGIN
  Insert(Root, Data); 
END;

PROCEDURE PrintSharedForFile(VAR SharedFile: TEXT; VAR OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN
  REWRITE(OutFile);
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

PROCEDURE PrintAllTree();
VAR
  Ch: CHAR;
BEGIN
  REWRITE(SharedFile);
  RESET(OutFile);  
  MergeTree(Root, SharedFile, OutFile);
  Close(SharedFile);
  //SwapName();
//  Отлажено и работает.
  // RESET(OutFile);
  // PrintSharedForFile(OutFile, OUTPUT)
END;  

PROCEDURE InitData();
BEGIN
  Assign(SharedFile,'data/shared.txt');
  Assign(OutFile,'data/out.txt');
  TreeDepth := 0;  
END;

BEGIN
END.