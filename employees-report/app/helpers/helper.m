	; Employees' Statistics Report. ;
	;
	; File mame: employeesHelper.m
	;
	; Author: Sergio Lima (Feb, 9 2022)
	; How to run: mumps -r main^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;
getMaxValue(value,maxValue)
	;	
	SET:value>maxValue maxValue=value
	QUIT maxValue
	;	
getMinValue(value,minValue)
	;	
	SET:value<minValue minValue=value
	QUIT minValue
	;	
removeBraces(content)
	;
	QUIT $translate(content,"{}","")
	;	
allTrim(content)
	;
	QUIT $$FUNC^%TRIM(content)
	;	
extractDeptName(content)
	;
	IF content["nome:" SET content=$P($P(content,",",2),":",2)
	;
	QUIT $$removeBraces(content)
	;
extractEmployeeFields(content)
	; {id:1,nome:Aahron,sobrenome:Abaine,salario:24048.75,area:A2}
	;
	SET content=$$removeBraces(content)
	;SET content=$P($P(content,",",2),":",2)_$$SEP^constantClass_$$dashReplace^helper($P($P(content,",",3),":",2))_$$SEP^constantClass_$P($P(content,",",4),":",2)_$$SEP^constantClass_$P($P(content,",",5),":",2)
	SET content=$P($P(content,",",2),":",2)_$$SEP^constantClass_$$dashToPlusReplace^helper($P($P(content,",",3),":",2))_$$SEP^constantClass_$P($P(content,",",4),":",2)_$$SEP^constantClass_$P($P(content,",",5),":",2)
	SET content="{"_content_"}"
	QUIT content
	;
formatCurrency(value)
	;
	SET:value="" value=0
	QUIT $translate($fnumber(value,",",2),".,",",.")
	;	
formatDecimal(value)
	;
	SET:value="" value=0
	QUIT $fnumber(value,"",2)
	;	
formatIfNull(value)
	;
	QUIT $translate(value,"999999999","")
	;	
fileExists(fileName)
	;
	SET empty=$ZSEARCH(fileName)
	;	
	QUIT:empty="" $$FALSE^constantClass
	;	
	QUIT:empty'="" $$TRUE^constantClass
	;
dashToPlusReplace(content)
	;
	QUIT:content["-" $translate(content,"-","+")
	;
	QUIT content
	;	
plusToDashReplace(content)
	;	
	QUIT:content["+" $translate(content,"+","-")
	;	
	QUIT content
	;	
saveDebug(msg)
	;
	SET ^debug(msg)=""
	QUIT
	;	