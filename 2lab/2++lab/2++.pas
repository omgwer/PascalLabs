PROGRAM SymbolsSumm(INPUT, OUTPUT);
VAR
  Sotni, Desyatki, Edinicy, BufferSymbol: CHAR;
BEGIN 
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
        BEGIN { counter all operands }
          READ(BufferSymbol);
	  IF Edinicy = '9'
          THEN
	    BEGIN { counter second operand }
              Edinicy := '0';
	      IF Desyatki = '9'
	      THEN
	        BEGIN { counter first operand }
                  Desyatki := '0';
		  IF Sotni = '9'
		  THEN
		    BEGIN
		      Sotni := 'E';
		      BufferSymbol := '#'	
		    END
		  ELSE
                    BEGIN 	
		      IF Sotni = '8'
		      THEN
		        Sotni := '9';
  		      IF Sotni = '7'
		      THEN
		        Sotni := '8';
		      IF Sotni = '6'
		      THEN
		        Sotni := '7';
  		      IF Sotni = '5'
		      THEN
		        Sotni := '6';
		      IF Sotni = '4'
		      THEN
		        Sotni := '5';
  		      IF Sotni = '3'
		      THEN
		        Sotni := '4';
		      IF Sotni = '2'
		      THEN
		        Sotni := '3';
  		      IF Sotni = '1'
		      THEN
		        Sotni := '2';
		      IF Sotni = '0'
		      THEN 	
		        Sotni := '1'
                    END    			        		  		
		END { counter first operand }
              ELSE
                BEGIN 
                  IF Desyatki = '8'
	          THEN
                    Desyatki := '9';
                  IF Desyatki = '7'
	          THEN
                    Desyatki := '8';
                  IF Desyatki = '6'
	          THEN
                    Desyatki := '7';
                  IF Desyatki = '5'
	          THEN
                    Desyatki := '6';
                  IF Desyatki = '4'
	          THEN
                    Desyatki := '5';
                  IF Desyatki = '3'
	          THEN
                    Desyatki := '4';
                  IF Desyatki = '2'
	          THEN
                    Desyatki := '3';
                  IF Desyatki = '1'
	          THEN
                    Desyatki := '2';
	          IF Desyatki = '0'
                  THEN
                    Desyatki := '1'
                END  	    	   
            END { counter second operand }
          ELSE
            BEGIN                
              IF Edinicy = '8'
              THEN
                Edinicy := '9';
              ELSE
                BEGIN
                  IF Edinicy = '7'
                  THEN
                    Edinicy := '8';
                  ELSE
                    BEGIN
                      IF Edinicy = '6'
                      THEN
                        Edinicy := '7';
                      ELSE
                        BEGIN
                          IF Edinicy = '5'
                          THEN
                            Edinicy := '6';
                          ELSE
                            BEGIN
                              IF Edinicy = '4'
                              THEN
                                Edinicy := '5';
                              ELSE
                                BEGIN
                 	          IF Edinicy = '3'
	                          THEN
                                    Edinicy := '4';
                                  ELSE
                                    BEGIN
                                      IF Edinicy = '2'
                                      THEN
                                        Edinicy := '3';
                                      ELSE
                                        BEGIN
                                          IF Edinicy = '1'
	                                  THEN
	                                    Edinicy := '2';
                                          ELSE
                                            BEGIN
                                              IF Edinicy = '0'
	                                      THEN
  	                                      Edinicy := '1'
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                    END;
                END;
            END;
         END;
      END;
   END;
        END; { counter all operand }          
    END;  { counter symbols }
    IF Sotni <> 'E'
    THEN
      WRITELN('Number of characters is ', Sotni, Desyatki, Edinicy)
    ELSE
      WRITELN('ERROR! STACK OVERFLOW')  		
END.
