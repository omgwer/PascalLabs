PROGRAM SelectSort(INPUT, OUTPUT);
{Сортирует символы, предшествующие #, из INPUT в OUTPUT.
 Программа выдаст ошибку, если в INPUT отсутствует #}
VAR
  Ch, Min: CHAR;
  F1, F2: TEXT;
BEGIN {SelectSort}
  {Копировать INPUT в F1 и эхо в OUTPUT}
  REWRITE(F1);
  WRITE(OUTPUT, 'INPUT DATA: ');
  READ(INPUT, Ch);
  WRITE(OUTPUT, 'INPUT ECHO: ');
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(F1, Ch);
      WRITE(OUTPUT, Ch);
      READ(INPUT, Ch)
    END;
  WRITELN(OUTPUT);
  WRITELN(F1, '#');
  {Сортировать F1 в OUTPUT, используя стратегию SelectSort}
  {WRITE(OUTPUT, 'SORTED DATA: ');}
  RESET(F1);
  READ(F1, Ch);    
  WHILE Ch <> '#'
  DO { Ch <> '#' и Ch1 - первый символ F1}
    BEGIN  {Выбираем минимальный из F1 и копируем остаток F1 в F2}
      REWRITE(F2);     
      Min := Ch;
      WRITE(OUTPUT, 'Min = ');
      WRITE(OUTPUT, Min);
      WRITE(OUTPUT, ' F2 = ');      
      READ(F1, Ch);            
      WHILE Ch <> '#'
      DO { Ch <> '#' и Ch1 - первый символ F1}
        BEGIN {Выбираем минимальный из (Ch, Min) копируем второй символ в F2}                    
          WRITE(F2, Ch);
          WRITE(OUTPUT, Ch);            
          READ(F1, Ch)                             
        END;      
      WRITELN(F2, '#');
      {WRITE(OUTPUT, Min);}
      {Копируем F2 в F1}
      RESET(F2);
      REWRITE(F1);
      READ(F2, Ch);
      WRITELN(OUTPUT);
      WRITE(OUTPUT, 'F1 = ');
      WHILE Ch <> '#'
      DO
        BEGIN
          WRITE(F1, Ch);
          WRITE(OUTPUT, Ch);
          READ(F2, Ch)                    
        END;
      WRITELN(F1, '#');
      WRITE(OUTPUT, ' ');
      {Копируем F2 в F1}
      RESET(F1);
      READ(F1, Ch)
    END;
  WRITELN(OUTPUT)  
END. {SelectSort} 
