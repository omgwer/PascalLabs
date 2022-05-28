UNIT StringHelper;

INTERFACE
USES
  SharedData;

FUNCTION GetWord(VAR Text: TEXT): Word;
FUNCTION ComparisonWord(FirstWord: Word; SecondWord: Word): Word;

IMPLEMENTATION

FUNCTION IsWordChar(InputChar: CHAR): BOOLEAN;
VAR
  AvailableChars: STRING;
BEGIN
  AvailableChars:= 'QWERTYUIOPASDFGHJKLZXCVBNM���������������������������������qwertyuiopasdfghjklzxcvbnm��㪥�������뢠�஫�����ᬨ���ee';
  IF (POS(InputChar, AvailableChars) <> 0)
  THEN
    IsWordChar:= TRUE
  ELSE
    IsWordChar:= FALSE
END;

FUNCTION ToLowerCase(InputChar: CHAR): CHAR;
VAR
  SH, SL: STRING;
BEGIN
  SH:= 'QWERTYUIOPASDFGHJKLZXCVBNM����������������������������������';
  SL:= 'qwertyuiopasdfghjklzxcvbnm��㪥�������뢠�஫�����ᬨ���ee';
  IF POS(InputChar, SH) <> 0
  THEN
    ToLowerCase := SL[POS(InputChar, SH)]
  ELSE
    ToLowerCase := InputChar;
END;

// �㭪�� �����頥� ���� ᫮�� � lowerCase
FUNCTION GetWord(VAR Text: TEXT): Word;
VAR
  Ch: CHAR;
  State: CHAR; // S - search, W - work, F - finish
BEGIN
  State := 'S';
  GetWord := '';

  WHILE (NOT EOF(Text)) AND (State <> 'F')
  DO
    BEGIN
      IF EOLN(Text)
      THEN
        IF (State = 'S')
        THEN
          READLN(Text)
        ELSE
          State := 'F';
      READ(Text, Ch);
      IF State = 'S'
      THEN      
        IF (IsWordChar(Ch)) 
        THEN          
          State := 'W';          
      IF State = 'W'
      THEN
        BEGIN          
          IF (IsWordChar(Ch))
          THEN
            GetWord := GetWord + ToLowerCase(Ch)
          ELSE IF (Ch = '-') // ��ࠡ�⪠ ᨬ���� ��᫥ ����
          THEN
            BEGIN
              IF (NOT EOLN(Text))
              THEN
                READ(Text, Ch);
                IF (IsWordChar(Ch))
                THEN
                  GetWord := GetWord + '-' + ToLowerCase(Ch)
                ELSE
                  State := 'F'  
            END
          ELSE
            State := 'F'
        END            
    END
END;

// �㭪�� �����頥� ������� �� ���������� ��ப
FUNCTION ComparisonWord(FirstWord: Word; SecondWord: Word): Word;
BEGIN
  IF (FirstWord > SecondWord)
  THEN
    ComparisonWord := FirstWord
  ELSE
    ComparisonWord := SecondWord
END;




BEGIN
END.