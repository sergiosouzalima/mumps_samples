	; Employees' Statistics Report. ;
	;
	; File mame: lastNameMax.m
	; Author: Sergio Lima (Feb, 17 2022)
	; How to run: mumps -r ^employees
	;
	; Made with GT.M Mumps for Linux. ;
	;
	; ^LastNameMax(employeeLastName)=employeeFullName^salaryValue
	;
	; ^LastNameMax("Ramos")="Washington Ramos^2700.00"
	; ^LastNameMax("Farias")="Cleverton Farias^2750.00"
	;
	SET SEP="^"
	SET TRUE=1,FALSE=0
	;
set(employeeLastName,salaryValue)
	KILL data
	IF employeeLastName="" QUIT FALSE
	SET exists=$D(^LastNameMax(employeeLastName))
	;	
	IF 'exists SET ^LastNameMax(employeeLastName)=salaryValue*1
	;	
	IF exists DO
	. SET:(^LastNameMax(employeeLastName)'>salaryValue) ^LastNameMax(employeeLastName)=salaryValue*1
	;	
	QUIT TRUE
	;	