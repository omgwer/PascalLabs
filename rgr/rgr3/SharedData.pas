UNIT SharedData;

INTERFACE
CONST
  MaxWordLength = 50;
  MaxTreeDepth = 2500;
TYPE
  ValidWord = STRING[MaxWordLength];
  Tree = ^NodeType;

  List = ^ListType; // ���᮪ ��� ������ ���� ��ॢ�, �࠭�� � ᥡ� ������⢮ ���祭�� � ���������� �᭮��� ᫮��
  ListType = RECORD 
              Word: ValidWord;              
              Next: List;                
            END;
  NodeType = RECORD
              Key: ValidWord;
              Count: INTEGER;
              LLink, RLink: Tree
            END;       
IMPLEMENTATION

BEGIN
END.