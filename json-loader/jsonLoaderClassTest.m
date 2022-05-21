	;  
	; Json file Loader Class test ;
	;
	; File mame: jsonLoaderClassTest.m
	; Author: Sergio Lima (Mar, 9 2022)
	; How to run:
	;  mumps -r jsonLoaderClassTest funcionarios2.json
	;	
	; Made with GT.M Mumps for Linux. ;
	;	
	SET jsonFileName=$PIECE($ZCMDLINE," ",1)
	;	
	SET result=$$run^jsonLoaderClass(jsonFileName)
	;	
	WRITE !,result,!
	;	
	QUIT