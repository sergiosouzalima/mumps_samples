	; Employees' Statistics Report. ;
	;
	; File mame: employeesCalcGlobalSalary.m
	; Author: Sergio Lima (Feb, 15 2022)
	; How to run: mumps -r main^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;		
main(reportFileName,maxSal,minSal,sumSal,employeeCounter)
	;
	; ^salary(salaryValue,generalId)=employeeId
	;	
	; ^salary("2450.00",3)="2"
	; ^salary("2450.00",7)="6"
	; ... ;
	; ^salary("3200.00",1)="0"
	; ^salary("3700.00",4)="3"
	;	
	SET fileName=reportFileName
	OPEN fileName:(newversion:stream:nowrap:chset="M")
	USE fileName
	;	
	; Get max salary
	SET generalId=""
	FOR i=1:1 SET generalId=$O(^salary(maxSal,generalId)) Q:generalId=""  DO
	. SET employeeId=^salary(maxSal,generalId)
	. DO writeGlobalMaxToFile(employeeId)
	;	
	; Get min salary
	SET generalId=""
	FOR i=1:1 SET generalId=$O(^salary(minSal,generalId)) Q:generalId=""  DO
	. SET employeeId=^salary(minSal,generalId)
	. DO writeGlobalMinToFile(employeeId)
	;
	; Get avg salary
	SET globalAvg=0
	SET:employeeCounter>0 globalAvg=$$formatDecimal^helper(sumSal/employeeCounter)
	DO writeGlobalAvgToFile(globalAvg)
	;
	CLOSE fileName
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
	DO writeToFile("global_avg",globalAvg)
	;	
	QUIT	
	;
getContentToFile(employeeId)
	SET employeeFullName=$$getEmployeeFullName^employeeClass(employeeId)
	SET salary=$$formatDecimal^helper($$getEmployeeSalaryValue^employeeClass(employeeId))
	SET content=employeeFullName_"|"_salary
	;	
	QUIT content
	;
writeToFile(statisticsId,content)
	WRITE statisticsId_"|"_content,!
	;
	QUIT	
	;