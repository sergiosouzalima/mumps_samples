	; Fill zeros to the left 
	;
	; File mame: zerosleft.m
	; Author: Sergio Lima (Jun, 14 2022)
	; How to run: mumps -r ^zerosleft
	;
	; Made with GT.M Mumps for Linux. ;
	;
	;	
	W #
	W $$PZ(1203,10)
	W !
	Q
	;	
PZ(VL,TM) ; Fill zeros to the left 
	N A,B
	S $P(A,"0",500)=+VL
	S B=$L(A)
FPZ Q $E(A,B-TM+1,B)
	;