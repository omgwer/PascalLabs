UNIT RootOfWordHelper;

INTERFACE
USES
  SharedData;

FUNCTION GetRootOfWord(NewWord: ValidWord): ValidWord;

IMPLEMENTATION

FUNCTION GetRootOfWord(NewWord: ValidWord): ValidWord;
VAR
  TmpWord: ValidWord;
BEGIN
  GetRootOfWord := NewWord;
END;

BEGIN
END.