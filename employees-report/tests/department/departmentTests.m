	; Employees' Statistics Report. ;
	;
	; File mame: departmentTests.m
	; Author: Sergio Lima (Feb, 14 2022)
	; How to run: mumps -r main^departmentTests
	;
	; Made with GT.M Mumps for Linux. ;
	;	
main()
	;
	DO setup()
	;	
	DO create("SD","Software Development")
	DO create("SM","Software Managment")
	DO update("SM","Software Managment Project") 
	DO get("SD")
	DO delete("SD")
	DO getProp("SM","deptName")
	DO getDeptName("SM")
	DO getEmployeeQty("SM")
	DO incEmployeeQty("SM")
	;	
	DO tearDown()
	QUIT
	;
setup()
	;
	SET CLASSNAME="Department"
	SET testCounter=0
	KILL ^departments
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
	SET operationName="Create"
	SET ok=$$create^department(id,content)
	DO showResult(operationName,ok,id,^departments(id))
	;
	QUIT
	;	
get(id)
	;
	SET operationName="get"
	SET ok=$$get^department(id,.data)
	DO showResult(operationName,ok,id,^departments(id))
	;
	QUIT
	;	
update(id,content) 
	;
	SET operationName="Update"
	SET ok=$$update^department(id,content)
	DO showResult(operationName,ok,id,^departments(id))
	;	
	QUIT
	;
delete(id)
	;
	SET operationName="Delete"
	SET ok=$$delete^department(id)
	DO showResult(operationName,ok,id,"")
	;	
	QUIT
	;
getProp(id,propertyName)
	;
	SET operationName="get by Property"
	SET content=$$getProp^department(id,propertyName)
	SET ok=("Software Managment Project"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getDeptName(id)
	;
	SET operationName="get by Dept Name Property"
	SET content=$$getDeptName^department(id)
	SET ok=("Software Managment Project"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
getEmployeeQty(id)
	;
	SET operationName="get by Employee Qty Property"
	SET content=$$getEmployeeQty^department(id)
	SET ok=("0"=content)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
incEmployeeQty(id)
	;
	SET operationName="increment EmployeeQty Property to Department"
	SET ok=$$incEmployeeQty^department(id)
	DO showResult(operationName,ok,id,"")
	;	
	QUIT
	;