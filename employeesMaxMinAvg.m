main
	SET maxSal=0
	SET minSal=999999
	SET sumSal=0
	SET avgSal=0
	SET content=""
	;	
	KILL ^byDept
	;	
	; Remove "braces" from department content: } and {
	SET deptAbbr=""
	FOR i=1:1 SET deptAbbr=$O(^department(deptAbbr)) Q:deptAbbr=""  DO
	. SET content=$$removeBraces(^department(deptAbbr))
	. SET ^department(deptAbbr)=content
	;	
	; Calculate Global Statistics
	FOR i=1:1 SET id=$D(^employee(i)) Q:'id  DO
	. SET content=$$removeBraces(^employee(i))
	. SET maxSal=$$getMaxSalary(content,maxSal)
	. SET minSal=$$getMinSalary(content,minSal)
	. SET sumSal=sumSal+$$getSalary(content)
	. SET ^employee(i)=content
	;
	; Write to file Global Statistics
	SET:i>0 i=i-1,avgSal=sumSal/i
	DO writeGlobalStatToFile(minSal,maxSal,avgSal)
	;	
	; Calculate Statistics by department
	SET maxMin="",deptId=""
	;
	F i=1:1 SET maxMin=$O(^byDept(maxMin)) Q:maxMin=""  DO
	. F j=1:1 SET deptId=$O(^byDept(maxMin,deptId)) Q:deptId=""  DO
	. . W maxMin," ",deptId," ",^byDept(maxMin,deptId),!
	;
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
writeGlobalStatToFile(minSal,maxSal,avgSal)
	;
	SET fileName="employees.txt"
	OPEN fileName:(newversion:stream:nowrap:chset="M")
	USE fileName
	;
	;FOR i=1:1 SET id=$D(^employee(i)) Q:'id  DO writeMinMax("global_max",^employee(i),maxSal)
	;FOR i=1:1 SET id=$D(^employee(i)) Q:'id  DO writeMinMax("global_min",^employee(i),minSal)
	;
	FOR i=1:1 SET id=$D(^employee(i)) Q:'id  DO 
	. DO writeMinMax("global_max",^employee(i),maxSal)
	. DO writeMinMax("global_min",^employee(i),minSal)
	;	
	DO writeAvg("global_avg",avgSal)
	;			
	CLOSE fileName
	QUIT	
	;
writeMinMax(statisticsId,content,maxMinSalary)
	;
	; content:
	; "{id:3,nome:Bernardo,sobrenome:Costa,salario:3700.00,area:SM}"
	;
	;SET salary=$P($P(content,",",4),":",2)
	SET salary=$$getSalary(content)
	;	
	QUIT:salary'=maxMinSalary
	;	
	SET firstName=$P($P(content,",",2),":",2)
	SET lastName=$P($P(content,",",3),":",2)
	;
	WRITE statisticsId_"|"_firstName_" "_lastName_"|"_$$formatCurrency(maxMinSalary),!
	;
	;SET dept=$P($P(content,",",5),":",2)
	;SET deptDesc=$P($P(^department(dept),",",2),":",2)
	;SET id=$P($P(content,",",1),":",2)
	;	
	;SET ^dept($translate(statisticsId,"geral","area"),id)=content_","_deptDesc
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
	SET id=$P($P(content,",",1),":",2)
	;	
	SET ^byDept(statisticsId,id)=content_",deptName:"_deptName
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