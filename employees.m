	; Employees' Statistics Report. ;
	;
	; File mame: employees.m
	; Author: Sergio Lima (Feb, 02 2022)
	; How to run: mumps -r ^employees
	;
	; Made with GT.M Mumps for Linux. ;
	;
	DO Initialize
	DO ProcessFile(jsonFileName)
	DO Finalize
	QUIT
	;
Initialize
	;
	WRITE #,!,"*** Employees' Statistics Report ***",!!
	SET TRUE=1,FALSE=0
	SET jsonFileName="funcionarios-10K.json" ;"funcionarios.json"
	SET maxStringSize=1024*1024 ; the maximum GT.M string size
	QUIT
	;
Finalize
	;
	W !!,"END RUN ****",!!
	QUIT
	;
	;****************
	; DESCRIPTION: 
	; PARAMETERS: 
	;    jsonFile(I/O,REQ): 
	; RETURNS: 
	; REVISIONS: 
	;****************
ProcessFile(jsonFile)
	;
	OPEN jsonFile:(readonly:recordsize=maxStringSize)
	;	
	;FOR i=1:1 USE jsonFile READ line QUIT:$zeof  USE $principal WRITE !,i,?5,line
	S textFile=""
	FOR i=1:1 USE jsonFile READ line QUIT:$zeof  S textFile=textFile_line USE $principal S x=$$cleanLine(line)
	CLOSE jsonFile
	W textFile
	;	
	QUIT
	;	
ProcessLine(line)
	;	
	SET line=$$cleanLine(line)
	;WRITE line,!
	QUIT
	;	
cleanLine(line)
	;	
	S line=$translate(line,",""","^")
	QUIT line
	;	
setJsonToMatrix(jsonObjType,line,id)
	;
	QUIT:line["{"
	QUIT:line["}"
	QUIT:line["},"
	QUIT:line["["
	QUIT:line["]"
	D:jsonObjType="employee" setJsonToEmployee(line,id)
	D:jsonObjType="department" setJsonToDepartment(line,id)
	;USE $principal WRITE !,i,?5,jsonObjType,line
	QUIT
	;	
setJsonToEmployee(line,id)
	;
	SET:line["id" id=$PIECE(line,":",1)
	SET Employee(id)=...... ;
	QUIT id
	;	
setJsonToDepartment(line,id)
	;
	SET:line["codigo" id=$PIECE(line,":",1)
	SET Employee(id)=...... ;
	QUIT id
	;	