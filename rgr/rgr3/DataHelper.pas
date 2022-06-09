UNIT DataHelper;

INTERFACE
USES
  SharedData, StringHelper, StackHelper;

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

// ����� �ᥣ� ��ॢ� �� 㪠��⥫�
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

// ���⠥� �� ��ப� ����� 祬 � ��ॢ�.
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
        READ(OutFile, OutFileValue)
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
        IF ReadyToPush AND ( OutFileKey > Ptr^.Key )  // ��᫥ ��ࢮ�� ��宦����� �� ���� ��⪨, �㦭� �����⮢��� ���.
        THEN                                          // ����� ࠧ, ����� �������� � ����� ����, ��訬 � ���
          Push(Ptr);

        MergeTree(Ptr^.LLink, SharedFile, OutFile, State, OutFileKey, OutFileValue, ReadyToPush);

        IF NOT ReadyToPush AND ( OutFileKey > Ptr^.Key)  // ����� ᠬ��� ��ࢮ�� �����
        THEN                                             // �� ��ࢮ� ��室�� ����� � ��� �����, ���⠥� ⮫쪮 ᠬ�� �����쪮� ���祭��
          WRITELN(SharedFile, Ptr^.Key, ' ', Ptr^.Count);           

        IF ReadyToPush AND (Ptr^.LLink = NIL) // �᫨ ��諨 �� ���� ����� ��⪨, ��訬 � ��� � 䠩�
        THEN              
          PrintStackForFile(SharedFile);  

        ReadyToPush := TRUE;  // ��᫥ ��ࢮ�� ��宦����� �� ���� �����, ࠧ�蠥��� ����� � ���.
      
        IF ( OutFileKey < Ptr^.Key ) // ����� � 䠩�� �����, �����뢠�� ��ப� �� 䠩��, ���� ��� ����� ���� 㪠��⥫�
        THEN                    
          PrintLowestFileValues(SharedFile, OutFile, Ptr^.Key, OutFileKey, State, OutFileValue); 
        IF ( OutFileKey = Ptr^.Key) // ��ப� �� 䠩�� ==
        THEN
          BEGIN
            WRITELN(SharedFile, Ptr^.Key, ' ',Ptr^.Count + OutFileValue);
            OutFileKey := GetWord(OutFile);
            IF OutFileKey = ''
            THEN
              State := 'E'
            ELSE
              READ(OutFile, OutFileValue)
          END;          
        IF ( OutFileKey > Ptr^.Key) // ��ப� �� 䠩�� ����� 祬 � ��ॢ�  
        THEN                     
          MergeTree(Ptr^.RLink, SharedFile, OutFile, State, OutFileKey, OutFileValue, ReadyToPush);                               
        END
      ELSE
        BEGIN          
          PrintTree(Ptr, OutFile)
        END       
    END
END; 

//�������� � shared, �᫨ outFile �� ���⮩
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
      BREAK
    ELSE
      READ(OutFile, OutFileValue);
    WRITELN(SharedFile, OutFileKey, ' ', OutFileValue)
   END
END;

// ᫨���� ��ॢ� � ����
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
  //OutFileValue := GetValue(OutFile);
  IF OutFileKey = ''
  THEN
    BEGIN   
      PrintTree(Root, SharedFile);
      State := 'E'
    END    
  ELSE
    BEGIN
      READ(OutFile, OutFileValue);
      MergeTree(Root, SharedFile, OutFile, State, OutFileKey, OutFileValue, ReadyToPush); 
    END; 
  IF (State <> 'E')
  THEN
    BEGIN
      WRITELN(SharedFile, OutFileKey, ' ', OutFileValue);
      AppendLostOfOutFile(OutFile, SharedFile);    
    END
END;

//���������� 1-�� ����� � ��ॢ�
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
        BEGIN {������� ���� � ���祭��� Data}
          IF TreeDepth < MaxTreeDepth  // �஢��塞 ��ॢ� �� ��९�������
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

//����� ��� � 䠩�
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
        Insert(Root, NewWord, TreeDepth, SharedFile, OutFile);
      IF TreeDepth = 0
      THEN
        Insert(Root, NewWord, TreeDepth, SharedFile, OutFile);                 
    END;
  PrintData(Root, OutputFile,  SharedFile, OutFile); 
END;


BEGIN  
END.