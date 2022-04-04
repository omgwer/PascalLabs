PROGRAM SortDate(INPUT, OUTPUT);
USES
  Dates;
VAR
  Copying: BOOLEAN;
  D, VarDate: Date;
  TFile, DateFile: FileOfDate;
  FInput: TEXT;

BEGIN{SortDate}
  ASSIGN(DateFile, 'DF.DAT');
  ASSIGN(TFile, 'TF.DAT');
  ASSIGN(FInput, 'FI.TXT');
  REWRITE(DateFile);
  RESET(FInput);
  ReadDate(FInput, VarDate);
  READLN(FInput);
  WRITE(DateFile, VarDate);
  RESET(DateFile);
  WHILE NOT EOF(FInput)
  DO
    {DP1.1 ѕоместить новую дату в DateFile в соответствующее место}
    BEGIN
      ReadDate(FInput,D);
      READLN(FInput);
      IF (D.Mo <> NoMonth)
      THEN
        BEGIN
          {DP1.1.1 копируем элементы меньшие, чем D из DateFile в TFile}          
            REWRITE(TFile);
            Copying := TRUE;
            WHILE NOT EOF(DateFile) AND Copying
            DO
              BEGIN
                READ(DateFile, VarDate);
                IF Less(VarDate, D)
                THEN
                  WRITE(TFile, VarDate)
                ELSE
                  Copying := FALSE
              END;          
          {копируем D в TFile}          
          WRITE(Tfile, D);
          {копируем остаток DateFile в TFile}                   
          IF EOF(DateFile) AND NOT Copying
          THEN
            WRITE(TFile, VarDate);  
          WHILE NOT EOF(DateFile)
          DO
            BEGIN
              WRITE(TFile, VarDate);
              READ(DateFile, VarDate);
              IF EOF(DateFile)
              THEN
                WRITE(TFile, VarDate)
            END;        
          {копируем TFile в DateFile}
          RESET(Tfile);
          REWRITE(DateFile);
          WHILE NOT EOF(Tfile)
          DO
            BEGIN
              READ(Tfile, VarDate);
              WRITE(DateFile, VarDate)                            
            END;
          RESET(DateFile)    
        END
    END;
  {DP1.2
   опируем DateFile в OUTPUT}
  RESET(DateFile);
  CopyOut(DateFile)
END.{SortDate}
