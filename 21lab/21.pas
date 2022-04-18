PROGRAM Encryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper 
  и печатает новые символы в OUTPUT}
CONST
  Len = 20;
TYPE
  Str = ARRAY [1 .. Len] OF 'A' .. 'Z';
  Chiper = ARRAY ['A' .. 'Z'] OF CHAR;
  Arr = 0 .. Len;
VAR
  Msg: Str;
  Code: Chiper;
  I, StringLength: Arr;

PROCEDURE Initialize(VAR Code: Chiper);
{Присвоить Code шифр замены}
BEGIN {Initialize}
  Code['A'] := 'Z';
  Code['B'] := 'Y';
  Code['C'] := 'X';
  Code['D'] := '#';
  Code['E'] := 'V';
  Code['F'] := 'U';
  Code['G'] := 'T';
  Code['H'] := 'S';
  Code['I'] := 'I';
  Code['J'] := 'Q';
  Code['K'] := 'P';
  Code['L'] := '!';
  Code['M'] := 'N';
  Code['N'] := 'M';
  Code['O'] := '2';
  Code['P'] := 'K';
  Code['Q'] := '$';
  Code['R'] := 'D';
  Code['S'] := 'H';
  Code['T'] := '*';
  Code['U'] := 'F';
  Code['V'] := 'E';
  Code['W'] := 'T';
  Code['X'] := 'C';
  Code['Y'] := 'B';
  Code['Z'] := 'A';  
END;  {Initialize}

PROCEDURE Encode(VAR S: Str; StringLength : Arr);
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
      WRITE('>')
    ELSE  
      WRITE(S[Index]);
  WRITELN
END;  {Encode}

BEGIN {Encryption}
  {Инициализировать Code}
  ASSIGN(FInput, 'FI.TXT');
  StringLength := 0;
  Initialize(Code);
  WHILE NOT EOF
  DO
    BEGIN
      READ(FInput, Msg);
      READLN(FInput);
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
      Encode(Msg, StringLength);
      StringLength := 0
    END
END.  {Encryption}
