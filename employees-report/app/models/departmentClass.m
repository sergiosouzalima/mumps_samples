	; Employees' Statistics Report. ;
	;
	; File mame: departmentClass.m
	; Author: Sergio Lima (Feb, 12 2022)
	; How to run: mumps -r ^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;
	; ^departments(id)=deptName^employeeQty
	;
	; ^departments("SD")="Software Development^1"
	; ^departments("SM")="Software Management^22"
	;
	SET SEP="^"
	SET TRUE=1,FALSE=0
	;
set(id,data)
	IF id="" QUIT FALSE
	SET deptName=$piece(data,SEP,1)
	SET employeeQty=$piece(data,SEP,2)
	SET:employeeQty="" employeeQty=0
	SET ^departments(id)=deptName_SEP_employeeQty
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
	SET data("employeeQty")=$piece(record,SEP,2)
	QUIT TRUE
	;
incEmployeeQty(id)
	;
	KILL data
	IF id="" QUIT FALSE
	QUIT:'$$get(id,.data) FALSE
	;	
	SET deptName=data("deptName")
	SET employeeQty=data("employeeQty")+1
	SET data=deptName_SEP_employeeQty
	SET ok=$$update(id,data)
	QUIT ok
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
getEmployeeQty(id)
	;
	QUIT $$getProp(id,"employeeQty")
	;
delete(id)
	IF id="" QUIT FALSE
	KILL ^departments(id)
	QUIT TRUE
	;	