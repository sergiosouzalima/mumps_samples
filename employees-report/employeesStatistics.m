	; Employees' Statistics Report. ;
	;
	; File mame: employeesStatistics.m
	; Author: Sergio Lima (Feb, 9 2022)
	; How to run: mumps -r main^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;		
main
	SET maxSal=0
	SET minSal=999999
	SET sumSal=0
	SET avgSal=0
	SET content=""
	SET employeeCounter=0
	SET debugCounter=0
	;	
	KILL ^avgByDeptPrepare,^avgByDept,^empByDeptPrepare,^debug
	;
	;. SET content=$$removeBraces^helper(^employees(id))
	;	
	; Calculate Global & Department Statistics 
	;SET id=""
	;FOR i=1:1 SET id=$O(^employees(id)) Q:id=""  DO
	;. SET content=^employees(id)
	;. SET maxSal=$$getMaxSalary^helper(content,maxSal)
	;. SET minSal=$$getMinSalary^helper(content,minSal)
	;. SET sumSal=sumSal+$$getSalary^helper(content)
	;. SET ^employees(id)=content
	;. DO saveEmpByDept(content)
	;
	;QUIT
	SET id=""
	FOR i=1:1 SET id=$O(^employees(id)) Q:id=""  DO
	. SET employeeCounter=$Increment(employeeCounter)
	. SET content=$$removeBraces^helper(^employees(id))
	. SET ok=$$update^employee(id,content)
	. SET salaryValue=$$getEmployeeSalaryValue^employee(id)
	. SET maxSal=$$getMaxSalary^helper(salaryValue,maxSal)
	. SET minSal=$$getMinSalary^helper(salaryValue,minSal)
	. SET sumSal=sumSal+salaryValue
	. DO saveEmpByDept(id)
	;	
	;S debugCounter=debugCounter+1
	;S ^debug(debugCounter)="sumSal:"_sumSal
	; Write Statistics to file
	SET:employeeCounter>0 avgSal=sumSal/employeeCounter
	DO writeStatisticsToFile(minSal,maxSal,avgSal)
	;	
	QUIT
	;	
writeStatisticsToFile(minSal,maxSal,avgSal)
	;
	SET fileName="employees.txt"
	OPEN fileName:(newversion:stream:nowrap:chset="M")
	USE fileName
	;
	;S debugCounter=debugCounter+1
;	S ^debug(debugCounter)="writeStatisticsToFile:"_minSal_"^"_maxSal_"^"_avgSal
	;	
	SET id=""
	FOR i=1:1 SET id=$O(^employees(id)) Q:id=""  DO 
	. DO writeMinMax("global_max",id,maxSal)
	. DO writeMinMax("global_min",id,minSal)	
	;	
	;. DO writeMinMax("global_max",^employees(id),maxSal)
	;. DO writeMinMax("global_min",^employees(id),minSal)
	;	
	DO writeAvg("global_avg",avgSal)
	;			
	SET maxMin="",deptId=""
	F i=1:1 SET maxMin=$O(^avgByDeptPrepare(maxMin)) Q:maxMin=""  DO
	. F j=1:1 SET deptId=$O(^avgByDeptPrepare(maxMin,deptId)) Q:deptId=""  DO
	. . SET content=^avgByDeptPrepare(maxMin,deptId)
	. . DO:maxMin="area_max" writeMinMaxByDept(maxMin,content)
	;
	SET maxMin="",deptId=""
	F i=1:1 SET maxMin=$O(^avgByDeptPrepare(maxMin)) Q:maxMin=""  DO
	. F j=1:1 SET deptId=$O(^avgByDeptPrepare(maxMin,deptId)) Q:deptId=""  DO
	. . SET content=^avgByDeptPrepare(maxMin,deptId)
	. . DO:maxMin="area_min" writeMinMaxByDept(maxMin,content)
	;	
	SET deptName=""
	F i=1:1 SET deptName=$O(^avgByDept(deptName)) Q:deptName=""  DO
	. DO writeAvgByDept("area_avg",^avgByDept(deptName),deptName)
	;		
	; Get department with least and most employees
	SET leastEmployeesByDeptQty=0
	SET leastEmployeesByDeptId=""
	SET mostEmployeesByDeptQty=999999
	SET mostEmployeesByDeptId=""
	;	
	SET mostQty=0
	SET leastQty=99999999
	;			
	SET deptId=""
	F i=1:1 SET deptId=$O(^empByDeptPrepare(deptId)) Q:deptId=""  DO
	. SET content=^empByDeptPrepare(deptId)
	. SET currentQty=$P(content,":",2)
	. IF currentQty>mostQty DO
	. . SET mostQty=currentQty
	. IF currentQty<leastQty DO
	. . SET leastQty=currentQty
	;
	DO writeLeastMostEmpByDept("least_employees",leastQty)
	;
	DO writeLeastMostEmpByDept("most_employees",mostQty)
	;
	CLOSE fileName
	QUIT	
	;
writeMinMaxByDept(statisticsId,content)
	;
	;S debugCounter=debugCounter+1
	;S ^debug(debugCounter)="writeMinMaxByDept:"_content
	;
	SET firstName=$P(content,"^",1)
	SET lastName=$P(content,"^",2)
	SET salary=$P(content,"^",3)
	SET deptName=$P(content,"^",4)
	;
	;SET deptName=$P($P(content,",",6),":",2)
	;SET firstName=$P($P(content,",",2),":",2)
	;SET lastName=$P($P(content,",",3),":",2)
	;SET salary=$P($P(content,",",4),":",2)
	;	
	WRITE statisticsId_"|"_deptName_"|"_firstName_" "_lastName_"|"_$$formatCurrency^helper(salary),!
	;
	QUIT	
	;
writeAvgByDept(statisticsId,content,deptName)
	;
	SET salaryByDept=$P($P(content,"^",1),":",2)
	SET qtyByDept=$P($P(content,"^",2),":",2)
	SET avg=salaryByDept/qtyByDept
	;	
	WRITE statisticsId_"|"_deptName_"|"_$$formatCurrency^helper(avg),!
	;
	QUIT	
	;
writeMinMax(statisticsId,employeeId,maxMinSalary)
	;
	;S debugCounter=debugCounter+1
	;S ^debug(debugCounter)="writeMinMax:"_employeeId_"^"_maxMinSalary
	;
	;S debugCounter=debugCounter+1
	;S ^debug(debugCounter)="Before calling saveByDept 0: "_"^"_employeeId
	;
	;	
	;SET salary=$$getSalary^helper(content)
	SET salaryValue=$$getEmployeeSalaryValue^employee(employeeId)
	;	
	;S debugCounter=debugCounter+1
	;S ^debug(debugCounter)="Before calling saveByDept 0.5: "_"^"_salaryValue_"^"_maxMinSalary
	;
	QUIT:salaryValue'=maxMinSalary
	;	
	;S debugCounter=debugCounter+1
	;S ^debug(debugCounter)="Before calling saveByDept 1: "_"^"_maxMinSalary
	;
	SET employeeFirstName=$$getEmployeeFirstName^employee(employeeId)
	SET employeeLastName=$$getEmployeeLastName^employee(employeeId)
	SET employeeDeptId=$$getEmployeeDeptId^employee(employeeId)
	;SET firstName=$P($P(content,",",2),":",2)
	;SET lastName=$P($P(content,",",3),":",2)
	;	
	;S debugCounter=debugCounter+1
	;S ^debug(debugCounter)="Before calling saveByDept 1.5: "_"^"_employeeFirstName_"^"_employeeLastName_"^"_employeeDeptId
	;
	WRITE statisticsId_"|"_employeeFirstName_" "_employeeLastName_"|"_$$formatCurrency^helper(maxMinSalary),!
	;
	;S debugCounter=debugCounter+1
	;S ^debug(debugCounter)="Before calling saveByDept 2: "_"^"_employeeId_"^"_employeeDeptId_"^"_salaryValue
	;
	DO:statisticsId["max" saveByDept("area_max",employeeId,employeeDeptId,salaryValue)
	DO:statisticsId["min" saveByDept("area_min",employeeId,employeeDeptId,salaryValue)
	QUIT	
	;
writeAvg(statisticsId,avgSal)
	;
	WRITE statisticsId_"|"_$$formatCurrency^helper(avgSal),!
	QUIT
	;	
writeLeastMostEmpByDept(statisticsId,leastMostQty)
	;	
	SET deptId=""
	F i=1:1 SET deptId=$O(^empByDeptPrepare(deptId)) Q:deptId=""  DO
	. SET content=^empByDeptPrepare(deptId)
	. SET currentQty=$P(content,":",2)
	. SET deptName=$$getDeptName^department(deptId) ;SET deptName=$$fetchName^Departments(deptId)
	. IF leastMostQty=currentQty DO
	. . WRITE statisticsId_"|"_deptName_"|"_currentQty,!
	;	
	QUIT
	;	
saveByDept(statisticsId,employeeId,employeeDeptId,salaryValue)
	;
	;SET dept=$P($P(content,",",5),":",2)
	;SET deptName=$$fetchName^Departments(deptId)
	;SET salary=$$getSalary^helper(content)
	;SET id=$P($P(content,",",1),":",2)
	;	
	;S debugCounter=debugCounter+1
	;S ^debug(debugCounter)="saveByDept: "_"^"_statisticsId_"^"_employeeId_"^"_employeeDeptId_"^"_salaryValue
	;	
	SET deptName=$$getDeptName^department(employeeDeptId)
	;	
	SET salaryValue=$$getEmployeeSalaryValue^employee(employeeId)
	SET employeeFirstName=$$getEmployeeFirstName^employee(employeeId)
	SET employeeLastName=$$getEmployeeLastName^employee(employeeId)
	SET content=employeeFirstName_"^"_employeeLastName_"^"_salaryValue
	;	
	;S debugCounter=debugCounter+1
	;S ^debug(debugCounter)=deptName
	;	
	;SET ^avgByDeptPrepare(statisticsId,employeeId)=content_",deptName:"_deptName
	SET ^avgByDeptPrepare(statisticsId,employeeId)=content_"^"_deptName
	;	
	SET avgByDeptExists=$D(^avgByDept(deptName))
	;	
	IF 'avgByDeptExists SET ^avgByDept(deptName)="salaryByDept:"_salaryValue_"^qtyByDept:1"
	;	
	IF avgByDeptExists DO
	. SET salaryByDept=$P($P(^avgByDept(deptName),"^",1),":",2)
	. SET qtyByDept=$P($P(^avgByDept(deptName),"^",2),":",2)
	. SET salaryByDept=salaryByDept+salaryValue
	. SET qtyByDept=qtyByDept+1
	. SET ^avgByDept(deptName)="salaryByDept:"_salaryByDept_"^qtyByDept:"_qtyByDept
	;	
	QUIT
	;	
saveEmpByDept(id)
	;
	;S debugCounter=debugCounter+1
	;S ^debug(debugCounter)="saveEmpByDept: "_"^"_id
	;
	;S deptId=$$getEmployeeDeptId^employee(id)
	;	
	;SET deptId=$$getDeptId^helper(content)
	SET exists=$D(^empByDeptPrepare(deptId))
	;	
	IF 'exists SET ^empByDeptPrepare(deptId)="empByDeptQty:1"
	;	
	IF exists DO
	. SET empByDeptQty=$P(^empByDeptPrepare(deptId),":",2)
	. SET empByDeptQty=empByDeptQty+1
	. SET ^empByDeptPrepare(deptId)="empByDeptQty:"_empByDeptQty
	;	
	QUIT