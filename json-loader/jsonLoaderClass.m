	; Json file loader ;
	;
	; File mame: jsonLoaderClass.m
	; Author: Sergio Lima (Mar, 9 2022)
	; How to run:
	;  SET result=$$run^jsonLoaderClass(jsonFileName)
	;	
	; Made with GT.M Mumps for Linux. ;
	;	
run(jsonFileName)
	;	
	QUIT:'$$fileExists(jsonFileName) "file not found."
	;	
	SET MAXSTRINGSIZE=1024*1024 ; the maximum GT.M string size 
	;	
	SET lineCounter=0
	;	
	OPEN jsonFileName:(readonly:recordsize=MAXSTRINGSIZE)
	;	
	USE jsonFileName 
	;	
	SET previousLine=""
	;	
	FOR  QUIT:$zeof  DO
	. SET previousLine=$$processLine(previousLine)
	;	
	USE $principal
	;	
	CLOSE jsonFileName
	;	
	QUIT "done."
	;
processLine(previousLine)
	;	 
	READ line
	;	
	SET currentLine=previousLine_$$cleanLine(line)
	;	 
	QUIT $$processObj(currentLine,previousLine)
	;
processObj(line,previousLine)
	;	
	QUIT:$length(line)<=0 line
	;	
	QUIT:(previousLine="")&($$allTrim(line)="{") ""
	;	
	SET firstBracket=$FIND(line,"{")-1
	SET secondBracket=$FIND(line,"}",firstBracket)-1
	;
	QUIT:((firstBracket=-1)!(secondBracket=-1))!(secondBracket<firstBracket) line
	;	
	SET obj=$extract(line,firstBracket,secondBracket)
	;
	DO saveObj(obj)
	;		
	SET restLine=$extract(line,secondBracket+1,$length(line))
	;	
	QUIT restLine
	;
saveObj(obj)
	;
	SET objName="employee"
	SET:obj["codigo" objName="department"
	SET id=$P($P(obj,",",1),":",2)
	;	
	SET lineCounter=$$incLineCounter()
	;	
	IF objName="employee"  DO
	. SET ^JSON(lineCounter)=$$extractEmployeeFields(obj)
	;	
	IF objName="department"  DO
	. SET ^JSON(lineCounter)=$$extractDeptName(obj)
	;	
	QUIT
	;	
cleanLine(line)
	;	
	SET line=$translate(line,"""","")
	SET:line="{funcionarios:[" line=""
	SET:line="funcionarios:[" line=""
	SET:line="areas:[" line=""
	;	
	QUIT line
	;
fileExists(fileName)
	;
	SET empty=$ZSEARCH(fileName)
	;	
	QUIT:empty="" 0
	;	
	QUIT 1
	;
allTrim(content)
	;
	QUIT $$FUNC^%TRIM(content)
	;
lineCounter()
	;	
	QUIT lineCounter
	;	
incLineCounter()
	;
	QUIT lineCounter+1
	;	
extractDeptName(content)
	;
	IF content["nome:" SET content=$P($P(content,",",2),":",2)
	;
	QUIT $$removeBraces(content)
	;
extractEmployeeFields(content)
	; {id:1,nome:Aahron,sobrenome:Abaine,salario:24048.75,area:A2}
	;
	SET content=$$removeBraces(content)
	SET content=$P($P(content,",",2),":",2)_$$SEP^constantClass_$$dashToPlusReplace^helper($P($P(content,",",3),":",2))_$$SEP^constantClass_$P($P(content,",",4),":",2)_$$SEP^constantClass_$P($P(content,",",5),":",2)
	SET content="{"_content_"}"
	QUIT content
	;
removeBraces(content)
	;
	QUIT $translate(content,"{}","")
	;	