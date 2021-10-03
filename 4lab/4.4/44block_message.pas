DP1.7
  BEGIN {создать сообщение Sarah}
    IF Looking = 'L'
    THEN
      WRITELN('The British are coming by land.')
    ELSE
      IF Looking = 'S'
      THEN
        WRITELN('The British are coming by sea.')
      ELSE
        IF Looking = 'A'
        THEN
          WRITELN('The British are coming by air.')
        ELSE
          WRITELN('Sarah didn''t say')
  END