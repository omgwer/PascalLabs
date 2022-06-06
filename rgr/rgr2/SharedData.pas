UNIT SharedData;

INTERFACE
CONST
  MaxWordLength = 50;
  MaxTreeDepth = 100;
TYPE
  ValidWord = STRING[MaxWordLength];
  Tree = ^NodeType;
  NodeType = RECORD
              Key: ValidWord;
              Count: INTEGER;
              LLink, RLink: Tree
            END;
       
IMPLEMENTATION

BEGIN
END.