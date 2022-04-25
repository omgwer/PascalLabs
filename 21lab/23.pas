PROGRAM Encryption(INPUT, OUTPUT);
{ ��������� ������� �� INPUT � ��� �������� Chiper 
  � �������� ����� ������� � OUTPUT }
CONST
  Len = 20;
TYPE
  Str = ARRAY [1 .. Len] OF 'A' .. 'Z';
  Chiper = ARRAY ['A' .. 'Z'] OF CHAR;
  LineControl = 0 .. Len;
VAR
  Msg: Str;
  Code: Chiper;
  I: LineControl;
  F: TEXT;
  CodeIndex, CodeValue, SpaceValue: CHAR;

PROCEDURE Initialize(VAR Code: Chiper; VAR SpaceValue: CHAR);
{ ��������� Code ���� ������ }
BEGIN { Initialize }
  ASSIGN(F, 'FI.TXT');
  RESET(F);
  WHILE NOT EOF(F)
  DO
    BEGIN
      IF NOT EOLN
      THEN
        READ(F, CodeIndex);
      IF NOT EOLN
      THEN
        READ(F, CodeValue);
      IF NOT EOF
      THEN
        READLN(F);
      IF CodeIndex = ' '
      THEN
        SpaceValue := CodeValue
      ELSE
        Code[CodeIndex] := CodeValue
    END
END; { Initialize }

PROCEDURE Encode(VAR S: Str; VAR LineBreak: LineControl; VAR SpaceValue: CHAR);
{ ������� ������� �� Code, ��������������� �������� �� S }
VAR
  Index: LineControl;
BEGIN { Encode }
  FOR Index := 1 TO LineBreak
  DO
    IF S[Index] IN ['A' .. 'Z']
    THEN
      WRITE(Code[S[Index]])
    ELSE
      IF S[Index] = ' '
      THEN
        WRITE(SpaceValue)
      ELSE
        WRITE(S[Index]);
  WRITELN
END; { Encode }

PROCEDURE Decode(VAR S: Str; VAR LineBreak: LineControl; VAR SpaceValue: CHAR);
{ ������� ������� �� Code, ��������������� �������� �� S }
VAR
  Index: LineControl;
  CodeId: 'A' .. 'Z';
  Value: 'A' .. 'Z';
  Check: BOOLEAN;
BEGIN { Decode }
  FOR Index := 1 TO LineBreak
  DO
    BEGIN
      Check := FALSE;
      IF S[Index] = SpaceValue
      THEN
        BEGIN
          WRITE(' ');
          Check := TRUE
        END;
     
      FOR CodeId := 'A' TO 'Z'
      DO
        IF S[Index] = Code[CodeId]
        THEN
          BEGIN
            WRITE(CodeId);
            Check := TRUE
          END;

      IF NOT Check
      THEN
        WRITE(S[Index])
    END;  
  WRITELN
END; { Decode }

BEGIN { Encryption }
  { ���������������� Code }
  Initialize(Code, SpaceValue);  
  WHILE NOT EOF
  DO
    BEGIN
      { ������ ������ � Msg � ����������� �� }
      I := 0;
      WHILE NOT EOLN AND (I < Len)
      DO
        BEGIN
          I := I + 1;
          READ(Msg[I])
        END;
      READLN;
      { ����������� ������������ ��������� }
      Decode(Msg, I, SpaceValue)
    END              
END.  { Encryption }
                   
