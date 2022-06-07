UNIT DataHelper;

INTERFACE
USES
  SharedData, StringHelper, IntegerHelper, StackHelper;

PROCEDURE InsertWord(Data: ValidWord);
PROCEDURE PrintAllTree();
PROCEDURE InitData();

IMPLEMENTATION
VAR
  TreeDepth, BeforeFileValue: INTEGER;
  Root: Tree;
  SharedFile: TEXT;
  OutFile: TEXT;
  MinKey, MaxKey, BeforeFileKey: STRING;   
  OneInit: BOOLEAN;

  OutFileKey: STRING;
  OutFileValue: INTEGER; 

  MinValue: STRING;
  MaxValue: STRING;
  MaxValueCount: INTEGER;
  ReadyToPush: BOOLEAN;
  State: STRING;
 

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

// MinKey - минимальное значение в дереве, которое уже обработано.
// MaxKey - значение из файла, return (MinKey, MaxKey)
PROCEDURE PrintTree(Ptr: Tree; VAR OutFile: Text;VAR MinKey: String;VAR MaxKey: String);
BEGIN
 IF Ptr <> NIL
  THEN  {Печатает поддерево слева, вершину, поддерево справа}
    BEGIN      
      IF (Ptr^.Key > MinKey)
      THEN        
          PrintTree(Ptr^.LLink , OutFile, MinKey, MaxKey); 
      IF (Ptr^.Key > MinKey) AND (Ptr^.Key < MaxKey)
      THEN
        BEGIN
          WRITELN(OutFile, Ptr^.Key, ' ', Ptr^.Count);
          MinKey := Ptr^.Key;
        END;
      IF (Ptr^.Key < MaxKey)
      THEN
        PrintTree(Ptr^.RLink, OutFile,MinKey, MaxKey);      
    END 
END; 

PROCEDURE PrintFullTree(Ptr: Tree; VAR OutFile: Text);
BEGIN
 IF Ptr <> NIL
  THEN  {Печатает поддерево слева, вершину, поддерево справа}
    BEGIN            
      PrintTree(Ptr^.LLink , OutFile, MinKey, MaxKey); 
      WRITELN(OutFile, Ptr^.Key, ' ', Ptr^.Count);
      PrintTree(Ptr^.RLink, OutFile,MinKey, MaxKey);      
    END 
END; 

// Печатает все строки меньше чем в дереве.
PROCEDURE PrintLowestFileValues(VAR SharedFile: TEXT; VAR MaxTreeValue: STRING; VAR MaxTreeCount: INTEGER);
BEGIN
  WRITELN(SharedFile, OutFileKey, ' ', OutFileValue);
  OutFileKey := GetWord(OutFile); 
  IF OutFileKey = ''
  THEN
    State := 'EOF'; 
  OutFileValue := GetValue(OutFile); 
  WHILE (MaxTreeValue > OutFileKey) AND (State <> 'EOF')
  DO
    BEGIN    
      WRITELN(SharedFile, OutFileKey, ' ', OutFileValue);
      OutFileKey := GetWord(OutFile); 
      IF OutFileKey = ''
      THEN
        State := 'EOF';      
      OutFileValue := GetValue(OutFile);
    END;    
END;

PROCEDURE MergeTree(Ptr: Tree; VAR SharedFile: Text);
BEGIN
  IF Ptr <> NIL
  THEN
    BEGIN
      IF State <> 'EOF'
      THEN
        BEGIN
        IF ReadyToPush AND ( OutFileKey > Ptr^.Key )  // после первого прохождения до низа ветки, нужно подготовить стэк.
        THEN
          Push(Ptr^.Key, Ptr^.Count);

        MergeTree(Ptr^.LLink, SharedFile);

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
            IF (State <> 'EOF')
            THEN
              PrintLowestFileValues(SharedFile, Ptr^.Key, Ptr^.Count);
            IF ( OutFileKey = Ptr^.Key) // строка из файла ==
            THEN
              BEGIN
                WRITELN(SharedFile, Ptr^.Key, ' ',Ptr^.Count + OutFileValue);
                OutFileKey := GetWord(OutFile);
                IF OutFileKey = ''
                THEN
                  State := 'EOF';
                OutFileValue := GetValue(OutFile)
              END
            ELSE
              WRITELN(SharedFile, Ptr^.Key, ' ',Ptr^.Count); 
          END;         
        IF ( OutFileKey = Ptr^.Key) // строка из файла ==
        THEN
          BEGIN
            WRITELN(SharedFile, Ptr^.Key, ' ',Ptr^.Count + OutFileValue);
            OutFileKey := GetWord(OutFile);
            IF OutFileKey = ''
                THEN
                  State := 'EOF';
            OutFileValue := GetValue(OutFile)
          END;
        IF ( OutFileKey > Ptr^.Key) // строка из файла больше чем в дереве  
        THEN
          BEGIN
            MergeTree(Ptr^.RLink, SharedFile);
          END;              
        END
      ELSE
        BEGIN
          MergeTree(Ptr^.LLink, SharedFile);
          WRITELN(SharedFile, Ptr^.Key, ' ',Ptr^.Count);
          MergeTree(Ptr^.RLink, SharedFile);
        END;       
    END
END;

PROCEDURE MergeForSharedFile(Ptr: Tree; Key: STRING; Count: INTEGER; VAR SharedFile: Text; VAR OutFile: Text );
BEGIN
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

PROCEDURE PrintFile(VAR OutFile: TEXT; VAR SharedFile: TEXT);
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
              REWRITE(SharedFile);  
              RESET(OutFile);
              OutFileKey := GetWord(OutFile);
              OutFileValue := GetValue(OutFile);
              State := 'W';          // W - work , EOF - endOfFile
              IF OutFileKey = ''
              THEN
                State := 'EOF';

              MergeTree(Root, SharedFile);   // сливаем дерево и выходной файл в шару
              PrintFile(OutFile, SharedFile);  // дозаписываем outFile в SharedFile
              Close(SharedFile);
              CleanupTree(Root);
              Reset(SharedFile); // - debug
              REWRITE(OutFile);  // - debug
              SwapName();
              TreeDepth := 0;
              Root := NIL;
              ReadyToPush:= FALSE;

              // REWRITE(SharedFile);
              // RESET(OutFile);                                                
              // MergeTree(Root, SharedFile, OutFile); // мерджим Root + OutFile => SharedFile 
              // PrintFile(OutFile, SharedFile);  // дозаписываем остататки sharedFile
              // CleanupTree(Root);
              // Reset(SharedFile); // - debug
              // REWRITE(OutFile);  // - debug
              // SwapName();
              // TreeDepth := 0;
              // Root := NIL;
              // OneInit := TRUE;  //otladka
              // MinKey := 'a';  //otladka
              // MaxKey := 'a';  //otladka
              // BeforeFileKey := '';  //otladka
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
  REWRITE(SharedFile);  
  RESET(OutFile);
  OutFileKey := GetWord(OutFile);
  OutFileValue := GetValue(OutFile);
  State := 'W';          // W - work , EOF - endOfFile
  IF OutFileKey = ''
  THEN
    State := 'EOF';

  MergeTree(Root, SharedFile);   // сливаем дерево и выходной файл в шару
  PrintFile(OutFile, SharedFile);  // дозаписываем outFile в SharedFile
  Close(SharedFile);
  CleanupTree(Root);
  SwapName();
  RESET(OutFile);
  PrintSharedForFile(OutFile, OUTPUT);
END;

PROCEDURE InitData();
BEGIN
  Assign(SharedFile,'data/shared.txt');
  Assign(OutFile,'data/out.txt');
  TreeDepth := 0;
  MinKey := 'a';  
  MaxKey := 'a';
  BeforeFileKey := '';
  REWRITE(SharedFile);
  //REWRITE(OutFile);
  RESET(OutFile);
  OneInit := TRUE;
  InitStack();
  ReadyToPush:= FALSE;
END;

BEGIN
END.

abba 1
abracadarbra 1
тестк 1
тесткек 1
яллялу 1
