UNIT SharedData;

INTERFACE
CONST
  MaxWordLength = 50;
  MaxTreeDepth = 3;
TYPE
  Word = STRING[MaxWordLength];
  Tree = ^NodeType;
  NodeType = RECORD
              Key: Word;
              Count: INTEGER;
              LLink, RLink: Tree
            END;
       
IMPLEMENTATION


BEGIN
END.