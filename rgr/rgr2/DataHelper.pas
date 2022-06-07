UNIT DataHelper;

INTERFACE
USES
  SharedData, StringHelper, IntegerHelper, StackHelper;

PROCEDURE GetCountWordInfo(VAR InsertText, OutputFile: Text);

IMPLEMENTATION

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

PROCEDURE SwapFileNames(VAR OutFile, SharedFile: TEXT);
BEGIN  
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

// Печать всего дерева по указателю
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

// Печатает все строки меньше чем в дереве.
PROCEDURE PrintLowestFileValues(VAR SharedFile, OutFile: TEXT; VAR MaxTreeValue, OutFileKey, State: STRING;VAR OutFileValue: INTEGER);
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

PROCEDURE MergeTree(Ptr: Tree; VAR SharedFile, OutFile: TEXT;VAR State, OutFileKey: STRING; VAR OutFileValue: INTEGER;VAR ReadyToPush: BOOLEAN);
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

        MergeTree(Ptr^.LLink, SharedFile, OutFile, State, OutFileKey, OutFileValue, ReadyToPush);

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
            // IF ( OutFileKey = Ptr^.Key) // строка из файла ==
            // THEN
            //   BEGIN
            //     WRITELN(SharedFile, Ptr^.Key, ' ',Ptr^.Count + OutFileValue);
            //     OutFileKey := GetWord(OutFile);
            //     IF OutFileKey = ''
            //     THEN
            //       State := 'E';
            //     OutFileValue := GetValue(OutFile)
            //   END
            // ELSE
            //   WRITELN(SharedFile, Ptr^.Key, ' ',Ptr^.Count); 
          END;        
        IF ( OutFileKey = Ptr^.Key) // строка из файла ==
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
            MergeTree(Ptr^.RLink, SharedFile, OutFile, State, OutFileKey, OutFileValue, ReadyToPush);
          END;          
        END
      ELSE
        BEGIN          
          PrintTree(Ptr, OutFile);
        END;       
    END
END; 

//дозапись в shared, если outFile не пустой
PROCEDURE AppendLostOfOutFile(VAR OutFile, SharedFile: TEXT); 
VAR
  OutFileKey: STRING;
  OutFileValue: INTEGER;
BEGIN
  WHILE NOT EOF(OutFile)
  DO
   BEGIN
    OutFileKey := GetWord(OutFile);
    IF OutFileKey = ''
    THEN
      BREAK;
    OutFileValue := GetValue(OutFile);
    WRITELN(SharedFile, OutFileKey, ' ', OutFileValue)
   END
END;

// сливаем дерево и ветку
PROCEDURE MergeTreeToFile(Root: Tree; VAR SharedFile, OutFile: TEXT); 
VAR
  State, OutFileKey: STRING; // W - work, E - EndOfFile
  OutFileValue: INTEGER;
  ReadyToPush: BOOLEAN;
BEGIN
  State := 'W';
  ReadyToPush:= FALSE;
  REWRITE(SharedFile);  
  RESET(OutFile);
  OutFileKey := GetWord(OutFile);
  OutFileValue := GetValue(OutFile);
  IF OutFileKey = ''
  THEN   
    PrintTree(Root, SharedFile)    
  ELSE
    MergeTree(Root, SharedFile, OutFile, State, OutFileKey, OutFileValue, ReadyToPush);  
  IF State <> 'E'
  THEN
    BEGIN
      WRITELN(SharedFile, OutFileKey, ' ', OutFileValue);
      AppendLostOfOutFile(OutFile, SharedFile);    
    END
END;

//добавление 1-го элемента в дерево
PROCEDURE Insert(VAR Ptr:Tree; Data: ValidWord; VAR TreeDepth: INTEGER;VAR SharedFile, OutFile: TEXT);
VAR
  Overflow: BOOLEAN;
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
              MergeTreeToFile(Ptr, SharedFile, OutFile);
              CleanupTree(Ptr);
              SwapFileNames(OutFile, SharedFile);
              TreeDepth := 0;
              Ptr := NIL;              
            END         
        END
      ELSE
        BEGIN          
          IF Ptr^.Key = Data
          THEN
            Ptr^.Count:= Ptr^.Count + 1
          ELSE IF Ptr^.Key > Data
          THEN
            Insert(Ptr^.LLink, Data, TreeDepth, SharedFile, OutFile)
          ELSE
            Insert(Ptr^.RLink, Data, TreeDepth, SharedFile, OutFile)
        END        
    END
END;

//Печать шары в файл
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

PROCEDURE PrintData(Root: Tree; VAR OutputFile, SharedFile, OutFile: Text ); 
BEGIN
  MergeTreeToFile(Root, SharedFile, OutFile);  
  CleanupTree(Root);
  SwapFileNames(OutFile, SharedFile);
  PrintDataForFile(OutFile, OutputFile);
END;

PROCEDURE GetCountWordInfo(VAR InsertText, OutputFile: Text);
VAR
  NewWord: ValidWord;
  TreeDepth: INTEGER;
  SharedFile: TEXT;
  OutFile: TEXT;
  Root: Tree;
BEGIN
  Assign(SharedFile,'data/shared.txt');
  Assign(OutFile,'data/out.txt');
  REWRITE(SharedFile);
  REWRITE(OutFile);
  RESET(OutFile);
  TreeDepth := 0;
  Root := NIL;
  WHILE NOT (EOF(InsertText))
  DO
    BEGIN
      NewWord := GetWord(InsertText);
      IF NewWord <> ''
      THEN
        Insert(Root, NewWord, TreeDepth, SharedFile, OutFile)
    END;
  PrintData(Root, OutputFile,  SharedFile, OutFile); 
END;


BEGIN  
END.

