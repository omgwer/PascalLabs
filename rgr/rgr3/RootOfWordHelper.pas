UNIT RootOfWordHelper;

INTERFACE
USES
  SharedData;

FUNCTION GetRootOfWord(NewWord: ValidWord): ValidWord;

IMPLEMENTATION
TYPE
  PerfGerundGroupType = ARRAY [0..2] OF STRING;
  ReflexiveType = ARRAY [0..1] OF STRING;
  AdjectiveType = ARRAY [0..25] OF STRING;
  ParticipleGroupFirstType = ARRAY [0..4] OF STRING;
  ParticipleGroupSecondType = ARRAY [0..2] OF STRING;
  VerbGroupFirstType = ARRAY [0..16] OF STRING;
  VerbGroupSecondType = ARRAY [0..28] OF STRING;
  NounType = ARRAY [0..35] OF STRING;
  SuperlativeType = ARRAY [0..1] OF STRING;
  DerivationalType = ARRAY [0..1] OF STRING;
VAR
  RV, R1, R2, R0: ValidWord;
  VowelLatter: STRING;
  PerfGerundGroup : PerfGerundGroupType;
  Reflexive : ReflexiveType;
  Adjective : AdjectiveType;
  ParticipleGroupFirst : ParticipleGroupFirstType;
  ParticipleGroupSecond : ParticipleGroupSecondType;
  VerbGroupFirst : VerbGroupFirstType;
  VerbGroupSecond : VerbGroupSecondType;
  Noun : NounType;
  Superlative : SuperlativeType;
  Derivational : DerivationalType;

PROCEDURE InitData(Word: ValidWord);
VAR
  WordLength, i: INTEGER;
  State : STRING; // RV, R1, R2, F - finish
BEGIN
  R0 := '';
  RV := '';
  R1 := '';
  R2 := '';
  State := 'RV';
  WordLength := LENGTH(Word);

  FOR i := 0 TO WordLength
  DO
    BEGIN
      IF (POS(Word[i], VowelLatter) <> 0) OR (State <> 'RV') AND (State <> 'F')
      THEN
        BEGIN
          IF State = 'RV'
          THEN
            BEGIN
              R0 := Copy(Word,0, i - 1);        
              RV := Copy(Word, i + 1, WordLength); 
              State := 'R1'
            END;
          IF State = 'R1'
          THEN
            BEGIN
              IF (i < WordLength)
              THEN
                BEGIN
                  IF (POS(Word[i], VowelLatter) <> 0) AND (POS(Word[i + 1], VowelLatter) = 0) AND (i+1 < WordLength)
                  THEN
                    BEGIN
                      R1 := Copy(Word, i+ 2, WordLength);
                      State := 'R2'
                    END
                END
            END            
          ELSE IF State = 'R2'
          THEN
            BEGIN
              IF (i < WordLength)
              THEN
                BEGIN
                  IF (POS(Word[i], VowelLatter) <> 0) AND (POS(Word[i + 1], VowelLatter) = 0) AND (i+1 < WordLength)
                  THEN
                    BEGIN
                      R2 := Copy(Word, i+ 2, WordLength);
                      State := 'F'
                    END
                END                
            END  
        END
    END;

    WRITELN(OUTPUT,'R0 = ', R0, ' RV = ', RV, ' R1 = ', R1, ' R2 = ', R2);
END;

PROCEDURE DeleteReflexive(VAR RV: ValidWord);
VAR
  TmpFile : ValidWord;
  WordLength: INTEGER; 
BEGIN
  WordLength := LENGTH(RV);
  TmpFile := Copy(RV, WordLength - 1, WordLength);  // �஡㥬 㤠���� REFLEXIVE 
  IF (TmpFile =  Reflexive[0]) OR (TmpFile = Reflexive[1])
  THEN
    RV := Copy(RV, 0, WordLength - 2);
END;

PROCEDURE DeleteAdjectival(VAR RV: ValidWord);
BEGIN
END;

// ���� 蠣 - ���� perfective gerund
PROCEDURE DeletePerfectiveGerund(VAR RV: ValidWord);
VAR  
  State : STRING; // S - �饬 perfectiveGerund R - �᫨ �� ��諨, 㤠�塞 Reflexive, F - finish
  TmpFile: ValidWord;
  i, j, WordLength: INTEGER;  
BEGIN
  State := 'S';
  WordLength := LENGTH(RV);
  FOR i:= WordLength DOWNTO 0
  DO
    BEGIN
      TmpFile := Copy(RV, i, WordLength); // �����뢠�� ����砭��
      IF State = 'F'
      THEN
        BREAK;
      FOR j := 0 TO 2
      DO
        BEGIN
          IF TmpFile = PerfGerundGroup[j]
          THEN
            IF (RV[i - 1] = '�') OR (RV[i - 1] = '�')
            THEN
              BEGIN
                RV := Copy(RV, 0, i - 2);
                State := 'F';
                BREAK;
              END
            ELSE IF (RV[i - 1] = 'a') OR (RV[i - 1] = '�')
            THEN
              BEGIN
                RV := Copy(RV, 0, i);
                State := 'F';
                BREAK;
              END 
        END
    END;
    IF State = 'S'  
    THEN
      BEGIN
        DeleteReflexive(RV);        
        DeleteAdjectival(); //
        DeleteParticiple(); //
      END

END;

FUNCTION GetRootOfWord(NewWord: ValidWord): ValidWord;
VAR
  TmpWord: ValidWord;
BEGIN
  InitData(NewWord);
  DeletePerfectiveGerund(RV);
  WRITELN(OUTPUT, RV);

  GetRootOfWord := NewWord;
END;


PROCEDURE InitStaticData();
BEGIN
  VowelLatter := '���������'; // ����� �㪢�  
  PerfGerundGroup[0] := '�';
  PerfGerundGroup[1] := '��';
  PerfGerundGroup[2] := '����';
  Reflexive[0] := '��';
  Reflexive[1] := '��';  
  Adjective[0] := '��';
  Adjective[1] := '��';
  Adjective[2] := '�';
  Adjective[3] := '��';
  Adjective[4] := '���';
  Adjective[5] := '묨';
  Adjective[6] := '��';
  Adjective[7] := '��';
  Adjective[8] := '�';
  Adjective[9] := '��';
  Adjective[10] := '��';
  Adjective[11] := '��';
  Adjective[12] := '�';
  Adjective[13] := '��';
  Adjective[14] := '���';
  Adjective[15] := '���';
  Adjective[16] := '���';
  Adjective[17] := '���';
  Adjective[18] := '��';
  Adjective[19] := '��';
  Adjective[20] := '��';
  Adjective[21] := '��';
  Adjective[22] := '��';
  Adjective[23] := '��';
  Adjective[24] := '��';
  Adjective[25] := '��';
  ParticipleGroupFirst[0] := '��';
  ParticipleGroupFirst[1] := '��';
  ParticipleGroupFirst[2] := '��';
  ParticipleGroupFirst[3] := '��';
  ParticipleGroupFirst[4] := '�';
  ParticipleGroupSecond[0] := '���';
  ParticipleGroupSecond[1] := '��';
  ParticipleGroupSecond[2] := '���';
  VerbGroupFirst[0] := '��';
  VerbGroupFirst[1] := '��';
  VerbGroupFirst[2] := '��';
  VerbGroupFirst[3] := '��';
  VerbGroupFirst[4] := '��';
  VerbGroupFirst[5] := '�';
  VerbGroupFirst[6] := '�';
  VerbGroupFirst[7] := '��';
  VerbGroupFirst[8] := '�';
  VerbGroupFirst[9] := '��';
  VerbGroupFirst[10] := '��';
  VerbGroupFirst[11] := '��';
  VerbGroupFirst[12] := '��';
  VerbGroupFirst[13] := '��';
  VerbGroupFirst[14] := '��';
  VerbGroupFirst[15] := '���';
  VerbGroupFirst[16] := '���';
  VerbGroupSecond[0] := '���';
  VerbGroupSecond[1] := '뫠';
  VerbGroupSecond[2] := '���';
  VerbGroupSecond[3] := '���';
  VerbGroupSecond[4] := '��';
  VerbGroupSecond[5] := '��';
  VerbGroupSecond[6] := '���';
  VerbGroupSecond[7] := '뫨';
  VerbGroupSecond[8] := '��';
  VerbGroupSecond[9] := '�';
  VerbGroupSecond[10] := '��';
  VerbGroupSecond[11] := '�';
  VerbGroupSecond[12] := '��';
  VerbGroupSecond[13] := '�';
  VerbGroupSecond[14] := '��';
  VerbGroupSecond[15] := '���';
  VerbGroupSecond[16] := '뫮';
  VerbGroupSecond[17] := '���';
  VerbGroupSecond[18] := '��';
  VerbGroupSecond[19] := '��';
  VerbGroupSecond[20] := '���';
  VerbGroupSecond[21] := '��';
  VerbGroupSecond[22] := '��';
  VerbGroupSecond[23] := '���';
  VerbGroupSecond[24] := '���';
  VerbGroupSecond[25] := '���';
  VerbGroupSecond[26] := '���';
  VerbGroupSecond[27] := '��';
  VerbGroupSecond[28] := '�';
  Noun[0] := '�';
  Noun[1] := '��';
  Noun[2] := '��';
  Noun[3] := '��';
  Noun[4] := '�';
  Noun[5] := '�';
  Noun[6] := '�ﬨ';
  Noun[7] := 'ﬨ';
  Noun[8] := '���';
  Noun[9] := '��';
  Noun[10] := '��';
  Noun[11] := '�';
  Noun[12] := '���';
  Noun[13] := '��';
  Noun[14] := '��';
  Noun[15] := '��';
  Noun[16] := '�';
  Noun[17] := '��';
  Noun[18] := '�';
  Noun[19] := '���';
  Noun[20] := '��';
  Noun[21] := '��';
  Noun[22] := '��';
  Noun[23] := '�';
  Noun[24] := '�';
  Noun[25] := '��';
  Noun[26] := '���';
  Noun[27] := '��';
  Noun[28] := '�';
  Noun[29] := '�';
  Noun[30] := '��';
  Noun[31] := '��';
  Noun[32] := '�';
  Noun[33] := '��';
  Noun[34] := '��';
  Noun[35] := '�';
  Superlative[0] := '���';
  Superlative[1] := '���';
  Derivational[0] := '���';
  Derivational[1] := '����';
END;

BEGIN  
  InitStaticData();
END.