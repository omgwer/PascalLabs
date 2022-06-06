UNIT DataHelper;

INTERFACE
USES
  SharedData, StringHelper, IntegerHelper;

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
  OutFileKey: STRING;
  OutFileValue: INTEGER;  
  OneInit: BOOLEAN;

  MinValue: STRING;
  MaxValue: STRING;
  MaxValueCount: INTEGER;
 

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

// MinKey - �������쭮� ���祭�� � ��ॢ�, ���஥ 㦥 ��ࠡ�⠭�.
// MaxKey - ���祭�� �� 䠩��, return (MinKey, MaxKey)
PROCEDURE PrintTree(Ptr: Tree; VAR OutFile: Text;VAR MinKey: String;VAR MaxKey: String);
BEGIN
 IF Ptr <> NIL
  THEN  {���⠥� �����ॢ� ᫥��, ���設�, �����ॢ� �ࠢ�}
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
  THEN  {���⠥� �����ॢ� ᫥��, ���設�, �����ॢ� �ࠢ�}
    BEGIN            
      PrintTree(Ptr^.LLink , OutFile, MinKey, MaxKey); 
      WRITELN(OutFile, Ptr^.Key, ' ', Ptr^.Count);
      PrintTree(Ptr^.RLink, OutFile,MinKey, MaxKey);      
    END 
END; 

// //������� 1 ����� ��ॢ� � 䠩���.
// PROCEDURE MergeForSharedFile(Ptr: Tree; Key: STRING; Count: INTEGER; VAR SharedFile: Text; VAR OutFile: Text );
// VAR  
//   State: CHAR; // W -work , E - error, F - finish
// BEGIN
//   State := 'W';
//   IF (NOT EOF(OutFile))
//   THEN    
//     BEGIN
//       BeforeFileKey := MaxKey;
//       IF (Key > MaxKey) AND OneInit
//       THEN
//         BEGIN
//           OneInit := FALSE;
//           OutFileKey := GetWord(OutFile);                         
//           OutFileValue := GetValue(OutFile);
//           IF OutFileKey = ''
//           THEN
//             MaxKey := '���'
//           ELSE
//             BEGIN                           
//               MaxKey := OutFileKey;              
//             END;
//         END;

//       IF (OutFileKey = '') OR (OutFileValue < 0)
//       THEN
//         PrintFullTree(Ptr, SharedFile)
//       ELSE IF (Key < OutFileKey)
//       THEN
//         BEGIN
//           WRITELN(SharedFile, '  Step < ', MinKey,' ', MaxKey, ' ', OutFileKey, ' ', Key, ' ', BeforeFileKey);
          
//           PrintTree(Ptr, SharedFile, MinKey, MaxKey);

//           WRITELN(SharedFile, '  EndStep < ',  MinKey,' ', MaxKey, ' ', OutFileKey, ' ', Key, ' ', BeforeFileKey);        
//         END
//       ELSE IF (Key = OutFileKey)
//       THEN
//         BEGIN
//           WRITELN(SharedFile, '  Step =');

//           WRITELN(SharedFile, Key, ' ', Count + OutFileValue );
//           MinKey := Key;

//           OutFileKey := GetWord(OutFile);                         
//           OutFileValue := GetValue(OutFile);
//           IF OutFileKey = ''
//           THEN
//             MaxKey := '���'
//           ELSE
//             BEGIN                           
//               MaxKey := OutFileKey;              
//             END; 

//           WRITELN(SharedFile, '  EndStep =');
//         END
//       ELSE
//         BEGIN
//           WRITELN(SharedFile, '  Step > ', MinKey,' ', MaxKey, ' ', OutFileKey, ' ', Key, ' ', BeforeFileKey);
//           WHILE (Key > OutFileKey) AND (State <> 'E')
//           DO
//             BEGIN
//               WRITELN(SharedFile, OutFileKey, ' ', OutFileValue);
//               MaxKey := OutFileKey;              
//               OutFileKey := GetWord(OutFile);
//               IF OutFileKey = ''
//               THEN
//                 State := 'E';
//               OutFileValue := GetValue(OutFile);
//               IF OutFileValue < 0
//               THEN
//                 State := 'E';
//               IF Key = OutFileKey
//               THEN
//                 BEGIN
//                   WRITELN(SharedFile, Key, ' ', Count + OutFileValue );
//                   MinKey := Key
//                 END;
//               IF (Key < OutFileKey)
//               THEN
//                 BEGIN        
//                   WRITELN(SharedFile, Key, ' ', Count);
//                   MinKey := Key;
//                   BeforeFileKey := MaxKey;
//                   MaxKey := OutFileKey; 
//                 END;                
//             END;
//           WRITELN(SharedFile, Key, ' ', Count);
//           WRITELN(SharedFile, '  EndStep >', MinKey,' ', MaxKey, ' ', OutFileKey, ' ', Key);
//         END      
//       END
//   ELSE
//     WRITELN(SharedFile, '  Step EOF');   
//     PrintFullTree(Ptr, SharedFile);    
// END;

// PROCEDURE MergeTree(Ptr: Tree; VAR SharedFile: Text; VAR OutFile: Text);
// BEGIN 
//   IF Ptr <> NIL
//   THEN  {���⠥� �����ॢ� ᫥��, ���設�, �����ॢ� �ࠢ�}
//     BEGIN
//       MergeTree(Ptr^.LLink, SharedFile, OutFile);    
//       MergeForSharedFile(Ptr, Ptr^.Key, Ptr^.Count, SharedFile, OutFile);
//       //WRITELN(OUTPUT, Ptr^.Key, ' ', Ptr^.Count);
//       MergeTree(Ptr^.RLink, SharedFile, OutFile)
//     END
// END;

// PROCEDURE MergeTree(Ptr: Tree; MinValue: String; MaxValue: String; MaxValueCount: INTEGER; VAR SharedFile: Text);
// BEGIN
//   IF Ptr <> NIL
//   THEN
//     BEGIN
//       IF MaxValue <> '' //�᫨ ��।��� ������ ��ப� => 䠩� �����稫�� ����� �����뢠�� ���� �� ����.
//       THEN
//         BEGIN
//           IF (Ptr^.Key > MinValue)
//           THEN      
//             MergeTree(Ptr^.LLink, MinValue, MaxValue, MaxValueCount, SharedFile);
//           IF (Ptr^.Key < MaxValue) 
//           THEN
//             BEGIN
//               WRITELN(OUTPUT, Ptr^.Key, ' ', Ptr^.Count);
//             END;  
//           IF (Ptr^.Key = MaxValue)
//           THEN
//             BEGIN
//               WRITELN(OUTPUT, MaxValue, ' ', Ptr^.Count + MaxValueCount);          
//               // CleanupTree(Ptr^.LLink); -- 㤠����� ��᪠ ��⢨
//               // Ptr := Ptr^.RLink; 
//             END;
//           MergeTree(Ptr^.RLink, MinValue, MaxValue, MaxValueCount, SharedFile);
//         END
//       ELSE  // -- �᫨ MaxValue == '' ����� 䠩� ���⮩ ���⠥� ���⮪ ��ॢ� �� ����.
//         BEGIN
//           IF (Ptr^.Key > MinValue)
//           THEN      
//             MergeTree(Ptr^.LLink, MinValue,MaxValue, MaxValueCount, SharedFile);
//           IF (Ptr^.Key > MinValue)
//           THEN          
//             WRITELN(OUTPUT, Ptr^.Key, ' ', Ptr^.Count);          
//           MergeTree(Ptr^.RLink, MinValue, MaxValue, MaxValueCount, SharedFile);
//         END;
//     END
// END;

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
              // REWRITE(SharedFile);
              // RESET(OutFile);                                                
              // MergeTree(Root, SharedFile, OutFile); // ��द�� Root + OutFile => SharedFile 
              // PrintFile(OutFile, SharedFile);  // �������뢠�� ����⪨ sharedFile
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
  MinValue := '';
  MergeTree(Root,  MinValue, MaxValue, MaxValueCount, SharedFile);
  WRITELN(OUTPUT, 'ENDFIRST');
  MaxValue := '�������';

  MergeTree(Root, MinValue, MaxValue, MaxValueCount, SharedFile);

  // MergeTree(Root, SharedFile, OutFile);  // ᫨���� ��ॢ� � ��室��� 䠩� � ���
  // PrintFile(OutFile, SharedFile);  // �������뢠�� outFile � SharedFile
  // CleanupTree(Root);  // ��⨬ ��ॢ�
  // Close(SharedFile);
  //SwapName();
  //RESET(OutFile);
  //PrintSharedForFile(OutFile, OUTPUT);
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
END;

BEGIN
END.