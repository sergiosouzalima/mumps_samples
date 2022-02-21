	; Employees' Statistics Report. ;
	;
	; File mame: employeesCalcLastNameMax.m
	; Author: Sergio Lima (Feb, 18 2022)
	; How to run: mumps -r main^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;		
main(reportFileName)
	;
	SET fileName=reportFileName
	OPEN fileName:(append:stream:nowrap:chset="M")
	USE fileName
	;
	DO generateLastNameMax()
	;
	CLOSE fileName
	QUIT	
	;	
generateLastNameMax()
	;
	; Read all ^employee. Print when employeeLastName^employee=employeeLastName^lastNameMax
	;	
	; lastNameMax(employeeLastName)=salaryValue^employeeQty
	;	
	; ^lastNameMax("Campos")="2550.00^1"
	; ^lastNameMax("Costa")="3700.00^1"
	; ^lastNameMax("Farias")="2750.00^3"
	; ^lastNameMax("Oliveira")="2500.00^1"
	; ^lastNameMax("Pinheiro")="2450.00^1"
	; ^lastNameMax("Ramos")="2700.00^2"
	; ^lastNameMax("Silva")="3200.00^1"
	; ^lastNameMax("Souza")="2750.00^1"
	;
	SET employeeId=""
	FOR i=1:1 SET employeeId=$O(^employees(employeeId)) Q:employeeId=""  DO
	. SET employeeLastName=$$getEmployeeLastName^employeeClass(employeeId)
	. IF $D(^lastNameMax(employeeLastName)) DO
	. . IF ($$getEmployeeQty^employeeLastNameMaxClass(employeeLastName)>1) DO
	. . . SET employeeLastNameMaxSalaryValue=$$getSalaryValue^employeeLastNameMaxClass(employeeLastName)
	. . . SET employeeSalaryValue=$$getEmployeeSalaryValue^employeeClass(employeeId)
	. . . IF employeeLastNameMaxSalaryValue=employeeSalaryValue DO
	. . . . SET employeeSalaryValue=$$getEmployeeSalaryValue^employeeClass(employeeId)
	. . . . SET employeeFullName=$$getEmployeeFullName^employeeClass(employeeId)
	. . . . DO printLastNameMax(employeeLastName,employeeFullName,employeeSalaryValue)
	;
	QUIT	
	;
printLastNameMax(employeeLastName,employeeFullName,employeeSalaryValue)	
	SET content=$$formatIfNull^helper(employeeLastName)_"|"_$$formatIfNull^helper(employeeFullName)_"|"_$$formatDecimal^helper(employeeSalaryValue)	
	;	
	DO writeToFile("last_name_max",content)
	;
	QUIT	
	;	
writeToFile(statisticsId,content)
	WRITE statisticsId_"|"_content,!
	;
	QUIT	
	;