main
	SET maxSal=0
	SET minSal=999999
	SET sumSal=0
	SET avgSal=0
	;	
	FOR i=1:1 SET id=$D(^employee(i)) Q:'id  DO
	. SET maxSal=$$getMaxSalary(^employee(i),maxSal)
	. SET minSal=$$getMinSalary(^employee(i),minSal)
	. SET sumSal=sumSal+$$getSalary(^employee(i))
	;
	SET:i>0 i=i-1,avgSal=sumSal/i
	DO saveToFile(minSal,maxSal,avgSal)
	;		
	QUIT
	;	
getMaxSalary(content,maxSal)
	;	
	SET currentSal=$$getSalary(content)
	;	
	SET:currentSal>maxSal maxSal=currentSal
	;	
	QUIT maxSal
	;	
getMinSalary(content,minSal)
	;	
	SET currentSal=$$getSalary(content)
	;	
	SET:currentSal<minSal minSal=currentSal
	;	
	QUIT minSal
	;	
getSalary(content)
	;	
	SET salary=$P($P(content,",",4),":",2) 
	;	
	QUIT salary
	;	
saveToFile(minSal,maxSal,avgSal)
	;
	SET fileName="employees.txt"
	OPEN fileName:(newversion:stream:nowrap:chset="M")
	USE fileName
	;
	FOR i=1:1 SET id=$D(^employee(i)) Q:'id  DO saveMinMax("global_max",^employee(i),maxSal)
	FOR i=1:1 SET id=$D(^employee(i)) Q:'id  DO saveMinMax("global_min",^employee(i),minSal)
	;	
	DO saveAvg("global_avg",avgSal)
	;			
	CLOSE fileName
	QUIT	
	;
saveMinMax(statisticsId,content,maxMinsalary)
	;
	; content:
	; "{id:3,nome:Bernardo,sobrenome:Costa,salario:3700.00,area:SM}"
	;
	SET salary=$P($P(content,",",4),":",2)
	;	
	QUIT:salary'=maxMinsalary
	;	
	SET firstName=$P($P(content,",",2),":",2)
	SET lastName=$P($P(content,",",3),":",2)
	;
	WRITE statisticsId_"|"_firstName_" "_lastName_"|"_$$formatCurrency(maxMinsalary),!
	;
	QUIT	
	;
saveAvg(statisticsId,avgSal)
	;
	WRITE statisticsId_"|"_$$formatCurrency(avgSal),!
	;
	QUIT
	;	
formatCurrency(value)
	SET:value="" value=0
	QUIT $translate($fnumber(value,",",2),".,",",.")
	;	