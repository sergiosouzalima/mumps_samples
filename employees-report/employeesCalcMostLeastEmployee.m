	; Employees' Statistics Report. ;
	;
	; File mame: employeesCalcMostLeastEmployee.m
	; Author: Sergio Lima (Feb, 16 2022)
	; How to run: mumps -r main^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;		
main(reportFileName)
	;
	KILL ^mostLeastEmployee
	;	
	DO generateMostLeastEmployee()
	;	
	SET fileName=reportFileName
	OPEN fileName:(append:stream:nowrap:chset="M")
	USE fileName
	;
	DO printMostEmployee()
	;
	DO printLeastEmployee()
	;
	CLOSE fileName
	QUIT	
	;	
generateMostLeastEmployee()
	; Read all Departments. Create list with departments with most and least employees
	;	
	; ^departments(id)=deptName^employeeQty
	;	
	; ^departments("SD")="Desenvolvimento de Software^6"	
	; ^departments("SM")="Gerenciamento de Software^2"
	; ^departments("UD")="Designer de UI/UX^3"
	;
	SET maxEmployeeQty=0
	SET minEmployeeQty=999999
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^departments(deptId)) Q:deptId=""  DO
	. SET employeeQty=$$getEmployeeQty^department(deptId)
	. IF employeeQty>0 DO
	. . ; Calculate max & min EmployeeQty by Department 
	. . SET maxEmployeeQty=$$getMaxValue^helper(employeeQty,maxEmployeeQty)
	. . SET minEmployeeQty=$$getMinValue^helper(employeeQty,minEmployeeQty)
	;
	; Read all Departments. Create list with departments with most and least employees
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^departments(deptId)) Q:deptId=""  DO
	. SET employeeQty=$$getEmployeeQty^department(deptId)
	. SET:employeeQty=maxEmployeeQty ^mostLeastEmployee("most_employees",deptId)=maxEmployeeQty
	. SET:employeeQty=minEmployeeQty ^mostLeastEmployee("least_employees",deptId)=minEmployeeQty
	;
	QUIT
	;
printMostLeastEmployee(maxMinEmployee)
	;
	; Read & print all ^mostLeastEmployee. ;
	;	
	; ^mostLeastEmployee("least_employees"/"most_employees",deptId)=maxMinEmployeeQty
	;	
	; ^mostLeastEmployee("least_employees","SM")=2
	; ^mostLeastEmployee("most_employees","SD")=6
	;
	;	
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^mostLeastEmployee(maxMinEmployee,deptId)) Q:deptId=""  DO
	. SET maxMinEmployeeQty=^mostLeastEmployee(maxMinEmployee,deptId)
	. DO writeMaxMinEmployeeToFile(maxMinEmployee,deptId,maxMinEmployeeQty)
	;
	QUIT	
	;
printMostEmployee()
	DO printMostLeastEmployee("most_employees")
	;
	QUIT	
	;	
printLeastEmployee()
	DO printMostLeastEmployee("least_employees")
	;
	QUIT	
	;	
writeMaxMinEmployeeToFile(maxMinEmployee,deptId,maxMinEmployeeQty)
	SET content=$$getContentToFile(deptId,maxMinEmployeeQty)
	DO writeToFile(maxMinEmployee,content)
	;	
	QUIT	
	;
getContentToFile(deptId,maxMinEmployeeQty)
	SET deptName=$$getDeptName^department(deptId)
	;	
	SET content=deptName_"|"_maxMinEmployeeQty
	;	
	QUIT content
	;
writeToFile(statisticsId,content)
	WRITE statisticsId_"|"_content,!
	;
	QUIT	
	;