UNIT SharedData;

INTERFACE
CONST
  MaxWordLength = 50;
  MaxTreeDepth = 15000;
TYPE
  ValidWord = STRING[MaxWordLength];
  Tree = ^NodeType;
  List = ^ListType; // ���᮪ ��� ������ ���� ��ॢ�, �࠭�� � ᥡ� ������⢮ ���祭�� � ���������� �᭮��� ᫮��
  ListType = RECORD 
              Word: ValidWord;
              Count: INTEGER;              
              Next: List;                
            END;     
  NodeType = RECORD
              Key: ValidWord; // �᭮�� ᫮��
              WordList: List;  // 㪠��⥫� �� ���� � ᫮���� � ���������� �᭮���
              LLink, RLink: Tree
            END;  
IMPLEMENTATION

BEGIN
END.