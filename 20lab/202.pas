PROGRAM PrintSymbolChar(INPUT, OUTPUT);

TYPE
  XSet = SET OF 1 .. 25;
  Chiper = ARRAY [CHAR] OF XSet;
  CharArr = ARRAY [1 .. 10] OF CHAR;
VAR
  CharArray: Chiper;
  OneStringArray: CharArr;
  FInput, ReadFile: TEXT;
  SetOfChars: XSet;
  Ch: CHAR;
  ElementOfSet, RowStrafe, ColumnStrafe, I: INTEGER;

PROCEDURE Initialize(); //Инициализация массива
BEGIN {Initialize}
  ASSIGN(FInput, 'XLetters.TXT');
  RESET(FInput);  
  WHILE NOT EOF(FInput)
  DO
    BEGIN
      READ(FInput, Ch);
      WHILE NOT EOLN(FInput)  
      DO
        BEGIN
          READ(FInput, ElementOfSet);
          SetOfChars := SetOfChars + [ElementOfSet]
        END; 
      CharArray[Ch] := SetOfChars;
      SetOfChars := [];
      READLN(FInput)
    END;
END;  {Initialize}
// Процедура печатающая букву
PROCEDURE PrintLetterSet(LetterSet: XSet);
VAR
  Index: INTEGER;
BEGIN
  FOR Index := 1 TO 25
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
    END
END; 
// Процедура записывающая массив из 10 символов.
PROCEDURE GetStringArray(VAR OneStringArray: CharArr; VAR ReadFile: TEXT);
VAR
  Cha: CHAR;
BEGIN
  FOR I:= 1 TO 10 
  DO
    BEGIN
      IF EOF(ReadFile)
      THEN
        BREAK;
      IF EOLN(ReadFile)
      THEN
        READLN(ReadFile);        
      READ(ReadFile,  OneStringArray[I]);  
    END;  
END;

PROCEDURE PrintString(VAR OneStringArray: CharArr);
BEGIN

END;

BEGIN
  Initialize();
  ASSIGN(ReadFile, 'Symbols.TXT');
  ColumnStrafe := 1;
  RowStrafe := 1;
  RESET(ReadFile);  
  GetStringArray(OneStringArray, ReadFile);
  


END.
