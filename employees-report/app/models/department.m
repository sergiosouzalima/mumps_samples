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
	SET deptName=$piece(data,SEP,1)
	SET ^departments(id)=deptName
	QUIT TRUE
	;	
create(id,data)
	;
	QUIT $$set(id,data)
	;
update(id,data)
	;
	QUIT $$set(id,data)
	;
get(id,data)
	NEW record
	KILL data
	IF id="" QUIT FALSE
	SET record=$get(^departments(id))
	SET data("deptName")=$piece(record,SEP,1)
	QUIT TRUE
	;
getProp(id,propertyName)
	IF id="" QUIT ""
	SET ok=$$get(id,.data)
	IF ok QUIT data(propertyName)
	IF 'ok QUIT ""
	;
getDeptName(id)
	;
	QUIT $$getProp(id,"deptName")
	;
delete(id)
	IF id="" QUIT FALSE
	KILL ^departments(id)
	QUIT TRUE
	;	