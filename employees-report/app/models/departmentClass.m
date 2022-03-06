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
set(id,data)
	SET id=$$allTrim^helper(id)
	IF id="" QUIT $$FALSE^constantClass
	;
	SET data=$$removeBraces^helper(data)	
	SET deptName=$$allTrim^helper($$getDeptName(id,data))
	SET employeeQty=$$allTrim^helper($$getEmployeeQty(id,data))
	SET:employeeQty="" employeeQty=0
	SET ^departments(id)=deptName_$$SEP^constantClass_employeeQty
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
	SET recordPos("deptName")=1,recordPos("employeeQty")=2
	;	
	QUIT recordPos(propertyName)
	;	
getPropertyValue(dataRecord,propertyName)
	;
	QUIT $PIECE(dataRecord,$$SEP^constantClass,$$getRecordPosition(propertyName))
	;
get(id)
	;
	QUIT ^departments(id)
	;
incEmployeeQty(id)
	;
	KILL data
	KILL dataRecord
	IF id="" QUIT $$FALSE^constantClass
	SET dataRecord=$$get(id)
	SET deptName=$$getDeptName(-1,dataRecord)
	SET employeeQty=$$getEmployeeQty(-1,dataRecord)+1
	SET data=deptName_$$SEP^constantClass_employeeQty
	SET ok=$$update(id,data)
	QUIT ok
	;
getDeptName(id,dataRecord)
	;	
	SET propertyName="deptName"
	;	
	QUIT:$D(dataRecord) $$getPropertyValue(dataRecord,propertyName)
	;	
	QUIT $$getPropertyValue(^departments(id),propertyName)
	;
getEmployeeQty(id,dataRecord)
	;	
	SET propertyName="employeeQty"
	;	
	QUIT:$D(dataRecord) $$getPropertyValue(dataRecord,propertyName)
	;	
	QUIT $$getPropertyValue(^departments(id),propertyName)
	;	
delete(id)
	IF id="" QUIT $$FALSE^constantClass
	KILL ^departments(id)
	QUIT $$TRUE^constantClass
	;	