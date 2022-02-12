	; Employees' Statistics Report. ;
	;
	; File mame: employee.m
	; Author: Sergio Lima (Feb, 12 2022)
	; How to run: mumps -r ^employees
	;
	; Made with GT.M Mumps for Linux. ;
	;
	; ^employees(id)="employeeName^employeeLastName^salaryValue^deptId"
	;
	; ^employees(1)="Washington^Ramos^2700.00^SD"
	; ^employees(2)="Wilson^Silva^3200.00^SM"
	;	
	;	
	SET SEP="^"
	SET TRUE=1,FALSE=0
	;	
set(id,data)
	IF id="" QUIT FALSE
	SET employeeName=$piece(data,SEP,1)
	SET employeeLastName=$piece(data,SEP,2)
	SET salaryValue=$piece(data,SEP,3)
	SET deptId=$piece(data,SEP,4)
	SET ^employees(id)=employeeName_SEP_employeeLastName_SEP_salaryValue_SEP_deptId
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
fetch(id,data)
	NEW record
	KILL data
	IF id="" QUIT FALSE
	SET record=$get(^employees(id))
	SET data("employeeName")=$piece(record,SEP,1)
	SET data("employeeLastName")=$piece(record,SEP,2)
	SET data("salaryValue")=$piece(record,SEP,3)
	SET data("deptId")=$piece(record,SEP,4)
	QUIT TRUE
	;
fetchProp(id,propertyName)
	IF id="" QUIT ""
	SET ok=$$fetch(id,.data)
	IF ok QUIT data(propertyName)
	IF 'ok QUIT ""
	;
fetchEmployeeName(id)
	NEW employeeName
	IF id="" QUIT ""
	SET employeeName=$$fetchProp(id,"employeeName")
	IF ok QUIT employeeName
	IF 'ok QUIT ""
	;
delete(id)
	IF id="" QUIT FALSE
	KILL ^employees(id)
	QUIT TRUE