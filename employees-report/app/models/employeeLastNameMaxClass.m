	; Employees' Statistics Report. ;
	;
	; File mame: employeeLastNameMaxClass.m
	; Author: Sergio Lima (Feb, 17 2022)
	; How to run: mumps -r ^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;
	; ^lastNameMax	(employeeLastName)=employeeFullName^salaryValue
	;
	; ^lastNameMax("Ramos")="Washington Ramos^2700.00"
	; ^lastNameMax("Farias")="Cleverton Farias^2750.00"
	;
	SET SEP="^"
	SET TRUE=1,FALSE=0
	;
set(employeeLastName,employeeSalaryValue)
	QUIT:employeeLastName="" FALSE
	;	
	SET exists=$D(^lastNameMax(employeeLastName))
	;	
	QUIT:'exists $$create(employeeLastName,employeeSalaryValue)
	;	
	SET lastNameMaxSalaryValue=$$getSalaryValue(employeeLastName)
	;	
	SET foundHigherSalary=(employeeSalaryValue'<lastNameMaxSalaryValue)
	;	
	SET:foundHigherSalary ok=$$update(employeeLastName,employeeSalaryValue)
	SET:'foundHigherSalary ok=$$update(employeeLastName,lastNameMaxSalaryValue)
	;	
	QUIT ok
	;
create(employeeLastName,salaryValue)
	SET salaryValue=salaryValue
	SET employeeQty=1
	SET ^lastNameMax(employeeLastName)=salaryValue_SEP_employeeQty
	;
	QUIT TRUE
	;
update(employeeLastName,salaryValue)
	QUIT:'$$get(employeeLastName,.data) FALSE
	;
	SET employeeQty=data("employeeQty")+1
	;
	SET ^lastNameMax(employeeLastName)=salaryValue_SEP_employeeQty
	;	
	QUIT TRUE
	;
get(employeeLastName,data)
	NEW record
	KILL data
	IF employeeLastName="" QUIT FALSE
	SET record=$get(^lastNameMax(employeeLastName))
	SET data("salaryValue")=$piece(record,SEP,1)
	SET data("employeeQty")=$piece(record,SEP,2)
	;	
	QUIT TRUE
	;
getProp(employeeLastName,propertyName)
	IF employeeLastName="" QUIT ""
	SET ok=$$get(employeeLastName,.data)
	IF ok QUIT data(propertyName)
	IF 'ok QUIT ""
	;
getSalaryValue(employeeLastName)
	;
	QUIT $$getProp(employeeLastName,"salaryValue")
	;
getEmployeeQty(employeeLastName)
	;
	QUIT $$getProp(employeeLastName,"employeeQty")
	;