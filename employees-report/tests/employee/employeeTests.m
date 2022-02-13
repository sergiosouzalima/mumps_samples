	;
	zlink "../../app/models/database"
	zlink "../../app/models/employee"
	;	
main()
	;
	DO setup()
	;	
	DO create(1,"Washington^Ramos^2700.00^SD")
	DO create(2,"Wilson^Silva^3200.00^SM")
	DO update(2,"Williams^Akron^2700.00^SD") 
	DO get(1)
	DO delete(1)
	DO getProp(2,"employeeName")
	DO getEmployeeName(2)
	DO getEmployeeLastName(2)
	DO getEmployeeDeptId(2)
	DO getEmployeeDeptName(2)
	;	
	DO tearDown()
	QUIT
	;
setup()
	;
	SET SEP="^"
	SET TRUE=1,FALSE=0
	SET CLASSNAME="Employee"
	SET testCounter=0
	KILL ^employees
	;
	QUIT
	;
tearDown()
	;
	KILL SEP
	KILL TRUE,FALSE
	KILL CLASSNAME
	KILL testCounter
	WRITE !,"*** END RUN",!
	;	
	QUIT
	;
showResult(operationName,ok,id,content)
	;
	SET failMessage="Operation failed."
	SET successMessage="Operation successfull."
	;	
	WRITE $increment(testCounter)_") "_CLASSNAME_" "_operationName_" ==> "
	IF ok WRITE successMessage
	IF 'ok WRITE failMessage
	WRITE !
	ZWRITE id,content
	WRITE !
	;	
	QUIT
	;	
create(id,content)
	;
	; ^employees(1)="Washington^Ramos^2700.00^SD"
	;
	SET operationName="Create"
	SET ok=$$create^employee(id,content)
	DO showResult(operationName,ok,id,^employees(id))
	;
	QUIT
	;	
get(id)
	;
	SET operationName="get"
	SET ok=$$get^employee(id,.data)
	DO showResult(operationName,ok,id,^employees(id))
	;
	QUIT
	;	
update(id,content) 
	;
	SET operationName="Update"
	SET ok=$$update^employee(id,content)
	DO showResult(operationName,ok,id,^employees(id))
	;	
	QUIT
	;
delete(id)
	;
	SET operationName="Delete"
	SET ok=$$delete^employee(id)
	DO showResult(operationName,ok,id,"")
	;	
	QUIT
	;
getProp(id,propertyName)
	;
	SET operationName="get by Property"
	SET content=$$getProp^employee(id,propertyName)
	SET ok=("Williams"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getEmployeeName(id)
	;
	SET operationName="get by Name Property"
	SET content=$$getEmployeeName^employee(id)
	SET ok=("Williams"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getEmployeeLastName(id)
	;
	SET operationName="get by Last Name Property"
	SET content=$$getEmployeeLastName^employee(id)
	SET ok=("Akron"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getEmployeeDeptId(id)
	;
	SET operationName="get by DeptId Property"
	SET content=$$getEmployeeDeptId^employee(id)
	SET ok=("SD"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getEmployeeDeptName(id)
	;
	SET operationName="get by deptName Property"
	;	
	SET ok=$$create^department("SD","Software Development")
	;	
	SET content=$$getEmployeeDeptName^employee(id)
	SET ok=("Software Development"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;