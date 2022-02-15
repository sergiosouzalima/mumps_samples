	; Employees' Statistics Report. ;
	;
	; File mame: employeesCalcDeptSalary.m
	; Author: Sergio Lima (Feb, 15 2022)
	; How to run: mumps -r main^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;		
main(reportFileName)
	;
	; ^SalaryDept(deptId,generalId,employeeSalary)=employeeId
	; ^SalaryDept("SD",3,"2450.00")=2
	; ^SalaryDept("SD",5,"2750.00")=4
	; ^SalaryDept("SD",6,"2550.00")=5
	; ^SalaryDept("SD",8,"2450.00")=7
	; ^SalaryDept("SD",10,"2750.00")=9
	; ^SalaryDept("SD",11,"2500.00")=10
	; ^SalaryDept("SM",1,"3200.00")=0
	; ^SalaryDept("SM",4,"3700.00")=3
	; ^SalaryDept("UD",2,"2700.00")=1
	; ^SalaryDept("UD",7,"2450.00")=6
	; ^SalaryDept("UD",9,"2550.00")=8
	;	
	; ^SalaryDeptAvg(deptId)=avgEmployeeSalary
	; ^SalaryDeptAvg("SD")="2.575,00"
	; ^SalaryDeptAvg("SM")="3.450,00"
	; ^SalaryDeptAvg("UD")="2.566,67"
	;	
	; ^SalaryDeptMaxMin(deptId,generalId,maxEmployeeSalary)=employeeId
	; ^SalaryDeptMaxMin(deptId,generalId,minEmployeeSalary)=employeeId
	;
	KILL ^SalaryDeptAvg,^SalaryDeptMaxMin
	;	
	DO generateSalaryDeptAvg()
	;	
	; Read all Departments. Get Max & Min Salaries by Department. ;
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^departments(deptId)) Q:deptId=""  DO
	. SET maxSal=0
	. SET minSal=999999
	. SET generalId=""
	. FOR j=1:1 SET generalId=$O(^SalaryDept(deptId,generalId)) Q:generalId=""  DO
	. . SET salaryValue=""
	. . FOR k=1:1 SET salaryValue=$O(^SalaryDept(deptId,generalId,salaryValue)) Q:salaryValue=""  DO
	. . . ; Calcule max & min salary by department
	. . . SET maxSal=$$getMaxSalary^helper(salaryValue,maxSal)
	. . . SET minSal=$$getMinSalary^helper(salaryValue,minSal)
	. . . SET employeeId=^SalaryDept(deptId,generalId,salaryValue)
	. . SET ^SalaryDeptMaxMin(deptId,"maxSal")=maxSal
	. . SET ^SalaryDeptMaxMin(deptId,"minSal")=minSal
	;
	;SET deptId=""
	;FOR i=1:1 SET deptId=$O(^departments(deptId)) Q:deptId=""  DO
	;. SET salaryValue=""
	;. SET maxSal=0
	;. SET minSal=999999
	;. FOR j=1:1 SET salaryValue=$O(^SalaryDept(deptId,salaryValue)) Q:salaryValue=""  DO
	;. . ; Calcule max & min salary by department
	;. . SET maxSal=$$getMaxSalary^helper(salaryValue,maxSal)
	;. . SET minSal=$$getMinSalary^helper(salaryValue,minSal)
	;. SET salaryValue=""
	;. FOR j=1:1 SET salaryValue=$O(^SalaryDept(deptId,salaryValue)) Q:salaryValue=""  DO
	;. . SET generalId=""
	;. . FOR k=1:1 SET generalId=$O(^SalaryDept(deptId,salaryValue,generalId)) Q:generalId=""  DO
	;. . . SET employeeId=^SalaryDept(deptId,salaryValue,generalId)
	;. . . IF (salaryValue=maxSal)!(salaryValue=minSal)  SET ^SalaryDeptResult(deptId,salaryValue,generalId)=employeeId
	;
	;	
	; Get avg salaries by department. ;
	; SET ^SalaryDept(deptId)=$$formatCurrency^helper(sumSal/employeeCounter)
	; Generate list with max & min salaries. ;
	;	
	; Read all Department Results. Get avg salary by department
	;SET deptId=""
	;FOR i=1:1 SET deptId=$O(^SalaryDeptResult(deptId)) Q:deptId=""  DO
	;. SET salaryValue=""
	;. SET sumSal=0
	;. SET employeeCounter=0
	;. FOR j=1:1 SET salaryValue=$O(^SalaryDeptResult(deptId,salaryValue)) Q:salaryValue=""  DO
	;. . SET sumSal=sumSal+salaryValue
	;. . SET employeeCounter=employeeCounter+1
	;. SET ^SalaryDeptResult(deptId)=sumSal/employeeCounter
	;	 	
	;	 	 	 	
	SET fileName=reportFileName
	OPEN fileName:(append:stream:nowrap:chset="M")
	USE fileName
	;
	CLOSE fileName
	QUIT
	;	
generateSalaryDeptAvg()
	; Read all Departments. Get avg salaries by department. ;
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^departments(deptId)) Q:deptId=""  DO
	. SET generalId=""
	. SET sumSal=0
	. SET employeeCounter=0
	. FOR j=1:1 SET generalId=$O(^SalaryDept(deptId,generalId)) Q:generalId=""  DO
	. . SET salaryValue=""
	. . FOR k=1:1 SET salaryValue=$O(^SalaryDept(deptId,generalId,salaryValue)) Q:salaryValue=""  DO
	. . . SET sumSal=sumSal+salaryValue
	. . . SET employeeCounter=employeeCounter+1
	. . . SET:employeeCounter>0 ^SalaryDeptAvg(deptId)=$$formatCurrency^helper(sumSal/employeeCounter)
	;	
	QUIT	
	;
writeGlobalMaxToFile(employeeId)
	DO writeToFile("global_max",$$getContentToFile(employeeId))
	;	
	QUIT	
	;
writeGlobalMinToFile(employeeId)
	DO writeToFile("global_min",$$getContentToFile(employeeId))
	;	
	QUIT	
	;
writeGlobalAvgToFile(globalAvg)
	DO writeToFile("global_avg",$$formatCurrency^helper(globalAvg))
	;	
	QUIT	
	;
getContentToFile(employeeId)
	SET employeeFullName=$$getEmployeeFullName^employee(employeeId)
	SET salary=$$formatCurrency^helper($$getEmployeeSalaryValue^employee(employeeId))
	SET content=employeeFullName_"|"_salary
	;	
	QUIT content
	;
writeToFile(statisticsId,content)
	WRITE statisticsId_"|"_content,!
	;
	QUIT	
	;