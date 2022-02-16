	; Employees' Statistics Report. ;
	;
	; File mame: employeesCalculate.m
	; Author: Sergio Lima (Feb, 9 2022)
	; How to run: mumps -r main^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;		
main(reportFileName)
	;
	SET employeeId=""
	SET generalId=0
	SET maxSal=0
	SET minSal=999999
	SET sumSal=0
	SET employeeCounter=0
	;	
	KILL ^Salary,^SalaryDept,^SalaryLastName
	;	
	FOR i=1:1 SET employeeId=$O(^employees(employeeId)) Q:employeeId=""  DO
	. ; Clean employees data
	. SET employeeData=$$removeBraces^helper(^employees(employeeId))
	. SET ok=$$update^employee(employeeId,employeeData)
	. ;
	. SET deptId=$$getEmployeeDeptId^employee(employeeId)
	. SET employeeLastName=$$getEmployeeLastName^employee(employeeId)	
	. SET salaryValue=$$getEmployeeSalaryValue^employee(employeeId)
	. ; Set main work globals
	. SET generalId=$Increment(generalId)
	. SET ^SalaryDept(deptId,employeeId,salaryValue)=""
	. SET ^Salary(salaryValue,generalId)=employeeId
	. SET ^SalaryLastName(employeeLastName,generalId,salaryValue)=employeeId_"^"_employeeData
	. ; Calculate global max & min salary 
	. SET maxSal=$$getMaxSalary^helper(salaryValue,maxSal)
	. SET minSal=$$getMinSalary^helper(salaryValue,minSal)
	. ; Calculate global average salary 
	. SET employeeCounter=$Increment(employeeCounter)
	. SET sumSal=sumSal+salaryValue
	;	
	DO main^employeesCalcGlobalSalary(reportFileName,maxSal,minSal,sumSal,employeeCounter)
	;			
	DO main^employeesCalcDeptSalary(reportFileName)
	;	
	QUIT
	;	