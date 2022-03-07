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
	; ^salaryDeptAvg(deptId)=avgEmployeeSalary
	; ^salaryDeptAvg("SD")="2.575,00"
	; ^salaryDeptAvg("SM")="3.450,00"
	; ^salaryDeptAvg("UD")="2.566,67"
	;	
	; ^salaryDeptMaxMin(deptId,generalId,maxEmployeeSalary)=employeeId
	; ^salaryDeptMaxMin(deptId,generalId,minEmployeeSalary)=employeeId
	;	
	KILL ^salaryDeptAvg,^salaryDeptMaxMin
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
	;	
	QUIT
	;	
generateSalaryDeptAvg()
	; Read all Departments. Create list by department, employee and their salaries ;
	;	
	; ^salaryDept(deptId,employeeId,salaryValue)=""
	; ^salaryDept("SD",2,"2450.00")=""
	; ^salaryDept("SD",4,"2750.00")=""
	; ^salaryDept("SD",5,"2550.00")=""
	;
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^departments(deptId)) Q:deptId=""  DO
	. SET employeeId=""
	. SET sumSal=0
	. SET employeeCounter=0
	. FOR j=1:1 SET employeeId=$O(^salaryDept(deptId,employeeId)) Q:employeeId=""  DO
	. . SET salaryValue=""
	. . FOR k=1:1 SET salaryValue=$O(^salaryDept(deptId,employeeId,salaryValue)) Q:salaryValue=""  DO
	. . . SET sumSal=sumSal+salaryValue
	. . . SET employeeCounter=employeeCounter+1
	. . . SET:employeeCounter>0 ^salaryDeptAvg(deptId)=sumSal/employeeCounter
	;	
	QUIT	
	;
generateSalaryDeptMaxMin()
	;	
	; Read all Departments. Create list with Max & Min employees' salaries by department. ;
	;	
	; ^salaryDept(deptId,employeeId,salaryValue)
	; ^salaryDept("A2",9959,93512.41)=""
	; ^salaryDept("A2",9972,33557.67)=""
	; ^salaryDept("A2",9985,28209.92)=""
	; ^salaryDept("A2",9998,"40740.60")=""
	;
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^departments(deptId)) Q:deptId=""  DO
	. SET maxSal=0
	. SET minSal=999999
	. SET employeeId=""
	. FOR j=1:1 SET employeeId=$O(^salaryDept(deptId,employeeId)) Q:employeeId=""  DO
	. . SET salaryValue=""
	. . FOR k=1:1 SET salaryValue=$O(^salaryDept(deptId,employeeId,salaryValue)) Q:salaryValue=""  DO
	. . . ; Calcule max & min salary by department
	. . . SET maxSal=$$getMaxValue^helper(salaryValue,maxSal)
	. . . SET minSal=$$getMinValue^helper(salaryValue,minSal)
	. SET ^salaryDeptMaxMin(deptId,maxSal)="area_max"
	. SET ^salaryDeptMaxMin(deptId,minSal)="area_min"
	;	
	QUIT	
	;
updateSalaryDept()
	;
	; Read all ^salaryDept. Update ^salaryDept when deptId + salaryValue is in ^salaryDeptMaxMin
	;
	; ^salaryDept("SD",2,"2450.00")=""
	; ^salaryDept("SD",4,"2750.00")=""
	; ^salaryDept("SD",5,"2550.00")=""
	; ^salaryDept("SD",7,"2450.00")=""
	; ^salaryDept("SD",9,"2750.00")=""
	; ^salaryDept("SD",10,"2500.00")=""
	; ^salaryDept("SM",0,"3200.00")=""
	; ^salaryDept("SM",3,"3700.00")=""
	; ^salaryDept("UD",1,"2700.00")=""
	; ^salaryDept("UD",6,"2450.00")=""
	; ^salaryDept("UD",8,"2550.00")=""
	; ^salaryDeptMaxMin("SD","2450.00")="minSal"
	; ^salaryDeptMaxMin("SD","2750.00")="maxSal"
	; ^salaryDeptMaxMin("SM","3200.00")="minSal"
	; ^salaryDeptMaxMin("SM","3700.00")="maxSal"
	; ^salaryDeptMaxMin("UD","2450.00")="minSal"
	; ^salaryDeptMaxMin("UD","2700.00")="maxSal"
	;	
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^salaryDept(deptId)) Q:deptId=""  DO
	. SET employeeId=""
	. FOR j=1:1 SET employeeId=$O(^salaryDept(deptId,employeeId)) Q:employeeId=""  DO
	. . SET salaryValue=""
	. . FOR k=1:1 SET salaryValue=$O(^salaryDept(deptId,employeeId,salaryValue)) Q:salaryValue=""  DO
	. . . SET exists=$D(^salaryDeptMaxMin(deptId,salaryValue))
	. . . SET:exists ^salaryDept(deptId,employeeId,salaryValue)=^salaryDeptMaxMin(deptId,salaryValue)
	;	
	QUIT	
	;
printDeptSalary()
	;
	; Read all ^salaryDept. Print record when content is ""
	;	
	; ^salaryDept("SD",2,"2450.00")="minSal"
	; ^salaryDept("SD",4,"2750.00")="maxSal"
	; ^salaryDept("SD",5,"2550.00")=""
	; ^salaryDept("SD",7,"2450.00")="minSal"
	; ^salaryDept("SD",9,"2750.00")="maxSal"
	; ^salaryDept("SD",10,"2500.00")=""
	; ^salaryDept("SM",0,"3200.00")="minSal"
	; ^salaryDept("SM",3,"3700.00")="maxSal"
	; ^salaryDept("UD",1,"2700.00")="maxSal"
	; ^salaryDept("UD",6,"2450.00")="minSal"
	; ^salaryDept("UD",8,"2550.00")=""
	;	
	; ^salaryDeptAvg("SD")="2.575,00"
	; ^salaryDeptAvg("SM")="3.450,00"
	; ^salaryDeptAvg("UD")="2.566,67"
	;
	;	
	SET deptId=""
	FOR i=1:1 SET deptId=$O(^salaryDept(deptId)) Q:deptId=""  DO
	. SET employeeId=""
	. FOR j=1:1 SET employeeId=$O(^salaryDept(deptId,employeeId)) Q:employeeId=""  DO
	. . SET salaryValue=""
	. . FOR k=1:1 SET salaryValue=$O(^salaryDept(deptId,employeeId,salaryValue)) Q:salaryValue=""  DO
	. . . SET minMaxArea=^salaryDept(deptId,employeeId,salaryValue)
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
	SET salaryValue=$$formatDecimal^helper(^salaryDeptAvg(deptId))
	SET deptName=$$getDeptName^departmentClass(deptId)
	SET content=deptName_"|"_salaryValue
	DO writeToFile("area_avg",content)
	;	
	QUIT	
	;
getContentToFile(deptId,employeeId,salaryValue)
	SET deptName=$$getDeptName^departmentClass(deptId)
	SET employeeFullName=$$plusToDashReplace^helper($$getEmployeeFullName^employeeClass(employeeId))
	SET salaryValueFormat=$$formatDecimal^helper(salaryValue)
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