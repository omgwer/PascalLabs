PROGRAM BubbleSortMLB(INPUT, OUTPUT);
{Сортируем первую строку INPUT в OUTPUT}
VAR
  Sorted, Ch, Ch1, Ch2: CHAR;
  F1, F2: TEXT;
BEGIN { BubbleSort }
  { Копируем INPUT в F1 }
  WHILE NOT EOF(INPUT)
  DO {цикл работает пока не конец файла}
    BEGIN
      REWRITE(F1); 
      WHILE NOT EOLN(INPUT) {цикл работает пока не конец строки}
      DO {Записываем input в F1}
        BEGIN           
          READ(INPUT, Ch);
          WRITE(F1, Ch) 
        END;      
      WRITELN(F1);  
      Sorted := 'N';
      WHILE Sorted = 'N'
      DO
        BEGIN { Копируем F1 в F2, проверяя отсортированность и переставляя первые соседнии символы по порядку}
          Sorted := 'Y';          
          RESET(F1);
          REWRITE(F2);
          IF NOT EOLN(F1) {если ввести пустую строку сюда не заходит}
          THEN
            BEGIN                          
              READ(F1, Ch1);
              WHILE NOT EOLN(F1)
              DO { По крайней мере два символа остается для Ch1,Ch2 }
                BEGIN                  
                  READ(F1, Ch2);
                  IF Ch1 <= Ch2
                  THEN
                    BEGIN
                      WRITE(F2, Ch1);
                      Ch1 := Ch2
                    END
                  ELSE
                    BEGIN
                      WRITE(F2, Ch2);
                      Sorted := 'N'
                    END
                END;
              WRITELN(F2, Ch1) { Выводим последний символ в F2 } {7.4b перенес запись CH1 в F2 внутрь условия}  
            END;                    
          { Копируем F2 в F1 }
          RESET(F2);
          REWRITE(F1);              
          WHILE NOT EOLN(F2)               
          DO
            BEGIN                            
              READ(F2, Ch);              
              WRITE(F1, Ch)  
            END;
          WRITELN(F1)
        END;       
      { Копируем F1 в OUTPUT }       
      RESET(F1);        
      WHILE NOT EOLN(F1)                  
      DO
        BEGIN                  
          READ(F1, Ch);          
          WRITE(OUTPUT, Ch)
        END;
      WRITELN(OUTPUT);      
      READLN(INPUT)
    END
END.