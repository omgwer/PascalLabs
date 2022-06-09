UNIT SharedData;

INTERFACE
CONST
  MaxWordLength = 50;
  MaxTreeDepth = 2500;
TYPE
  ValidWord = STRING[MaxWordLength];
  Tree = ^NodeType;
  List = ^ListType;
  ListType = RECORD
              Key: ValidWord;
              
            END;
  NodeType = RECORD
              Key: ValidWord;
              Count: INTEGER;
              LLink, RLink: Tree
            END;       
IMPLEMENTATION

BEGIN
END.