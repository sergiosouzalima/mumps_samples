	; Employees' Statistics Report. ;
	;
	; File mame: constantClass.m
	; Author: Sergio Lima (Mar, 02 2022)
	; How to run: mumps -r ^employeesReport
	;
	; Made with GT.M Mumps for Linux. ;
	;
TRUE()
	QUIT 1
	;	
FALSE()
	QUIT 0
	;	
SEP()
	QUIT "~"
	;	
PROGRAMTITLE()
	QUIT "*** Employees' Statistics Report ***"
	;	
JSONFILENAME()
	QUIT "assets/Funcionarios-10K.json"; "assets/funcionarios-5M.json"; "assets/funcionarios.json";"funcionarios-30M.json"
	;
REPORTFILENAME()
	QUIT "employeesReport.txt"
	;	
MAXSTRINGSIZE()
	QUIT 1024*1024 ; the maximum GT.M string size