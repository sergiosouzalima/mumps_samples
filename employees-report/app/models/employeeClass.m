	; Employees' Statistics Report. ;
	;
	; File mame: employeeClass.m
	; Author: Sergio Lima (Feb, 12 2022)
	; How to run: mumps -r ^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;
	; ^employees(id)="employeeFirstName^employeeLastName^salaryValue^deptId"
	;
	; ^employees(1)="Washington^Ramos^2700.00^SD"
	; ^employees(2)="Wilson^Silva^3200.00^SM"
	;	
set(id,data)
	IF id="" QUIT $$FALSE^constantClass
	;	
	SET employeeName=$$getEmployeeFirstName(id,data)
	SET employeeLastName=$$getEmployeeLastName(id,data)
	SET:employeeLastName="" employeeLastName="-1"
	SET salaryValue=$$getEmployeeSalaryValue(id,data)
	SET deptId=$$getEmployeeDeptId(id,data)
	SET ^employees(id)=employeeName_$$SEP^constantClass_employeeLastName_$$SEP^constantClass_salaryValue_$$SEP^constantClass_deptId
	;	
	QUIT $$TRUE^constantClass
	;
create(id,data)
	;
	QUIT $$set(id,data)
	;
update(id,data)
	;
	QUIT $$set(id,data)
	;
getRecordPosition(propertyName)
	KILL recordPos
	SET recordPos("employeeFirstName")=1,recordPos("employeeLastName")=2
	SET recordPos("salaryValue")=3,recordPos("deptId")=4
	;	
	QUIT recordPos(propertyName)
	;	
getPropertyValue(dataRecord,propertyName)
	;
	QUIT $PIECE(dataRecord,$$SEP^constantClass,$$getRecordPosition(propertyName))
	;
getEmployeeFirstName(id,dataRecord)
	;
	SET propertyName="employeeFirstName"
	;	
	QUIT:$D(dataRecord) $$getPropertyValue(dataRecord,propertyName)
	;	
	QUIT $$getPropertyValue(^employees(id),propertyName)
	;
getEmployeeLastName(id,dataRecord)
	;
	SET propertyName="employeeLastName"
	;	
	QUIT:$D(dataRecord) $$getPropertyValue(dataRecord,propertyName)
	;	
	QUIT $$getPropertyValue(^employees(id),propertyName)
	;
getEmployeeFullName(id,dataRecord)
	;
	QUIT:'$D(dataRecord) $$getEmployeeFirstName(id)_" "_$$getEmployeeLastName(id)
	;	
	QUIT $$getEmployeeFirstName(id,dataRecord)_" "_$$getEmployeeLastName(id,dataRecord)
	;
getEmployeeDeptId(id,dataRecord)
	;	
	SET propertyName="deptId"
	;	
	QUIT:$D(dataRecord) $$getPropertyValue(dataRecord,propertyName)
	;	
	QUIT $$getPropertyValue(^employees(id),propertyName)
	;
getEmployeeSalaryValue(id,dataRecord)
	;	
	SET propertyName="salaryValue"
	;	
	QUIT:$D(dataRecord) $$getPropertyValue(dataRecord,propertyName)
	;	
	QUIT $$getPropertyValue(^employees(id),propertyName)
	;
getEmployeeDeptName(id)
	;
	SET deptId=$$getEmployeeDeptId(id)
	QUIT $$getDeptName^departmentClass(deptId)
	;
delete(id)
	IF id="" QUIT $$FALSE^constantClass
	KILL ^employees(id)
	QUIT $$TRUE^constantClass