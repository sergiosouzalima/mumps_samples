	; Employees' Statistics Report. ;
	;
	; File mame: employeesStatistics.m
	;
	; Author: Sergio Lima (Feb, 9 2022)
	; How to run: mumps -r ^employees
	;
	; Made with GT.M Mumps for Linux. ;
	;
main
	SET maxSal=0
	SET minSal=999999
	SET sumSal=0
	SET avgSal=0
	SET content=""
	;	
	KILL ^avgByDeptPrepare,^avgByDept,^empByDeptPrepare
	;	
	; Calculate Global & Department Statistics 
	FOR i=1:1 SET id=$D(^employee(i)) Q:'id  DO
	. SET content=$$removeBraces^employeesHelper(^employee(i))
	. SET maxSal=$$getMaxSalary^employeesHelper(content,maxSal)
	. SET minSal=$$getMinSalary^employeesHelper(content,minSal)
	. SET sumSal=sumSal+$$getSalary^employeesHelper(content)
	. SET ^employee(i)=content
	. DO saveEmpByDept(content)
	;
	; Write Statistics to file
	SET:i>0 i=i-1,avgSal=sumSal/i
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
	FOR i=1:1 SET id=$D(^employee(i)) Q:'id  DO 
	. DO writeMinMax("global_max",^employee(i),maxSal)
	. DO writeMinMax("global_min",^employee(i),minSal)
	;	
	DO writeAvg("global_avg",avgSal)
	;			
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
	SET deptName=$P($P(content,",",6),":",2)
	SET firstName=$P($P(content,",",2),":",2)
	SET lastName=$P($P(content,",",3),":",2)
	SET salary=$P($P(content,",",4),":",2)
	;	
	WRITE statisticsId_"|"_deptName_"|"_firstName_" "_lastName_"|"_$$formatCurrency^employeesHelper(salary),!
	;
	QUIT	
	;
writeAvgByDept(statisticsId,content,deptName)
	;
	SET salaryByDept=$P($P(content,"^",1),":",2)
	SET qtyByDept=$P($P(content,"^",2),":",2)
	SET avg=salaryByDept/qtyByDept
	;	
	WRITE statisticsId_"|"_deptName_"|"_$$formatCurrency^employeesHelper(avg),!
	;
	QUIT	
	;
writeMinMax(statisticsId,content,maxMinSalary)
	;
	; content:
	; "{id:3,nome:Bernardo,sobrenome:Costa,salario:3700.00,area:SM}"
	;
	SET salary=$$getSalary^employeesHelper(content)
	;	
	QUIT:salary'=maxMinSalary
	;	
	SET firstName=$P($P(content,",",2),":",2)
	SET lastName=$P($P(content,",",3),":",2)
	;
	WRITE statisticsId_"|"_firstName_" "_lastName_"|"_$$formatCurrency^employeesHelper(maxMinSalary),!
	;
	DO:statisticsId["max" saveByDept("area_max",content)
	DO:statisticsId["min" saveByDept("area_min",content)
	QUIT	
	;
writeAvg(statisticsId,avgSal)
	;
	WRITE statisticsId_"|"_$$formatCurrency^employeesHelper(avgSal),!
	QUIT
	;	
writeLeastMostEmpByDept(statisticsId,leastMostQty)
	;	
	SET deptId=""
	F i=1:1 SET deptId=$O(^empByDeptPrepare(deptId)) Q:deptId=""  DO
	. SET content=^empByDeptPrepare(deptId)
	. SET currentQty=$P(content,":",2)
	. SET deptName=$$fetchName^Department(deptId)
	. IF leastMostQty=currentQty DO
	. . WRITE statisticsId_"|"_deptName_"|"_currentQty,!
	;	
	QUIT
	;	
saveByDept(statisticsId,content)
	;
	SET dept=$P($P(content,",",5),":",2)
	SET deptName=$$fetchName^Department(deptId)
	SET salary=$$getSalary^employeesHelper(content)
	SET id=$P($P(content,",",1),":",2)
	;	
	SET ^avgByDeptPrepare(statisticsId,id)=content_",deptName:"_deptName
	;	
	SET avgByDeptExists=$D(^avgByDept(deptName))
	;	
	IF 'avgByDeptExists SET ^avgByDept(deptName)="salaryByDept:"_salary_"^qtyByDept:1"
	;	
	IF avgByDeptExists DO
	. SET salaryByDept=$P($P(^avgByDept(deptName),"^",1),":",2)
	. SET qtyByDept=$P($P(^avgByDept(deptName),"^",2),":",2)
	. SET salaryByDept=salaryByDept+salary
	. SET qtyByDept=qtyByDept+1
	. SET ^avgByDept(deptName)="salaryByDept:"_salaryByDept_"^qtyByDept:"_qtyByDept
	;	
	QUIT
	;	
saveEmpByDept(content)
	;
	SET deptId=$$getDeptId^employeesHelper(content)
	SET empByDeptExists=$D(^empByDeptPrepare(deptId))
	;	
	IF 'empByDeptExists SET ^empByDeptPrepare(deptId)="empByDeptQty:1"
	;	
	IF empByDeptExists DO
	. SET empByDeptQty=$P(^empByDeptPrepare(deptId),":",2)
	. SET empByDeptQty=empByDeptQty+1
	. SET ^empByDeptPrepare(deptId)="empByDeptQty:"_empByDeptQty
	;	
	QUIT