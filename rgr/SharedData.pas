UNIT SharedData;

INTERFACE
CONST
  MaxWordLength = 50;
  MaxTreeDepth = 30000;
TYPE
  Word = STRING[MaxWordLength];
  Tree = ^NodeType;
  NodeType = RECORD
              Key: Word;
              Count: INTEGER;
              LLink, RLink: Tree
            END;
VAR
  TreeDepth: INTEGER;
  NotAddedTreeElementCount: INTEGER;
  Root: Tree;
       
IMPLEMENTATION


BEGIN
END.