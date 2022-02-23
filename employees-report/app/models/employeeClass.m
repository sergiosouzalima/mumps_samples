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
	;		
	SET SEP="^"
	SET TRUE=1,FALSE=0
	;	
set(id,data)
	IF id="" QUIT FALSE
	SET employeeName=$piece(data,SEP,1)
	SET employeeLastName=$piece(data,SEP,2)
	SET:employeeLastName="" employeeLastName="-1"
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
getRecordPosition(propertyName)
	KILL recordPos
	SET recordPos("employeeFirstName")=1,recordPos("employeeLastName")=2
	SET recordPos("salaryValue")=3,recordPos("deptId")=4
	;	
	QUIT recordPos(propertyName)
	;	
getPropertyValue(dataRecord,propertyName)
	;
	QUIT $PIECE(dataRecord,SEP,$$getRecordPosition(propertyName))
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
	IF id="" QUIT FALSE
	KILL ^employees(id)
	QUIT TRUE