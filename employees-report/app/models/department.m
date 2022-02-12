	; Employees' Statistics Report. ;
	;
	; File mame: department.m
	; Author: Sergio Lima (Feb, 12 2022)
	; How to run: mumps -r ^employees
	;
	; Made with GT.M Mumps for Linux. ;
	;
	; ^departments(id)=deptName
	;
	; ^departments("SD")="Software Development"
	; ^departments("SM")="Software Management"
	;
	SET SEP="^"
	SET TRUE=1,FALSE=0
	;
set(id,data)
	IF id="" QUIT FALSE
	SET name=$piece(data,SEP,1)
	SET ^departments(id)=name
	QUIT TRUE
	;	
fetch(id,data)
	NEW record
	KILL data
	IF id="" QUIT FALSE
	SET record=$get(^departments(id))
	SET data("name")=$piece(record,SEP,1)
	QUIT TRUE
	;
fetchProp(id,propertyName)
	IF id="" QUIT ""
	SET ok=$$fetch(id,.data)
	IF ok QUIT data(propertyName)
	IF 'ok QUIT ""
	;
fetchName(id)
	NEW name
	IF id="" QUIT ""
	SET name=$$fetchProp(id,"name")
	IF ok QUIT name
	IF 'ok QUIT ""
	;
remove(id)
	IF id="" QUIT FALSE
	KILL ^departments(id)
	QUIT TRUE
	;	