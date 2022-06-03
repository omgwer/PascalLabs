UNIT DataHelper;

INTERFACE
USES
  SharedData, StringHelper;

PROCEDURE InsertWord(Data: Word);
PROCEDURE PrintAllTree();
PROCEDURE InitData();
PROCEDURE PrintOverflowError();

IMPLEMENTATION
VAR
  TreeDepth: INTEGER;
  NotAddedTreeElementCount: INTEGER;
  Root: Tree;

PROCEDURE MergeBranchToFile(Ptr: Tree; TreeDepth: INTEGER;VAR OutText: Text);
BEGIN
  WRITELN(OutText, 'kek');
END;

PROCEDURE Insert(VAR Ptr:Tree; Data: Word);
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
              NotAddedTreeElementCount := NotAddedTreeElementCount + 1;
              MergeBranchToFile(Root, TreeDepth, OUTPUT);
            END;
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

PROCEDURE InsertWord(Data: Word);
BEGIN
  Insert(Root, Data);
END;

PROCEDURE PrintTree(Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN  {���⠥� �����ॢ� ᫥��, ���設�, �����ॢ� �ࠢ�}
    BEGIN
      PrintTree(Ptr^.LLink);
      WRITELN(OUTPUT,Ptr^.Key, ' ', Ptr^.Count);
      PrintTree(Ptr^.RLink)
    END 
END;  {PrintTree} 

PROCEDURE PrintAllTree();
BEGIN
  PrintTree(Root)
END;

PROCEDURE InitData();
BEGIN  
  TreeDepth := 0;
  NotAddedTreeElementCount := 0
END;

PROCEDURE PrintOverflowError();
BEGIN
  IF NotAddedTreeElementCount > 0
  THEN
    WRITELN('Elements not added for tree - ', NotAddedTreeElementCount)  
END;


// �������� ����� �������� GetKey �� GetWord. ��९���� �㭪��
// ��द�� ��ॢ� � ��室��� 䠩� 
FUNCTION GetKey();
BEGIN
END;

FUNCTION GetValue(): INTEGER;
BEGIN
END;



BEGIN
END.