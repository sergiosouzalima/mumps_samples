	; Employees' Statistics Report. ;
	;
	; File mame: employeeLastNameMaxClass.m
	; Author: Sergio Lima (Feb, 17 2022)
	; How to run: mumps -r ^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;
	; lastNameMax(employeeLastName)=salaryValue^employeeQty
	;	
	; ^lastNameMax("Watanabe")="33376.08^2"
	; ^lastNameMax("Waters")="84516.18^2"
	;
set(employeeLastName,employeeSalaryValue)
	QUIT:employeeLastName="" $$FALSE^constantClass
	;	
	SET exists=$D(^lastNameMax(employeeLastName))
	;	
	QUIT:'exists $$create(employeeLastName,employeeSalaryValue)
	;	
	SET dataRecord=^lastNameMax(employeeLastName)
	;	
	SET lastNameMaxSalaryValue=$$getSalaryValue(employeeLastName,dataRecord)
	;	
	SET employeeQty=$$getEmployeeQty(employeeLastName,dataRecord)
	;	
	SET higherSalaryFound=(employeeSalaryValue'<lastNameMaxSalaryValue)
	;	
	SET:higherSalaryFound ok=$$update(employeeLastName,employeeSalaryValue,employeeQty)
	SET:'higherSalaryFound ok=$$update(employeeLastName,lastNameMaxSalaryValue,employeeQty)
	;	
	QUIT ok
	;
create(employeeLastName,salaryValue)
	;	
	SET employeeQty=1
	;	
	SET ^lastNameMax(employeeLastName)=salaryValue_$$SEP^constantClass_employeeQty
	;
	QUIT $$TRUE^constantClass
	;
update(employeeLastName,salaryValue,employeeQty)
	;
	SET employeeQty=employeeQty+1
	;
	SET ^lastNameMax(employeeLastName)=salaryValue_$$SEP^constantClass_employeeQty
	;	
	QUIT $$TRUE^constantClass
	;
getRecordPosition(propertyName)
	KILL recordPos
	SET recordPos("salaryValue")=1,recordPos("employeeQty")=2 
	;	
	QUIT recordPos(propertyName)
	;	
getPropertyValue(dataRecord,propertyName)
	;
	QUIT $PIECE(dataRecord,$$SEP^constantClass,$$getRecordPosition(propertyName))
	;
getSalaryValue(id,dataRecord)
	;	
	SET propertyName="salaryValue"
	;	
	QUIT:$D(dataRecord) $$getPropertyValue(dataRecord,propertyName)
	;	
	QUIT $$getPropertyValue(^lastNameMax(id),propertyName)
	;
getEmployeeQty(id,dataRecord)
	;	
	SET propertyName="employeeQty"
	;	
	QUIT:$D(dataRecord) $$getPropertyValue(dataRecord,propertyName)
	;	
	QUIT $$getPropertyValue(^lastNameMax(id),propertyName)
	;