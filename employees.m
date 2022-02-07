	; Employees' Statistics Report. ;
	;
	; File mame: employees.m
	; Author: Sergio Lima (Feb, 8 2022)
	; How to run: mumps -r ^employees
	;
	; Made with GT.M Mumps for Linux. ;
	;
	DO Initialize
	DO processFile(jsonFileName)
	DO Finalize
	QUIT
	;
Initialize
	;
	WRITE #,!,"*** Employees' Statistics Report ***",!!
	SET TRUE=1,FALSE=0
	SET jsonFileName="funcionarios-10K.json" ;"funcionarios-30M.json" ; ;"funcionarios.json"
	SET maxStringSize=1024*1024 ; the maximum GT.M string size
	SET globalEmpId=0,debugRow=0
	KILL ^globalEmp,^debug
	QUIT
	;
Finalize
	;
	W !!,"END RUN ****",!!
	QUIT
	;
processFile(jsonFile)
	;	
	;	
	OPEN jsonFile:(readonly:recordsize=maxStringSize)
	;	
	SET globalEmpId=0
	SET previousLine=""
	FOR i=1:1 DO
	. USE jsonFile
	. READ line
	. QUIT:$zeof
	. SET previousLine=previousLine_line
	. SET previousLine=$$processLine(previousLine,i) 
	USE $principal
	CLOSE jsonFile
	;	
	QUIT
	;	
processLine(line,i)
	;	
	SET line=$$cleanLine(line)
	;		
	SET line=$$processObj(line,i)
	;	
	QUIT line
	;	
processObj(line,i)
	;
	QUIT:$length(line)<=0 line
	;	
	SET firstBracket=$FIND(line,"{")-1,secondBracket=$FIND(line,"}",firstBracket)-1
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
	SET globalEmpId=globalEmpId+1
	;	
	SET ^globalEmp(globalEmpId)=obj
	;	
	QUIT
	;	
cleanLine(line)
	;	
	SET line=$translate(line," ","")
	SET line=$translate(line,"""","")
	IF line="{funcionarios:[" SET line=""
	IF line="areas:[" SET line=""
	;	
	QUIT line
	;	
saveDebug(msg)
	;
	SET debugRow=debugRow+1
	SET ^debug(debugRow)=msg
	QUIT
	;