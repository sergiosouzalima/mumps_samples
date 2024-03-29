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
	DO delete(1)
	DO getEmployeeFirstName(2)
	DO getEmployeeFirstNameFromDataRecord(0,"Will^Ramos^2700.00^SD")
	DO getEmployeeLastName(2)
	DO getEmployeeLastNameFromDataRecord(0,"Williams^Mackenzie^2700.00^SD")
	DO getEmployeeFullName(2)
	DO getEmployeeFullNameFromDataRecord(0,"Williams^Mackenzie^2700.00^SD")
	DO getEmployeeDeptId(2)
	DO getEmployeeDeptIdFromDataRecord(0,"Williams^Mackenzie^2700.00^SD")
	DO getEmployeeDeptName(2)
	DO getEmployeeSalaryValue(2)
	DO getEmployeeSalaryValueFromDataRecord(0,"Williams^Mackenzie^2700.00^SD")
	;	
	DO tearDown()
	QUIT
	;
setup()
	;
	SET CLASSNAME="Employee"
	SET testCounter=0
	KILL ^employees
	;
	QUIT
	;
tearDown()
	;
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
getEmployeeFirstName(id)
	;
	SET operationName="get by First Name Property"
	SET content=$$getEmployeeFirstName^employeeClass(id)
	SET ok=("Williams"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getEmployeeFirstNameFromDataRecord(id,dataRecord)
	;
	SET operationName="get by First Name Property From Data Record"
	SET content=$$getEmployeeFirstName^employeeClass(id,dataRecord)
	SET ok=("Will"=content)
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
getEmployeeLastNameFromDataRecord(id,dataRecord)
	;
	SET operationName="get by Last Name Property From Data Record"
	SET content=$$getEmployeeLastName^employeeClass(id,dataRecord)
	SET ok=("Mackenzie"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;	
getEmployeeFullName(id)
	;
	SET operationName="get by Full Name Property"
	SET content=$$getEmployeeFullName^employeeClass(id)
	SET ok=("Williams Akron"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;	
getEmployeeFullNameFromDataRecord(id,dataRecord)
	;
	SET operationName="get by Full Name Property From Data Record"
	SET content=$$getEmployeeFullName^employeeClass(id,dataRecord)
	SET ok=("Williams Mackenzie"=content)
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
getEmployeeDeptIdFromDataRecord(id,dataRecord)
	;
	SET operationName="get by DeptId Property From Data Record"
	SET content=$$getEmployeeDeptId^employeeClass(id,dataRecord)
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
	;	
getEmployeeSalaryValueFromDataRecord(id,dataRecord)
	;
	SET operationName="get by Employee Salary Value Property From Data Record"
	SET content=$$getEmployeeSalaryValue^employeeClass(id,dataRecord)
	SET ok=("2700.00"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;