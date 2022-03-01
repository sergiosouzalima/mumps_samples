	; Employees' Statistics Report. ;
	;
	; File mame: employeesReport.m
	; Author: Sergio Lima (Feb, 13 2022)
	; How to run: mumps -r main^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;	
main
	DO Initialize
	DO jsonToFile
	DO generateStatistics
	DO Finalize
	QUIT
	;
Initialize
	;
	DO loadConstants^helper
	;	
	WRITE #,!,programTitle,!!
	;	
	KILL ^employees,^departments,^debug
	ZSYSTEM "rm "_reportFileName_" 2> /dev/null"
	QUIT
	;
Finalize
	;
	W !,"END RUN ****",!!
	QUIT
	;
jsonToFile
	;	
	OPEN jsonFileName:(readonly:recordsize=maxStringSize)
	;	
	SET previousLine=""
	;	
	FOR i=1:1 QUIT:$zeof  SET previousLine=$$processLine(jsonFileName,previousLine)
	;	
	USE $principal
	CLOSE jsonFileName
	;	
	QUIT
	;	
processLine(jsonFile,previousLine)
	;	
	USE jsonFile 
	READ line
	SET currentLine=previousLine_line
	;	 
	SET currentLine=$$cleanLine(currentLine)
	;		
	SET previousLine=$$processObj(currentLine)
	;	
	QUIT previousLine
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
	SET id=$P($P(obj,",",1),":",2)
	;	
	IF objName="employee"  DO
	. SET content=$$extractEmployeeFields^helper(obj)
	. SET ok=$$create^employeeClass(id,content)
	;	
	IF objName="department"  DO
	. SET content=$$extractDeptName^helper(obj)
	. SET ok=$$create^departmentClass(id,content)
	;	
	QUIT
	;	
cleanLine(line)
	;	
	SET line=$translate(line,"""","")
	SET:line="{funcionarios:[" line=""
	SET:line="areas:[" line=""
	;	
	QUIT line
	;	
generateStatistics
	;
	DO main^employeesCalculate(reportFileName)
	;	
	QUIT
	;	