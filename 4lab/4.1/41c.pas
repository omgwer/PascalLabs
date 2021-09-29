PROGRAM PaulRevere(INPUT, OUTPUT);
VAR
  Lanterns: CHAR;
BEGIN {PaulRevere}
  {Read Lanterns}
  READ(Lanterns);
  {Issue Paul Revere's message}
  IF Lanterns = 'L'
  THEN
    BEGIN
      READ(Lanterns);
      IF Lanterns <> 'L'
      THEN    
        WRITELN('The British are coming by land.')
      ELSE        
        WRITELN('The British are coming by sea.')
    END  
  ELSE
    WRITELN('The North Church shows only ''', Lanterns, '''.')
END. {PaulRevere}

