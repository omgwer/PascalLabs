UNIT SharedData;

INTERFACE
CONST
  MaxWordLength = 50;
  MaxTreeDepth = 15000;
TYPE
  ValidWord = STRING[MaxWordLength];
  Tree = ^NodeType;
  List = ^ListType; // Список для каждой ноды дерева, хранит в себе множество значений с одинаковой основой слова
  ListType = RECORD 
              Word: ValidWord;
              Count: INTEGER;              
              Next: List;                
            END;     
  NodeType = RECORD
              Key: ValidWord; // основа слова
              WordList: List;  // указатель на лист со словами с одинаковой основой
              LLink, RLink: Tree
            END;  
IMPLEMENTATION

BEGIN
END.