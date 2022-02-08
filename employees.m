	; Employees' Statistics Report. ;
	;
	; File mame: employees.m
	; Author: Sergio Lima (Feb, 9 2022)
	; How to run: mumps -r ^employees
	;
	; Made with GT.M Mumps for Linux. ;
	;
	DO Initialize
	DO jsonToFile(jsonFileName)
	;	
	DO generateStats
	DO Finalize
	QUIT
	;
Initialize
	;
	WRITE #,!,"*** Employees' Statistics Report ***",!!
	SET TRUE=1,FALSE=0
	SET jsonFileName="funcionarios.json" ;"funcionarios-10K.json" ;"funcionarios-30M.json" ;
	SET maxStringSize=1024*1024 ; the maximum GT.M string size
	SET employeeId=0,departmentId=0,debugId=0
	KILL ^employee,^department,^debug
	QUIT
	;
Finalize
	;
	W !!,"END RUN ****",!!
	QUIT
	;
jsonToFile(jsonFile)
	;	
	OPEN jsonFile:(readonly:recordsize=maxStringSize)
	;	
	SET employeeId=0
	SET departmentId=0
	SET previousLine=""
	;FOR i=1:1 DO
	;. USE jsonFile
	;. READ line
	;. QUIT:$zeof
	;. SET previousLine=previousLine_line
	;. SET previousLine=$$processLine(previousLine,i) 
	;	
	;FOR i=1:1 QUIT:$zeof  USE jsonFile READ line SET previousLine=previousLine_line,previousLine=$$processLine(previousLine,i)
	FOR i=1:1 QUIT:$zeof  SET previousLine=$$processLine(jsonFile,previousLine)
	;	
	USE $principal
	CLOSE jsonFile
	;	
	QUIT
	;	
processLine(jsonFile,previousLine)
	;	
	USE jsonFile 
	READ line
	SET currentLine=previousLine_line
	;SET previousLine=$$processLine(previousLine,i)
	;	 
	SET currentLine=$$cleanLine(currentLine)
	;		
	SET previousLine=$$processObj(currentLine)
	;	
	QUIT previousLine
	;
	;QUIT previousLine
	;	
;processLine(line)
	;	
	;SET line=$$cleanLine(line)
	;		
	;SET restLine=$$processObj(line)
	;	
	;QUIT restLine
	;	
processObj(line)
	;
	QUIT:$length(line)<=0 line
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
	;	
	SET:objName="employee" employeeId=employeeId+1,^employee(employeeId)=obj
	SET:objName="department" departmentId=departmentId+1,^department(departmentId)=obj
	;	
	QUIT
	;	
cleanLine(line)
	;	
	SET line=$translate(line,"""","")
	IF line="{funcionarios:[" SET line=""
	IF line="areas:[" SET line=""
	;	
	QUIT line
	;	
generateStats
	;
	DO main^globalMaxMain
	;	
	QUIT
	;	
saveDebug(msg)
	;
	SET debugId=debugId+1
	SET ^debug(debugId)=msg
	QUIT
	;