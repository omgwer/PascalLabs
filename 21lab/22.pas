PROGRAM Encryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper 
  и печатает новые символы в OUTPUT}
CONST
  Len = 20;
TYPE
  Str = ARRAY [1 .. Len] OF 'A' .. 'Z';
  CodeStr = ARRAY [1 .. 2] OF CHAR;
  Chiper = ARRAY ['A' .. 'Z'] OF CHAR;
  Arr = 0 .. Len;
VAR
  Msg: Str;
  CodeString: STRING;
  Code: Chiper;
  I, StringLength: Arr;
  FInput: TEXT;
  Ch, Ch1, SpaceChar: CHAR;

PROCEDURE Initialize(VAR Code: Chiper; VAR SpaceChar : CHAR);
{Присвоить Code шифр замены}
BEGIN {Initialize}
  ASSIGN(FInput, 'FI.TXT');
  RESET(FInput);
  WHILE NOT EOF(FInput)
  DO
    BEGIN
      READ(FInput, Ch);
      READ(FInput, Ch1);
      IF Ch = ' '
      THEN
        SpaceChar := Ch1
      ELSE
        Code[Ch] := Ch1;
      READLN(FInput)
    END;
END;  {Initialize}

PROCEDURE Encode(VAR S: Str; StringLength : Arr; SpaceChar : CHAR);
{Выводит символы из Code, соответствующие символам из S}
VAR
  Index: 1 .. StringLength;
BEGIN {Encode}
  FOR Index := 1 TO StringLength
  DO
    IF S[Index] IN ['A' .. 'Z']
    THEN
      WRITE(Code[S[Index]])
    ELSE IF S[Index] = ' '
    THEN
      WRITE(SpaceChar)
    ELSE  
      WRITE(S[Index]);
  WRITELN
END;  {Encode}

BEGIN {Encryption}
  {Инициализировать Code}
  StringLength := 0;    
  Initialize(Code, SpaceChar);
  WHILE NOT EOF
  DO
    BEGIN      
      {читать строку в Msg и распечатать ее}
      I := 0;
      WHILE NOT EOLN AND (I < Len)
      DO
        BEGIN
          I := I + 1;
          READ(Msg[I]);
          WRITE(Msg[I]);
          StringLength := StringLength + 1;
        END;
      READLN;
      WRITELN;      
      Encode(Msg, StringLength, SpaceChar);
      StringLength := 0
    END
END.  {Encryption}
