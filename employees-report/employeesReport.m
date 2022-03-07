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
	DO importJsonFile
	DO generateStatistics
	DO Finalize
	QUIT
	;
Initialize
	;	
	WRITE #,!,$$PROGRAMTITLE^constantClass,!!
	WRITE "Reading from file... "_$$JSONFILENAME^constantClass,!
	WRITE "Writing to file..... "_$$REPORTFILENAME^constantClass,!
	;	
	KILL ^employees,^departments,^debug
	;	
	IF '$$fileExists^helper($$JSONFILENAME^constantClass) DO
	. WRITE !,"File not found: "_$$JSONFILENAME^constantClass,!
	. HALT
	;	
	ZSYSTEM "rm "_$$REPORTFILENAME^constantClass_" 2> /dev/null"
	QUIT
	;
Finalize
	;
	W !,"END RUN ****",!!
	QUIT
	;
importJsonFile
	;	
	OPEN $$JSONFILENAME^constantClass:(readonly:recordsize=$$MAXSTRINGSIZE^constantClass)
	;	
	USE $$JSONFILENAME^constantClass 
	;	
	SET previousLine=""
	;	
	FOR  QUIT:$zeof  DO
	. SET previousLine=$$processLine(previousLine)
	;	
	USE $principal
	;	
	CLOSE $$JSONFILENAME^constantClass
	;	
	QUIT
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
	QUIT:(previousLine="")&($$allTrim^helper(line)="{") ""
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
	SET:line="funcionarios:[" line=""
	SET:line="areas:[" line=""
	;	
	QUIT line
	;	
generateStatistics
	;
	DO main^employeesCalculate($$REPORTFILENAME^constantClass)
	;	
	QUIT
	;	