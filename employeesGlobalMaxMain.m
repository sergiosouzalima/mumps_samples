main
	;
	KILL ^globalMax
	;	
	SET maxSal=0
	SET content=""
	SET globalMaxId=0
	;	
	FOR i=1:1 SET id=$D(^employee(i)) Q:'id  SET maxSal=$$globalMax(^employee(i),globalMaxId,maxSal)
	;
	DO saveToFile
	;		
	QUIT
	;	
globalMax(content,globalMaxId,maxSal)
	;	
	SET currentSal=$P($P(content,",",4),":",2) 
	;	
	IF (currentSal>maxSal) DO
	. SET globalMaxId=globalMaxId+1
	. SET ^globalMax(globalMaxId)=content
	. SET maxSal=currentSal
	;	
	QUIT maxSal
	;	
saveToFile
	;
	SET fileName="employees.txt"
	OPEN fileName:(newversion:stream:nowrap:chset="M")
	USE fileName
	;
	FOR i=1:1 SET id=$D(^globalMax(i)) Q:'id  DO saveToFileItem(^globalMax(i))
	;		
	CLOSE fileName
	QUIT	
	;
saveToFileItem(content)
	;
	; "{id:3,nome:Bernardo,sobrenome:Costa,salario:3700.00,area:SM}"
	SET statisticsId="global_max"
	SET firstName=$P($P(content,",",2),":",2)
	SET lastName=$P($P(content,",",3),":",2)
	SET maxSalary=$P($P(content,",",4),":",2)
	;	
	WRITE statisticsId_"|"_firstName_" "_lastName_"|"_maxSalary
	;
	QUIT	
	;