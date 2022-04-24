UNIT SymbolConverter;

INTERFACE
CONST
  Len = 5;

TYPE
  XSet = SET OF 1 .. Len * Len;

  PROCEDURE PrintLetterSet(LetterSet: Xset);
  FUNCTION Letter2Set(Ch: CHAR): Xset;
  
IMPLEMENTATION
CONST
  ASet: XSet = [3,7,9,12,14,16,17,18,19,20,21,25];
  BSet: XSet = [1,2,3,4,5,6,10,11,12,13,14,15,16,20,21,22,23,24,25];
  CSet: XSet = [1,2,3,4,5,6,11,16,21,22,23,24,25];
  DSet: XSet = [1,2,3,4,6,10,11,15,16,20,21,22,23,24];
  ESet: XSet = [1,2,3,4,5,6,11,12,13,14,15,16,21,22,23,24,25];
  NoLetter: XSet = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25];

PROCEDURE ArrayInit()


PROCEDURE PrintLetterSet(LetterSet: XSet);
VAR
  Index: INTEGER;
BEGIN
  FOR Index := 1 TO Len * Len
  DO
    BEGIN
      IF (Index IN LetterSet)
      THEN
        WRITE('X')
      ELSE
        WRITE(' ');
      IF Index MOD 5 = 0
      THEN
        WRITELN  
    END;
END;

FUNCTION Letter2Set(Ch: CHAR): XSet;
BEGIN
  CASE Ch OF
    'A': Letter2Set := ASet;
    'B': Letter2Set := BSet;
    'C': Letter2Set := CSet;
    'D': Letter2Set := DSet;
    'E': Letter2Set := ESet
    ELSE
      Letter2Set := NoLetter
  END     
END;  

BEGIN
END.