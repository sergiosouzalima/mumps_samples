	; Employees' Statistics Report. ;
	;
	; File mame: employeesHelper.m
	;
	; Author: Sergio Lima (Feb, 9 2022)
	; How to run: mumps -r main^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;
loadConstants
	;
	;SET TRUE=1,FALSE=0
	;SET SEP="^"
	;SET programTitle="*** Employees' Statistics Report ***"
	;SET jsonFileName="assets/funcionarios-10K.json"; "assets/funcionarios-5M.json"; "assets/funcionarios.json";"funcionarios-30M.json"
	;SET reportFileName="employeesReport.txt"
	;SET maxStringSize=1024*1024 ; the maximum GT.M string size
	;	
	QUIT
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
extractDeptName(content)
	;
	DO saveDebug^helper("extractDeptName ini")
	;	
	IF content["nome:" SET content=$P($P(content,",",2),":",2)
	;
	DO saveDebug^helper("extractDeptName end")
	;	
	QUIT $$removeBraces(content)
	;
extractEmployeeFields(content)
	; {id:1,nome:Aahron,sobrenome:Abaine,salario:24048.75,area:A2}
	;
	SET content=$$removeBraces(content)
	SET content=$P($P(content,",",2),":",2)_$$SEP^constantClass_$P($P(content,",",3),":",2)_$$SEP^constantClass_$P($P(content,",",4),":",2)_$$SEP^constantClass_$P($P(content,",",5),":",2)
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
	QUIT $translate(value,"-1","")
	;	
saveDebug(msg)
	;
	SET ^debug(msg)=""
	QUIT
	;	