main
	SET maxSal=0
	SET minSal=999999
	SET sumSal=0
	SET avgSal=0
	SET content=""
	;	
	KILL ^avgByDeptPrepare,^avgByDept
	;	
	; Remove "braces" from department content: } and {
	SET deptAbbr=""
	FOR i=1:1 SET deptAbbr=$O(^department(deptAbbr)) Q:deptAbbr=""  DO
	. SET content=$$removeBraces(^department(deptAbbr))
	. SET ^department(deptAbbr)=content
	;	
	; Calculate Global & Department Statistics 
	FOR i=1:1 SET id=$D(^employee(i)) Q:'id  DO
	. SET content=$$removeBraces(^employee(i))
	. SET maxSal=$$getMaxSalary(content,maxSal)
	. SET minSal=$$getMinSalary(content,minSal)
	. SET sumSal=sumSal+$$getSalary(content)
	. SET ^employee(i)=content
	;
	; Write Statistics to file
	SET:i>0 i=i-1,avgSal=sumSal/i
	DO writeStatisticsToFile(minSal,maxSal,avgSal)
	;	
	QUIT
	;	
getMaxSalary(content,maxSal)
	;	
	SET currentSal=$$getSalary(content)
	SET:currentSal>maxSal maxSal=currentSal
	QUIT maxSal
	;	
getMinSalary(content,minSal)
	;	
	SET currentSal=$$getSalary(content)
	SET:currentSal<minSal minSal=currentSal
	QUIT minSal
	;	
removeBraces(content)
	;
	QUIT $translate(content,"{}","")
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
	WRITE statisticsId_"|"_deptName_"|"_firstName_" "_lastName_"|"_$$formatCurrency(salary),!
	;
	QUIT	
	;
writeAvgByDept(statisticsId,content,deptName)
	;
	SET salaryByDept=$P($P(content,"^",1),":",2)
	SET qtyByDept=$P($P(content,"^",2),":",2)
	SET avg=salaryByDept/qtyByDept
	;	
	WRITE statisticsId_"|"_deptName_"|"_$$formatCurrency(avg),!
	;
	;	
	;area_max|Gerenciamento de Software|Bernardo Costa|3700.00
	;area_max|Gerenciamento de Software|Richie Rich|3700.00
	;area_max|Recrutamento|Hugh Hefner|3700.00
	;area_min|Gerenciamento de Software|Marcelo Souza|1200.00
	;area_min|Gerenciamento de Software|João Lenão|1200.00
	;area_avg|Gerenciamento de Software|3450.00
	;area_avg|Recrutamento|3000.00
	;		
	;^avgByDeptPrepare("area_max",3)="id:3,nome:Bernardo,sobrenome:Costa,salario:3700.00,area:SM,deptName:Gerenciamento de Software"
	;^avgByDeptPrepare("area_min",2)="id:2,nome:Sergio,sobrenome:Pinheiro,salario:2450.00,area:SD,deptName:Desenvolvimento de Software"
	;^avgByDeptPrepare("area_min",6)="id:6,nome:Letícia,sobrenome:Farias,salario:2450.00,area:UD,deptName:Designer de UI/UX"
	;^avgByDeptPrepare("area_min",7)="id:7,nome:Fernando,sobrenome:Ramos,salario:2450.00,area:SD,deptName:Desenvolvimento de Software"
	;^avgByDept("Desenvolvimento de Software")="salaryByDept:4900^qtyByDept:2"
	;^avgByDept("Designer de UI/UX")="salaryByDept:2450.00^qtyByDept:1"
	;^avgByDept("Gerenciamento de Software")="salaryByDept:3700.00^qtyByDept:1"
	;	
	QUIT	
	;
writeMinMax(statisticsId,content,maxMinSalary)
	;
	; content:
	; "{id:3,nome:Bernardo,sobrenome:Costa,salario:3700.00,area:SM}"
	;
	SET salary=$$getSalary(content)
	;	
	QUIT:salary'=maxMinSalary
	;	
	SET firstName=$P($P(content,",",2),":",2)
	SET lastName=$P($P(content,",",3),":",2)
	;
	WRITE statisticsId_"|"_firstName_" "_lastName_"|"_$$formatCurrency(maxMinSalary),!
	;
	DO:statisticsId["max" saveByDept("area_max",content)
	DO:statisticsId["min" saveByDept("area_min",content)
	QUIT	
	;
writeAvg(statisticsId,avgSal)
	;
	WRITE statisticsId_"|"_$$formatCurrency(avgSal),!
	QUIT
	;	
saveByDept(statisticsId,content)
	;
	SET dept=$P($P(content,",",5),":",2)
	SET deptName=$P($P(^department(dept),",",2),":",2)
	SET salary=$$getSalary(content)
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
getSalary(content)
	;	
	SET salary=$P($P(content,",",4),":",2) 
	QUIT salary
	;	
formatCurrency(value)
	;
	SET:value="" value=0
	QUIT $translate($fnumber(value,",",2),".,",",.")
	;	