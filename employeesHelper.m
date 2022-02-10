	; Employees' Statistics Report. ;
	;
	; File mame: employeesHelper.m
	;
	; Author: Sergio Lima (Feb, 9 2022)
	; How to run: mumps -r ^employees
	;
	; Made with GT.M Mumps for Linux. ;
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
getSalary(content)
	;	
	SET salary=$P($P(content,",",4),":",2) 
	QUIT salary
	;	
getDeptId(content)
	;	
	SET deptId=$P($P(content,",",5),":",2) 
	QUIT deptId
	;	
formatCurrency(value)
	;
	SET:value="" value=0
	QUIT $translate($fnumber(value,",",2),".,",",.")
	;	
saveDebug(msg)
	;
	SET debugId=debugId+1
	SET ^debug(debugId)=msg
	QUIT
	;	