PROGRAM SymbolsSumm(INPUT, OUTPUT);
VAR
  Sotni, Desyatki, Edinicy, BufferSymbol: CHAR;
BEGIN { program SymbolsSumm}
  READ(BufferSymbol);
  IF BufferSymbol = '#'
  THEN
    WRITELN('Number of characters is 0')
  ELSE
    BEGIN { counter symbols }
      Sotni := '0';
      Desyatki := '0';
      Edinicy := '0';      
      WHILE BufferSymbol <> '#'
      DO	
        BEGIN { counter all symbols }
          READ(BufferSymbol);
          IF Edinicy = '9'
          THEN
            BEGIN { counter desyatki and sotni }
              Edinicy := '0';
              IF Desyatki = '9'
              THEN
                BEGIN { counter sotni }
                  Desyatki := '0';
                  IF Sotni = '9'
                  THEN
                    BEGIN
                      Sotni := 'E';
                      BufferSymbol := '#'	
                    END
                  ELSE                    
                      IF Sotni = '8'
                      THEN
                        Sotni := '9'
                      ELSE
                        IF Sotni = '7'
                        THEN
                          Sotni := '8'
                        ELSE
                          IF Sotni = '6'
                          THEN
                            Sotni := '7'
                          ELSE
                            IF Sotni = '5'
                            THEN
                              Sotni := '6'
                            ELSE
                              IF Sotni = '4'
                              THEN
                                Sotni := '5'
                              ELSE
                                IF Sotni = '3'
                                THEN
                                  Sotni := '4'
                                ELSE
                                  IF Sotni = '2'
                                  THEN
                                    Sotni := '3'
                                  ELSE
                                    IF Sotni = '1'
                                    THEN
                                      Sotni := '2'
                                    ELSE
                                      Sotni := '1'				   			        		  		
                END { counter sotni }
              ELSE          
                  IF Desyatki = '8'
                  THEN
                    Desyatki := '9'
                  ELSE
                    IF Desyatki = '7'
                    THEN
                      Desyatki := '8'
                    ELSE
                      IF Desyatki = '6'
                      THEN
                        Desyatki := '7'
                      ELSE
                        IF Desyatki = '5'
                        THEN
                          Desyatki := '6'
                        ELSE
                          IF Desyatki = '4'
                          THEN
                            Desyatki := '5'
                          ELSE
                            IF Desyatki = '3'
                            THEN
                              Desyatki := '4'
                            ELSE
                              IF Desyatki = '2'
                              THEN
                                Desyatki := '3'
                              ELSE
                                IF Desyatki = '1'
                                THEN
                                  Desyatki := '2'
                                ELSE
                                  Desyatki := '1'                         
          	END { counter desyatki and sotni }
          ELSE                           
            IF Edinicy = '8'
            THEN
              Edinicy := '9'
            ELSE                
              IF Edinicy = '7'
              THEN
                Edinicy := '8'
              ELSE                    
                IF Edinicy = '6'
                THEN
                  Edinicy := '7'
                ELSE                        
                  IF Edinicy = '5'
                  THEN
                    Edinicy := '6'
                  ELSE                            
                    IF Edinicy = '4'
                    THEN
                      Edinicy := '5'
                    ELSE                                
                      IF Edinicy = '3'
                      THEN
                        Edinicy := '4'
                      ELSE                                    
                        IF Edinicy = '2'
                        THEN
                          Edinicy := '3'
                        ELSE                                        
                          IF Edinicy = '1'
                          THEN
                            Edinicy := '2'
                          ELSE                                            
                            Edinicy := '1'                                  
        END { counter all operand }          
    END;  { counter symbols }
  IF Sotni <> 'E'
  THEN
    WRITELN('Number of characters is ', Sotni, Desyatki, Edinicy)
  ELSE
    WRITELN('ERROR! Number of characters > 999')  		
END. { program SymbolsSumm }