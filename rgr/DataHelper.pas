UNIT DataHelper;

INTERFACE
USES
  SharedData;


PROCEDURE Insert(InputWord: Word);
IMPLEMENTATION
TYPE
  ElementPtr = ^Element;
  Element = RECORD
              Next: ElementPtr;
              Key: Word;
              Count: INTEGER
            END;  

PROCEDURE Insert(InputWord: Word);
VAR
  t: Word;
BEGIN
 
END;


BEGIN
END.