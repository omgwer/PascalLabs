PROGRAM CountWords(INPUT, OUTPUT);
USES
  SharedData, RootOfWordHelper; 
VAR
  NewRootWord: ValidWord;
BEGIN  
  //GetCountWordInfo(INPUT, OUTPUT);
  // NewRootWord := GetRootOFWord('упавши');
  // NewRootWord := GetRootOFWord('прогулявшись');
  // NewRootWord := GetRootOFWord('подсуетившись');
  // NewRootWord := GetRootOFWord('противоестественном');
  //NewRootWord := GetRootOFWord('мыться');
  NewRootWord := GetRootOFWord('бегавшая');
  NewRootWord := GetRootOFWord('перепила');
  NewRootWord := GetRootOFWord('перепейте');
END.                              