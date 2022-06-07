UNIT DataHelper;

INTERFACE
USES
  SharedData, StringHelper, IntegerHelper, StackHelper;

PROCEDURE InsertData(VAR InsertText: Text);
PROCEDURE PrintData(VAR OutputFile: Text);  

IMPLEMENTATION
VAR
  TreeDepth: INTEGER;
  Root: Tree;
  SharedFile: TEXT;
  OutFile: TEXT;

  //OutFileKey: STRING;
  //OutFileValue: INTEGER; 
  ReadyToPush: BOOLEAN;
  //State: STRING;

PROCEDURE CleanupTree(Ptr: Tree);
BEGIN
  IF Ptr <> NIL
  THEN
    BEGIN
      CleanupTree(Ptr^.LLink);
      CleanupTree(Ptr^.RLink);
      DISPOSE(Ptr)
    END;
  Ptr := NIL
END;

PROCEDURE SwapName();
BEGIN
  RESET(OutFile);
  RESET(SharedFile);
  Close(SharedFile);
  Close(OutFile);
  Rename(SharedFile, 'data/ch.txt');
  Rename(OutFile, 'data/shared.txt');
  Rename(SharedFile, 'data/out.txt');
  Assign(SharedFile,'data/shared.txt');
  Assign(OutFile,'data/out.txt');
  RESET(OutFile);
  REWRITE(SharedFile);
END;

// Печатает все строки меньше чем в дереве.
PROCEDURE PrintLowestFileValues(VAR SharedFile: TEXT;VAR OutFile: TEXT; VAR MaxTreeValue: STRING;VAR OutFileKey:STRING;VAR State: STRING;VAR OutFileValue: INTEGER);
BEGIN  
  WHILE (MaxTreeValue > OutFileKey) AND (State <> 'E')
  DO
    BEGIN    
      WRITELN(SharedFile, OutFileKey, ' ', OutFileValue);
      OutFileKey := GetWord(OutFile); 
      IF OutFileKey = ''
      THEN
        State := 'E'
      ELSE      
      OutFileValue := GetValue(OutFile)
    END    
END;

PROCEDURE MergeTree(Ptr: Tree; VAR SharedFile: TEXT; VAR OutFile: TEXT;VAR State: STRING; VAR OutFileKey: STRING; VAR OutFileValue: INTEGER);
BEGIN
  IF Ptr <> NIL
  THEN
    BEGIN
      IF State <> 'E'
      THEN
        BEGIN
        IF ReadyToPush AND ( OutFileKey > Ptr^.Key )  // после первого прохождения до низа ветки, нужно подготовить стэк.
        THEN
          Push(Ptr^.Key, Ptr^.Count);

        MergeTree(Ptr^.LLink, SharedFile, OutFile, State, OutFileKey, OutFileValue);

        IF NOT ReadyToPush AND ( OutFileKey > Ptr^.Key)  // печать самого первого элемента
        THEN
          BEGIN
            WRITELN(SharedFile, Ptr^.Key, ' ', Ptr^.Count); 
          END;

        IF ReadyToPush AND (Ptr^.LLink = NIL)
        THEN
          BEGIN     
            PrintStackForFile(SharedFile);        
          END;        
        ReadyToPush := TRUE;
      
        IF ( OutFileKey < Ptr^.Key ) // элемент в файле меньше
        THEN
          BEGIN            
              PrintLowestFileValues(SharedFile, OutFile, Ptr^.Key, OutFileKey, State, OutFileValue);
            IF ( OutFileKey = Ptr^.Key) // строка из файла ==
            THEN
              BEGIN
                WRITELN(SharedFile, Ptr^.Key, ' ',Ptr^.Count + OutFileValue);
                OutFileKey := GetWord(OutFile);
                IF OutFileKey = ''
                THEN
                  State := 'E';
                OutFileValue := GetValue(OutFile)
              END
            ELSE
              WRITELN(SharedFile, Ptr^.Key, ' ',Ptr^.Count); 
          END        
        ELSE IF ( OutFileKey = Ptr^.Key) // строка из файла ==
        THEN
          BEGIN
            WRITELN(SharedFile, Ptr^.Key, ' ',Ptr^.Count + OutFileValue);
            OutFileKey := GetWord(OutFile);
            IF OutFileKey = ''
                THEN
                  State := 'E';
            OutFileValue := GetValue(OutFile)
          END;
        IF ( OutFileKey > Ptr^.Key) // строка из файла больше чем в дереве  
        THEN
          BEGIN
            MergeTree(Ptr^.RLink, SharedFile, OutFile, State, OutFileKey, OutFileValue);
          END;          
        END
      ELSE
        BEGIN
          MergeTree(Ptr^.LLink, SharedFile, OutFile, State, OutFileKey, OutFileValue);
          WRITELN(SharedFile, Ptr^.Key, ' ',Ptr^.Count);
          MergeTree(Ptr^.RLink, SharedFile, OutFile, State, OutFileKey, OutFileValue);
        END;       
    END
END; 

PROCEDURE PrintTree(Ptr: Tree; VAR OutFile: TEXT);
BEGIN
  IF Ptr <> NIL
  THEN
    BEGIN
      PrintTree(Ptr^.LLink, OutFile);
      WRITELN(OutFile, Ptr^.Key, ' ',Ptr^.Count);
      PrintTree(Ptr^.RLink,OutFile);
    END;
END; 

PROCEDURE AppendLostOfOutFile(VAR OutFile: TEXT; VAR SharedFile: TEXT; VAR State: STRING;VAR OutFileKey: STRING;VAR OutFileValue: INTEGER);
VAR
  Ch: CHAR;
  Init: BOOLEAN;
BEGIN
  Init:= TRUE; // otladka do etogo bylo FALSE
  IF (OutFileKey <> '')
  THEN
    WRITELN(SharedFile, OutFileKey, ' ', OutFileValue);
  WHILE NOT EOF(OutFile)
  DO
    BEGIN
      IF (EOLN(OutFile))
      THEN
        BEGIN
          READLN(OutFile);
          IF Init
          THEN
            WRITELN(SharedFile)
          ELSE
            Init := TRUE;         
        END;        
      READ(OutFile, Ch);
      WRITE(SharedFile, Ch) 
    END
END;

PROCEDURE MergeTreeToFile(Root: Tree; VAR SharedFile: TEXT; VAR OutFile: TEXT);
VAR
  State, OutFileKey: STRING; // W - work, E - empyFile
  OutFileValue: INTEGER;
BEGIN
  State := 'W';
  REWRITE(SharedFile);  
  RESET(OutFile);

  OutFileKey := GetWord(OutFile);
  OutFileValue := GetValue(OutFile);
  IF OutFileKey = ''
  THEN
    BEGIN
    PrintTree(Root, SharedFile);
    END
  ELSE
    MergeTree(Root, SharedFile, OutFile, State, OutFileKey, OutFileValue);
  
  IF State <> 'E'
  THEN
    AppendLostOfOutFile(OutFile, SharedFile, State, OutFileKey, OutFileValue);
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
              MergeTreeToFile(Root, SharedFile, OutFile);
              Close(SharedFile);
              CleanupTree(Root);
              Reset(SharedFile); // - debug
              REWRITE(OutFile);  // - debug
              SwapName();
              TreeDepth := 0;
              Root := NIL;
              ReadyToPush:= FALSE;
            END         
        END
      ELSE
        BEGIN          
          IF Ptr^.Key = Data
          THEN
            Ptr^.Count:= Ptr^.Count + 1
          ELSE IF Ptr^.Key > Data
          THEN
            Insert(Ptr^.LLink, Data)
          ELSE
            Insert(Ptr^.RLink, Data)
        END        
    END
END;

PROCEDURE PrintSharedForFile(VAR SharedFile: TEXT; VAR OutFile: TEXT);
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

PROCEDURE PrintAllTree();
VAR
  Ch: CHAR;
BEGIN 

  MergeTreeToFile(Root, SharedFile, OutFile);
  
  Close(SharedFile);
  CleanupTree(Root);
  SwapName();
  RESET(OutFile);
  PrintSharedForFile(OutFile, OUTPUT);
END;



PROCEDURE InsertData(VAR InsertText: Text);
VAR
  NewWord: ValidWord;
BEGIN
  WHILE NOT (EOF(InsertText))
  DO
    BEGIN
      NewWord := GetWord(InsertText);
      IF NewWord <> ''
      THEN
        Insert(Root, NewWord)
    END  
END;

PROCEDURE PrintData(VAR OutputFile: Text); 
BEGIN
  PrintAllTree();
END;

BEGIN
  Assign(SharedFile,'data/shared.txt');
  Assign(OutFile,'data/out.txt');
  TreeDepth := 0;
  REWRITE(SharedFile);
  REWRITE(OutFile);
  RESET(OutFile);
  ReadyToPush:= FALSE;  
END.

