PROGRAM SymbolsSumm(INPUT, OUTPUT);
VAR
  FirstOp, SecondOp, ThirdOp, BufferSymbol: CHAR;
BEGIN 
  READ(BufferSymbol);
  IF BufferSymbol = '#'
  THEN
    WRITELN('Number of characters is 0')
  ELSE
    BEGIN { counter symbols }
      FirstOp := '0';
      SecondOp := '0';
      ThirdOp := '0';      
      WHILE BufferSymbol <> '#'
      DO	
        BEGIN { counter all operands }
          READ(BufferSymbol);
	  IF ThirdOp = '9'
          THEN
	    BEGIN { counter second operand }
              ThirdOp := '0';
	      IF SecondOp = '9'
	      THEN
	        BEGIN { counter first operand }
                  SecondOp := '0';
		  IF FirstOp = '9'
		  THEN
		    BEGIN
		      FirstOp := 'E';
		      BufferSymbol := '#'	
		    END
		  ELSE
                    BEGIN 	
		      IF FirstOp = '8'
		      THEN
		        FirstOp := '9';
  		      IF FirstOp = '7'
		      THEN
		        FirstOp := '8';
		      IF FirstOp = '6'
		      THEN
		        FirstOp := '7';
  		      IF FirstOp = '5'
		      THEN
		        FirstOp := '6';
		      IF FirstOp = '4'
		      THEN
		        FirstOp := '5';
  		      IF FirstOp = '3'
		      THEN
		        FirstOp := '4';
		      IF FirstOp = '2'
		      THEN
		        FirstOp := '3';
  		      IF FirstOp = '1'
		      THEN
		        FirstOp := '2';
		      IF FirstOp = '0'
		      THEN 	
		        FirstOp := '1'
                    END    			        		  		
		END { counter first operand }
              ELSE
                BEGIN 
                  IF SecondOp = '8'
	          THEN
                    SecondOp := '9';
                  IF SecondOp = '7'
	          THEN
                    SecondOp := '8';
                  IF SecondOp = '6'
	          THEN
                    SecondOp := '7';
                  IF SecondOp = '5'
	          THEN
                    SecondOp := '6';
                  IF SecondOp = '4'
	          THEN
                    SecondOp := '5';
                  IF SecondOp = '3'
	          THEN
                    SecondOp := '4';
                  IF SecondOp = '2'
	          THEN
                    SecondOp := '3';
                  IF SecondOp = '1'
	          THEN
                    SecondOp := '2';
	          IF SecondOp = '0'
                  THEN
                    SecondOp := '1'
                END  	    	   
            END { counter second operand }
          ELSE
            BEGIN                
              IF ThirdOP = '8'
              THEN
                ThirdOp := '9';
              IF ThirdOp = '7'
              THEN
                ThirdOp := '8';
              IF ThirdOp = '6'
              THEN
                ThirdOp := '7';
              IF ThirdOp = '5'
              THEN
                ThirdOp := '6';
              IF ThirdOp = '4'
              THEN
                ThirdOp := '5';
	      IF ThirdOp = '3'
	      THEN
                ThirdOp := '4';
              IF ThirdOp = '2'
              THEN
                ThirdOp := '3';
              IF ThirdOp = '1'
	      THEN
	        ThirdOp := '2';
              IF ThirdOp = '0'
	      THEN
  	        ThirdOp := '1'
            END           
        END { counter all operand }          
    END;  { counter symbols }
    IF FirstOp <> 'E'
    THEN
      WRITELN('Number of characters is ', FirstOp,SecondOp,ThirdOp)
    ELSE
      WRITELN('ERROR! STACK OVERFLOW')  		
END.
