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
	QUIT
	;	
globalMax(content,globalMaxId,maxSal)
	;	
	SET currentSal=$P($P(content,",",4),":",2) 
	;	
	;DO saveDebug("currentSal "_currentSal)
	;DO saveDebug("maxSal "_maxSal)
	;	
	IF (currentSal>maxSal) DO
	. SET globalMaxId=globalMaxId+1
	. SET ^globalMax(globalMaxId)=content
	. SET maxSal=currentSal
	;	
	QUIT maxSal
	;	