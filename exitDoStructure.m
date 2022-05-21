	; 
	; Can QUIT command exit a DO structure?
	;
	; File mame: exitWitDo.m
	; Author: Sergio Lima (May, 21 2022)
	;
	; ---
	; If needed:
	; ln -s /home/sergio/workspace/github/sergiosouzalima/mumps_samples/*.m ~/.fis-gtm/V6.3-007_x86_64/r
	; ---
	; How to run: mumps -r ^exitDoStructure
	; How to run: mumps -r TEST^exitDoStructure
	;
	; Made with GT.M Mumps for Linux. ;
	;
INI     ;
	W "Can QUIT command exit a DO structure?",!!
        D PROCESS
	W !,"***",!
	Q
	;
PROCESS ;
        F I=1:1:10  D
	. W "I= ",I,!
	. I (I>5) W "I is greater than 5",!
	W "Out of loop",!
	;
	Q
	;
TEST	;
       	; Depending on Mumps version, the last line of the loop is not executed when i>50
	W !
  	for i=1:1:10 do
  	. set a=i
  	. set b=i*2
  	. if i>50 Q
  	. set c=i*i
	W !,a
	W !,b
	W !,c
	W !
