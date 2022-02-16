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
	DO generateSalaryDeptMaxMin()
	;	
	DO updateSalaryDept()
	;
	SET fileName=reportFileName
	OPEN fileName:(append:stream:nowrap:chset="M")
	USE fileName
	;
	DO printDeptSalary
	;	 
	CLOSE fileName
	QUIT
	;	
generateSalaryDeptAvg()
	; Read all Departments. Create list by department, employee and their salaries ;
	;	
	; ^SalaryDept(deptId,employeeId,salaryValue)=""
	; ^SalaryDept("SD",2,"2450.00")=""
	; ^SalaryDept("SD",4,"2750.00")=""
	; ^SalaryDept("SD",5,"2550.00")=""
	;
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^departments(deptId)) Q:deptId=""  DO
	. SET employeeId=""
	. SET sumSal=0
	. SET employeeCounter=0
	. FOR j=1:1 SET employeeId=$O(^SalaryDept(deptId,employeeId)) Q:employeeId=""  DO
	. . SET salaryValue=""
	. . FOR k=1:1 SET salaryValue=$O(^SalaryDept(deptId,employeeId,salaryValue)) Q:salaryValue=""  DO
	. . . SET sumSal=sumSal+salaryValue
	. . . SET employeeCounter=employeeCounter+1
	. . . SET:employeeCounter>0 ^SalaryDeptAvg(deptId)=$$formatCurrency^helper(sumSal/employeeCounter)
	;	
	QUIT	
	;
generateSalaryDeptMaxMin()
	;	
	; Read all Departments. Create list with Max & Min employees' salaries by department. ;
	; ^SalaryDeptAvg("SD")="2.575,00"
	; ^SalaryDeptAvg("SM")="3.450,00"
	; ^SalaryDeptAvg("UD")="2.566,67"
	;
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^departments(deptId)) Q:deptId=""  DO
	. SET maxSal=0
	. SET minSal=999999
	. SET employeeId=""
	. FOR j=1:1 SET employeeId=$O(^SalaryDept(deptId,employeeId)) Q:employeeId=""  DO
	. . SET salaryValue=""
	. . FOR k=1:1 SET salaryValue=$O(^SalaryDept(deptId,employeeId,salaryValue)) Q:salaryValue=""  DO
	. . . ; Calcule max & min salary by department
	. . . SET maxSal=$$getMaxValue^helper(salaryValue,maxSal)
	. . . SET minSal=$$getMinValue^helper(salaryValue,minSal)
	. . SET ^SalaryDeptMaxMin(deptId,maxSal)="area_max"
	. . SET ^SalaryDeptMaxMin(deptId,minSal)="area_min"
	;	
	QUIT	
	;
updateSalaryDept()
	;
	; Read all ^SalaryDept. Update ^SalaryDept when deptId + salaryValue is in ^SalaryDeptMaxMin
	;
	; ^SalaryDept("SD",2,"2450.00")=""
	; ^SalaryDept("SD",4,"2750.00")=""
	; ^SalaryDept("SD",5,"2550.00")=""
	; ^SalaryDept("SD",7,"2450.00")=""
	; ^SalaryDept("SD",9,"2750.00")=""
	; ^SalaryDept("SD",10,"2500.00")=""
	; ^SalaryDept("SM",0,"3200.00")=""
	; ^SalaryDept("SM",3,"3700.00")=""
	; ^SalaryDept("UD",1,"2700.00")=""
	; ^SalaryDept("UD",6,"2450.00")=""
	; ^SalaryDept("UD",8,"2550.00")=""
	; ^SalaryDeptMaxMin("SD","2450.00")="minSal"
	; ^SalaryDeptMaxMin("SD","2750.00")="maxSal"
	; ^SalaryDeptMaxMin("SM","3200.00")="minSal"
	; ^SalaryDeptMaxMin("SM","3700.00")="maxSal"
	; ^SalaryDeptMaxMin("UD","2450.00")="minSal"
	; ^SalaryDeptMaxMin("UD","2700.00")="maxSal"
	;	
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^SalaryDept(deptId)) Q:deptId=""  DO
	. SET employeeId=""
	. FOR j=1:1 SET employeeId=$O(^SalaryDept(deptId,employeeId)) Q:employeeId=""  DO
	. . SET salaryValue=""
	. . FOR k=1:1 SET salaryValue=$O(^SalaryDept(deptId,employeeId,salaryValue)) Q:salaryValue=""  DO
	. . . SET exists=$D(^SalaryDeptMaxMin(deptId,salaryValue))
	. . . SET:exists ^SalaryDept(deptId,employeeId,salaryValue)=^SalaryDeptMaxMin(deptId,salaryValue)
	;	
	QUIT	
	;
printDeptSalary()
	;
	; Read all ^SalaryDept. Print record when content is ""
	;	
	; ^SalaryDept("SD",2,"2450.00")="minSal"
	; ^SalaryDept("SD",4,"2750.00")="maxSal"
	; ^SalaryDept("SD",5,"2550.00")=""
	; ^SalaryDept("SD",7,"2450.00")="minSal"
	; ^SalaryDept("SD",9,"2750.00")="maxSal"
	; ^SalaryDept("SD",10,"2500.00")=""
	; ^SalaryDept("SM",0,"3200.00")="minSal"
	; ^SalaryDept("SM",3,"3700.00")="maxSal"
	; ^SalaryDept("UD",1,"2700.00")="maxSal"
	; ^SalaryDept("UD",6,"2450.00")="minSal"
	; ^SalaryDept("UD",8,"2550.00")=""
	;	
	; ^SalaryDeptAvg("SD")="2.575,00"
	; ^SalaryDeptAvg("SM")="3.450,00"
	; ^SalaryDeptAvg("UD")="2.566,67"
	;
	;	
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^SalaryDept(deptId)) Q:deptId=""  DO
	. SET employeeId=""
	. FOR j=1:1 SET employeeId=$O(^SalaryDept(deptId,employeeId)) Q:employeeId=""  DO
	. . SET salaryValue=""
	. . FOR k=1:1 SET salaryValue=$O(^SalaryDept(deptId,employeeId,salaryValue)) Q:salaryValue=""  DO
	. . . SET minMaxArea=^SalaryDept(deptId,employeeId,salaryValue)
	. . . IF minMaxArea'=""  DO
	. . . . DO writeSalaryMinMaxToFile(minMaxArea,deptId,employeeId,salaryValue)
	. DO writeSalaryAvgToFile(deptId)	
	;	
	QUIT	
	;
writeSalaryMinMaxToFile(minMaxArea,deptId,employeeId,salaryValue)
	SET content=$$getContentToFile(deptId,employeeId,salaryValue)
	DO writeToFile(minMaxArea,content)
	;	
	QUIT	
	;
writeSalaryAvgToFile(deptId)
	SET salaryValue=^SalaryDeptAvg(deptId)
	SET deptName=$$getDeptName^department(deptId)
	SET content=deptName_"|"_salaryValue
	DO writeToFile("area_avg",content)
	;	
	QUIT	
	;
getContentToFile(deptId,employeeId,salaryValue)
	SET deptName=$$getDeptName^department(deptId)
	SET employeeFullName=$$getEmployeeFullName^employee(employeeId)
	SET salaryValueFormat=$$formatCurrency^helper(salaryValue)
	;	
	SET content=deptName_"|"_employeeFullName_"|"_salaryValueFormat
	;	
	QUIT content
	;
writeToFile(statisticsId,content)
	WRITE statisticsId_"|"_content,!
	;
	QUIT	
	;