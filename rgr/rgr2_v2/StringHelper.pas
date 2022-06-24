UNIT StringHelper;

INTERFACE
USES
  SharedData;

FUNCTION GetWord(VAR Text: TEXT): ValidWord;

IMPLEMENTATION

FUNCTION IsWordChar(InputChar: CHAR): BOOLEAN;
VAR
  AvailableChars: STRING;
BEGIN
  AvailableChars:= 'QWERTYUIOPASDFGHJKLZXCVBNMЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮЁёqwertyuiopasdfghjklzxcvbnmйцукенгшщзхъфывапролджэячсмитьбюee';
  IsWordChar := POS(InputChar, AvailableChars) <> 0
END;

FUNCTION ToLowerCase(InputChar: CHAR): CHAR;
VAR
  SH, SL: STRING;
  Position: INTEGER;
BEGIN
  SH:= 'QWERTYUIOPASDFGHJKLZXCVBNMЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮЁё';
  SL:= 'qwertyuiopasdfghjklzxcvbnmйцукенгшщзхъфывапролджэячсмитьбюее';
  Position := POS(InputChar, SH);
  IF Position <> 0
  THEN
    ToLowerCase := SL[Position]
  ELSE
    ToLowerCase := InputChar
END;

// Функция возвращает одно слово в lowerCase
FUNCTION GetWord(VAR Text: TEXT): ValidWord;
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
          State := 'W'
        ELSE IF (Ch = '-') // для кейса "1998-ом" году. если встретили дефис игнорируем все "буквы" до не буквы.
        THEN      
          WHILE NOT EOLN(Text)
          DO
            BEGIN
              READ(Text, Ch);
              IF (NOT IsWordChar(Ch))
              THEN
                BREAK
            END;                                
      IF State = 'W'
      THEN
        BEGIN          
          IF (IsWordChar(Ch))
          THEN
            GetWord := GetWord + ToLowerCase(Ch)
          ELSE IF (Ch = '-') // обработка символа после дефиса
          THEN
            BEGIN
              IF (NOT EOLN(Text))
              THEN
                BEGIN
                  READ(Text, Ch);
                  IF (IsWordChar(Ch))
                  THEN
                    GetWord := GetWord + '-' + ToLowerCase(Ch)
                  ELSE
                    State := 'F'
                END      
              ELSE IF (EOLN(Text)) AND NOT (EOF(Text))
              THEN
                BEGIN
                  READLN(Text);
                  READ(Text, Ch);
                  IF (IsWordChar(Ch))
                  THEN
                    GetWord := GetWord + '-' + ToLowerCase(Ch)
                  ELSE
                    State := 'F'
                END      
            END
          ELSE
            State := 'F'
        END            
    END
END;

// BEGIN
 END.