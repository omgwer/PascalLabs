PROGRAM PrintSymbolChar(INPUT, OUTPUT);
CONST
  ElementLen = 5;
  ElementSetMax = 25;
  StrElementLen = 50;
  ElementStrMax = 250;
TYPE
  XSet = SET OF 1 .. ElementSetMax;
  XStringSet = SET OF 1 .. ElementStrMax;
  Chiper = ARRAY [CHAR] OF XSet;
  CharArr = ARRAY [1 .. 10] OF CHAR;
VAR
  CharArray: Chiper;  
  FInput, ReadFile: TEXT;
  SetOfChars: XSet;
  SetStringOfChars: XStringSet;
  Ch: CHAR;
  ElementOfSet, RowStrafe, ColumnStrafe, I, CharIndex: INTEGER;

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
// Процедура печатающая строку
PROCEDURE PrintSetString(LetterSet: XStringSet);
VAR
  Index: INTEGER;
BEGIN
  FOR Index := 1 TO ElementStrMax  
  DO
    BEGIN
      IF (Index IN LetterSet)
      THEN
        WRITE('X')
      ELSE
        WRITE(' ');
      IF Index MOD ElementLen = 0
      THEN
        WRITE(' ');
      IF Index MOD StrElementLen = 0
      THEN
        WRITELN;      
    END
END;
// Процедура записывающая множество 250
PROCEDURE GetSetString(VAR SetStringOfChars: XStringSet; VAR ReadFile: TEXT);
VAR 
  Index, CharIndex, Num: INTEGER;
  Ch: CHAR;
  CharSet: XSet;
BEGIN
  FOR Index:= 1 TO 10
  DO
    BEGIN
      IF EOF(ReadFile)
      THEN
        BREAK;
      IF EOLN(ReadFile)
      THEN
        READLN(ReadFile);        
      READ(ReadFile, Ch);
      CharSet := CharArray[Ch];
      FOR CharIndex := 1 TO ElementSetMax
      DO
        BEGIN
          IF (CharIndex IN CharSet)
          THEN
            BEGIN
              Num := ((CharIndex - 1) DIV ElementLen) * (StrElementLen - ElementLen) + ElementLen * (Index - 1) + CharIndex;
              SetStringOfChars := SetStringOfChars + [Num]
            END          
        END
    END 
END;

BEGIN
  Initialize();
  ASSIGN(ReadFile, 'Symbols.TXT');      
  RESET(ReadFile);
  WHILE NOT EOF(ReadFile)
  DO
    BEGIN   
      GetSetString(SetStringOfChars, ReadFile);
      PrintSetString(SetStringOfChars);
      SetStringOfChars := [];
      WRITELN;
  END  
END.
