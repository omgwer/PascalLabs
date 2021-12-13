PROGRAM DeleteSpace(INPUT, OUTPUT);
VAR
  Ch, Sp: CHAR;
BEGIN	
	IF NOT EOLN
	THEN
	  BEGIN
	    READ(Ch);
	    WHILE (Ch = ' ') AND (NOT EOLN)
	    DO
        READ(Ch);
      IF Ch <> ' '
			THEN
	  		WRITE(Ch)
	  END;	
	WHILE NOT EOLN
	DO
	  BEGIN
	    READ(Ch);
	    IF Ch <> ' '
	    THEN
	      WRITE(Ch)
	    ELSE
	      BEGIN	        
	        WHILE (Ch = ' ') AND (NOT EOLN)
	        DO
	          READ(Ch);
	        IF NOT EOLN
	        THEN          
	          WRITE(' ');
	        IF Ch <> ' '
	        THEN
	          WRITE(Ch)
	      END
	  END;
	WRITELN('#')   	
END.
