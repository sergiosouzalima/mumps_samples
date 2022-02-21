	; Employees' Statistics Report. ;
	;
	; File mame: employeeTests.m
	; Author: Sergio Lima (Feb, 14 2022)
	; How to run: mumps -r main^employeeTests
	;
	; Made with GT.M Mumps for Linux. ;
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
	DO getProp(2,"employeeFirstName")
	DO getEmployeeFirstName(2)
	DO getEmployeeLastName(2)
	DO getEmployeeDeptId(2)
	DO getEmployeeDeptName(2)
	DO getEmployeeSalaryValue(2)
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
	SET ok=$$create^employeeClass(id,content)
	DO showResult(operationName,ok,id,^employees(id))
	;
	QUIT
	;	
get(id)
	;
	SET operationName="get"
	SET ok=$$get^employeeClass(id,.data)
	DO showResult(operationName,ok,id,^employees(id))
	;
	QUIT
	;	
update(id,content) 
	;
	SET operationName="Update"
	SET ok=$$update^employeeClass(id,content)
	DO showResult(operationName,ok,id,^employees(id))
	;	
	QUIT
	;
delete(id)
	;
	SET operationName="Delete"
	SET ok=$$delete^employeeClass(id)
	DO showResult(operationName,ok,id,"")
	;	
	QUIT
	;
getProp(id,propertyName)
	;
	SET operationName="get by Property"
	SET content=$$getProp^employeeClass(id,propertyName)
	SET ok=("Williams"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getEmployeeFirstName(id)
	;
	SET operationName="get by First Name Property"
	SET content=$$getEmployeeFirstName^employeeClass(id)
	SET ok=("Williams"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getEmployeeLastName(id)
	;
	SET operationName="get by Last Name Property"
	SET content=$$getEmployeeLastName^employeeClass(id)
	SET ok=("Akron"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getEmployeeDeptId(id)
	;
	SET operationName="get by DeptId Property"
	SET content=$$getEmployeeDeptId^employeeClass(id)
	SET ok=("SD"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getEmployeeDeptName(id)
	;
	SET operationName="get by Department Name Property"
	;	
	SET ok=$$create^department("SD","Software Development")
	;	
	SET content=$$getEmployeeDeptName^employeeClass(id)
	SET ok=("Software Development"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getEmployeeSalaryValue(id)
	;
	SET operationName="get by Employee Salary Value Property"
	SET content=$$getEmployeeSalaryValue^employeeClass(id)
	SET ok=("2700.00"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT