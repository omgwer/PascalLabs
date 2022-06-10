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
              R0 := Copy(Word,0, i );        
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

PROCEDURE DeleteNoun(VAR RV: ValidWord);
VAR
  TmpFile : ValidWord;
  WordLength, i, j: INTEGER;
BEGIN
  WordLength := LENGTH(RV);
  FOR i := 4 DOWNTO 1
  DO
    BEGIN
      IF WordLength < i
      THEN
        Continue;
      TmpFile := COPY(RV, WordLength - i + 1, WordLength);  
      FOR j := 0 TO LENGTH(Noun)
      DO
        BEGIN
          IF TmpFile = Noun[j]
          THEN
            RV := COPY(RV, 0, WordLEngth - i);
            TmpFile := 'F';
            BREAK;
        END;
      IF TmpFile = 'F'
      THEN
        BREAK;
    END;
END;

PROCEDURE DeleteVerb(VAR RV: ValidWord; VAR State: STRING);
VAR
  TmpFile : ValidWord;
  WordLength, i, j: INTEGER;
BEGIN
  WordLength := LENGTH(RV);
  FOR i := 3 DOWNTO 0
  DO
    BEGIN
      TmpFile := COPY(RV, WordLength - i, WordLength); // последовательно сравниваем окончания, нужно найти самое длинное подходящее
      //IF Length(TmpFile < i)  может быть кейс что длины rv НЕ ХВАТИТ
      FOR j := 0 TO LENGTH(VerbGroupSecond)
      DO
        BEGIN
          IF TmpFile = VerbGroupSecond[j]
          THEN
            BEGIN
              State := 'F';
              RV := COPY(RV, 0, WordLength - i - 1);
              BREAK
            END;            
        END;
      IF State = 'F'
      THEN
        BREAK;
      FOR j := 0 TO LENGTH(VerbGroupFirst)
      DO
        BEGIN
          IF TmpFile = VerbGroupFirst[j]
          THEN
            BEGIN
              IF Length(RV) > i
              THEN
                BEGIN
                  TmpFile := RV[WordLength - i]; // записываем букву которая предшествует werbGroup 1
                  IF (TmpFile = 'я') OR (TmpFile = 'я')  // буква предшествующая окончанию, удовлетворяет условию
                  THEN
                    BEGIN
                      State := 'F';
                      RV := COPY(RV, 0, WordLength - i - 1);
                      BREAK
                    END;
                END
              ELSE
                BEGIN
                  TmpFile := R0[Length(R0)];
                  IF (TmpFile = 'а') OR (TmpFile = 'я')
                  THEN
                    BEGIN
                      State := 'F';
                      RV := COPY(RV, 0, WordLength - i - 1);
                      BREAK
                    END;
                END;
            END;         
        END; 
    END;
END;

PROCEDURE DeleteReflexive(VAR RV: ValidWord);
VAR
  TmpFile : ValidWord;
  WordLength: INTEGER; 
BEGIN
  WordLength := LENGTH(RV);
  TmpFile := Copy(RV, WordLength - 1, WordLength);  // пробуем удалить REFLEXIVE 
  IF (TmpFile =  Reflexive[0]) OR (TmpFile = Reflexive[1])
  THEN
    RV := Copy(RV, 0, WordLength - 2);
END;

PROCEDURE DeleteParticiple(VAR RV: ValidWord);
VAR
  TmpFile : ValidWord;
  WordLength, TmpInt, i: INTEGER;
  State : STRING;
BEGIN
  State := 'W';
  WordLength := LENGTH(RV);
  TmpFile := COPY(RV, WordLength - 2, WordLength); // берем 3 элемента с конца
  IF LENGTH(RV) >= 3
  THEN
    BEGIN
      FOR i := 0 TO LENGTH(ParticipleGroupSecond)
      DO
        BEGIN
          IF TmpFile = ParticipleGroupSecond[i]
          THEN
            BEGIN
              RV := COPY(RV, 0, WordLength - 3);
              State := 'F';
              BREAK;
            END
        END
    END;
  IF State <> 'F'
  THEN
    BEGIN
      TmpFile := COPY(RV, WordLength - 1, WordLength); // берем 2 элемента с конца       
      IF LENGTH(RV) >= 2
      THEN
        BEGIN
          FOR i := 0 TO LENGTH(ParticipleGroupFirst)
          DO
            BEGIN
              IF TmpFile =  ParticipleGroupFirst[i]
              THEN
                BEGIN
                  IF LENGTH(RV) = 2
                  THEN
                    BEGIN                
                      TmpInt := LENGTH(R0);
                      WRITELN(OUTPUT, 'TestTMP = ', TmpFile);
                      IF (R0[TmpInt] = 'а') OR (R0[TmpInt] = 'я')
                      THEN
                        BEGIN 
                          RV := COPY(RV, 0, WordLength - 2)
                        END;
                    END
                  ELSE                
                    BEGIN
                      IF (RV[WordLength - 2] = 'а') OR (RV[WordLength - 2] = 'я')
                      THEN
                        BEGIN 
                          RV := COPY(RV, 0, WordLength - 2)
                        END;
                    END;
                END;
            END;
        END;  
    END;
END;

PROCEDURE DeleteAdjective(VAR RV: ValidWord; VAR State: STRING);
VAR
  TmpFile : ValidWord;
  WordLength, i: INTEGER;
BEGIN
  WordLength := LENGTH(RV);
  TmpFile := Copy(RV, WordLength - 2, WordLength); // берем 3 элемента с конца
  IF LENGTH(TmpFile) >= 3
  THEN
    BEGIN
      FOR i := 0 TO LENGTH(Adjective)
      DO
        BEGIN
          IF TmpFile = Adjective[i]
          THEN
            BEGIN
              RV := Copy(RV, 0, WordLength - 3);
              State := 'F';
              BREAK
            END
        END;
    END;
    TmpFile := Copy(RV, WordLength - 1, WordLength); // берем 2 элемента с конца
    IF LENGTH(TmpFile) >= 2
    THEN
      BEGIN
      FOR i := 0 TO LENGTH(Adjective)
      DO
        BEGIN
          IF TmpFile = Adjective[i]
          THEN
            BEGIN
              RV := Copy(RV, 0 , WordLength - 2);
              State := 'F';
              BREAK
            END
        END;
      END;
    DeleteParticiple(RV);   
END;


// Первый шаг - найти perfective gerund
PROCEDURE DeletePerfectiveGerund(VAR RV: ValidWord);
VAR  
  State : STRING; // S - search  F - finish
  TmpFile: ValidWord;
  i, j, WordLength: INTEGER;  
BEGIN
  State := 'S';
  WordLength := LENGTH(RV);
  FOR i:= 0 TO 25
  DO
    BEGIN
      TmpFile := Copy(RV, i, WordLength); // записываем окончание
      IF State = 'F'
      THEN
        BREAK;
      FOR j := 0 TO 2
      DO
        BEGIN
          IF TmpFile = PerfGerundGroup[j]
          THEN
            IF (RV[i - 1] = 'и') OR (RV[i - 1] = 'ы')
            THEN
              BEGIN
                RV := Copy(RV, 0, i - 2);
                State := 'F';
                BREAK;
              END
            ELSE IF (RV[i - 1] = 'a') OR (RV[i - 1] = 'я')
            THEN
              BEGIN
                RV := Copy(RV, 0, i);
                State := 'F';
                BREAK;
              END 
        END
    END;
    IF State <> 'F'  
    THEN
      BEGIN
        DeleteReflexive(RV);
        DeleteAdjective(RV, State);
        IF State <> 'F'
        THEN
          DeleteVerb(RV, State);
        // IF State <> 'F'
        // THEN
        //   DeleteNoun(RV);  

        
        
      END

END;

FUNCTION GetRootOfWord(NewWord: ValidWord): ValidWord;
VAR
  TmpWord: ValidWord;
BEGIN
  InitData(NewWord);
  DeletePerfectiveGerund(RV);
  WRITELN(OUTPUT,'RV after delete = ', RV);

  GetRootOfWord := NewWord;
END;


PROCEDURE InitStaticData();
BEGIN
  VowelLatter := 'аеиоуыэюя'; // Гласные буквы  
  PerfGerundGroup[0] := 'в';
  PerfGerundGroup[1] := 'вши';
  PerfGerundGroup[2] := 'вшись';
  Reflexive[0] := 'ся';
  Reflexive[1] := 'сь';  
  Adjective[0] := 'ее';
  Adjective[1] := 'ие';
  Adjective[2] := 'ые';
  Adjective[3] := 'ое';
  Adjective[4] := 'ими';
  Adjective[5] := 'ыми';
  Adjective[6] := 'ей';
  Adjective[7] := 'ий';
  Adjective[8] := 'ый';
  Adjective[9] := 'ой';
  Adjective[10] := 'ем';
  Adjective[11] := 'им';
  Adjective[12] := 'ым';
  Adjective[13] := 'ом';
  Adjective[14] := 'его';
  Adjective[15] := 'ого';
  Adjective[16] := 'ему';
  Adjective[17] := 'ому';
  Adjective[18] := 'их';
  Adjective[19] := 'ых';
  Adjective[20] := 'ую';
  Adjective[21] := 'юю';
  Adjective[22] := 'ая';
  Adjective[23] := 'яя';
  Adjective[24] := 'ою';
  Adjective[25] := 'ею';
  ParticipleGroupFirst[0] := 'ем';
  ParticipleGroupFirst[1] := 'нн';
  ParticipleGroupFirst[2] := 'вш';
  ParticipleGroupFirst[3] := 'ющ';
  ParticipleGroupFirst[4] := 'щ';
  ParticipleGroupSecond[0] := 'ивш';
  ParticipleGroupSecond[1] := 'ывш';
  ParticipleGroupSecond[2] := 'ующ';
  VerbGroupFirst[0] := 'ла';
  VerbGroupFirst[1] := 'на';
  VerbGroupFirst[2] := 'ете';
  VerbGroupFirst[3] := 'йте';
  VerbGroupFirst[4] := 'ли';
  VerbGroupFirst[5] := 'й';
  VerbGroupFirst[6] := 'л';
  VerbGroupFirst[7] := 'ем';
  VerbGroupFirst[8] := 'н';
  VerbGroupFirst[9] := 'ло';
  VerbGroupFirst[10] := 'но';
  VerbGroupFirst[11] := 'ет';
  VerbGroupFirst[12] := 'ют';
  VerbGroupFirst[13] := 'ны';
  VerbGroupFirst[14] := 'ть';
  VerbGroupFirst[15] := 'ешь';
  VerbGroupFirst[16] := 'нно';
  VerbGroupSecond[0] := 'ила';
  VerbGroupSecond[1] := 'ыла';
  VerbGroupSecond[2] := 'ена';
  VerbGroupSecond[3] := 'ейте';
  VerbGroupSecond[4] := 'уйте';
  VerbGroupSecond[5] := 'ите';
  VerbGroupSecond[6] := 'или';
  VerbGroupSecond[7] := 'ыли';
  VerbGroupSecond[8] := 'ей';
  VerbGroupSecond[9] := 'уй';
  VerbGroupSecond[10] := 'ил';
  VerbGroupSecond[11] := 'ыл';
  VerbGroupSecond[12] := 'им';
  VerbGroupSecond[13] := 'ым';
  VerbGroupSecond[14] := 'ен';
  VerbGroupSecond[15] := 'ило';
  VerbGroupSecond[16] := 'ыло';
  VerbGroupSecond[17] := 'ено';
  VerbGroupSecond[18] := 'ят';
  VerbGroupSecond[19] := 'ует';
  VerbGroupSecond[20] := 'уют';
  VerbGroupSecond[21] := 'ит';
  VerbGroupSecond[22] := 'ыт';
  VerbGroupSecond[23] := 'ены';
  VerbGroupSecond[24] := 'ить';
  VerbGroupSecond[25] := 'ыть';
  VerbGroupSecond[26] := 'ишь';
  VerbGroupSecond[27] := 'ую';
  VerbGroupSecond[28] := 'ю';
  Noun[0] := 'а';
  Noun[1] := 'ев';
  Noun[2] := 'ов';
  Noun[3] := 'ие';
  Noun[4] := 'ье';
  Noun[5] := 'е';
  Noun[6] := 'иями';
  Noun[7] := 'ями';
  Noun[8] := 'ами';
  Noun[9] := 'еи';
  Noun[10] := 'ии';
  Noun[11] := 'и';
  Noun[12] := 'ией';
  Noun[13] := 'ей';
  Noun[14] := 'ой';
  Noun[15] := 'ий';
  Noun[16] := 'й';
  Noun[17] := 'иям';
  Noun[18] := 'ям';
  Noun[19] := 'ием';
  Noun[20] := 'ем';
  Noun[21] := 'ам';
  Noun[22] := 'ом';
  Noun[23] := 'о';
  Noun[24] := 'у';
  Noun[25] := 'ах';
  Noun[26] := 'иях';
  Noun[27] := 'ях';
  Noun[28] := 'ы';
  Noun[29] := 'ь';
  Noun[30] := 'ию';
  Noun[31] := 'ью';
  Noun[32] := 'ю';
  Noun[33] := 'ия';
  Noun[34] := 'ья';
  Noun[35] := 'я';
  Superlative[0] := 'ейш';
  Superlative[1] := 'ейше';
  Derivational[0] := 'ост';
  Derivational[1] := 'ость';
END;

BEGIN  
  InitStaticData();
END.