	; 
	; Find & set the appropriated column in a CSV row. ;
	;
	; File mame: setCSVRightColumn.m.m
	; Author: Sergio Lima (Sep, 7 2022)
	;
	; ---
	; If needed:
	; ln -s /home/sergio/workspace/github/sergiosouzalima/mumps_samples/*.m ~/.fis-gtm/V6.3-007_x86_64/r
	; ---
	; How to run: mumps -r INI^setCSVRightColumn
	; How to run: mumps -r TEST^setCSVRightColumn
	;
	; Made with GT.M Mumps for Linux. ;
	;
INI ;
	W "Find & set the appropriated column in a CSV row.",!!
	D PROCESS
	W "***",!
	Q
	;
PROCESS;
	;
	N CSVCOLS
	;
	W "Imprime 10.000,00 no peace 3",!
	S POS=2,VAL="10.000,00",CSVCOLS=""
	S CSVCOLS=$$SETCSVCOL(POS,VAL,CSVCOLS)
	W CSVCOLS," tem "_$$CHARCOUNTER(CSVCOLS)_" ;",!!
	;
	W "Imprime 50.000,00 no peace 10",!
	S POS=4,VAL="50.000,00"
	S CSVCOLS=$$SETCSVCOL(POS,VAL,CSVCOLS)
	W CSVCOLS," tem "_$$CHARCOUNTER(CSVCOLS)_" ;",!!
	;
	W "Imprime 700.000,00 no peace 9",!
	S POS=1,VAL="700.000,00"
	S CSVCOLS=$$SETCSVCOL(POS,VAL,CSVCOLS)
	W CSVCOLS," tem "_$$CHARCOUNTER(CSVCOLS)_" ;",!!
	;
	W "Imprime 2.000,00 no peace 1",!
	S POS=6,VAL="2.000,00"
	S CSVCOLS=$$SETCSVCOL(POS,VAL,CSVCOLS)
	W CSVCOLS," tem "_$$CHARCOUNTER(CSVCOLS)_" ;",!!
	;
	W "Imprime 999.000,00 no peace 34",!
	S POS=30,VAL="999.000,00"
	S CSVCOLS=$$SETCSVCOL(POS,VAL,CSVCOLS)
	W CSVCOLS," tem "_$$CHARCOUNTER(CSVCOLS)_" ;",!!
	;	
	;
	W "Imprime 55.000,00 no peace que nao existe",!
	S POS=34,VAL="55.000,00"
	S CSVCOLS=$$SETCSVCOL(POS,VAL,CSVCOLS)
	W CSVCOLS," tem "_$$CHARCOUNTER(CSVCOLS)_" ;",!!
	;
	Q
	;
SETCSVCOL(POS,VAL,PCSVCOLS)
	N CSVCOLS,NUMCOLS
	S NUMCOLS=33
	S VETCOL(6)=1,VETCOL(2)=3,VETCOL(4)=10,VETCOL(1)=9,VETCOL(30)=34
	S CSVCOLS=$G(PCSVCOLS,$$RPTCHAR(NUMCOLS))
	S CSVPOS=$G(VETCOL(POS),0)
	;
	S $P(CSVCOLS,";",CSVPOS)=VAL
	S CHARSTOCOMP=NUMCOLS-$$CHARCOUNTER(CSVCOLS)
	S CSVCOLS=CSVCOLS_$$RPTCHAR(CHARSTOCOMP)
	;
FSETCSVCOL Q CSVCOLS
	;
CHARCOUNTER(STRING,CHAR)
	N COUNTER,STRLEN,I
	S CHAR=$G(CHAR,";")
	S COUNTER=0,STRLEN=$L(STRING)
	F I=1:1:STRLEN I $E(STRING,I,I)=CHAR S COUNTER=COUNTER+1
	;
FCHARCOUNTER Q COUNTER
	;
RPTCHAR(NTIMES,CHAR)
	N RESULT
	S RESULT=""
	S CHAR=$G(CHAR,";")
	S $P(RESULT,CHAR,NTIMES)=CHAR
	;
FRPTCHAR Q RESULT
	;
TEST ;
	; 
	W $$CHARCOUNTER("",";"),!!
	W $$CHARCOUNTER(";",";"),!!
	W $$CHARCOUNTER(";;",";"),!!
	W $$CHARCOUNTER(";;;",";"),!!
	W $$CHARCOUNTER(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;",";"),!!
	;
	W $$RPTCHAR(0),!!
	W $$RPTCHAR(1),!!
	W $$RPTCHAR(2),!!
	W $$RPTCHAR(3),!!
	W $$RPTCHAR(0,";"),!!
	W $$RPTCHAR(1,";"),!!
	W $$RPTCHAR(2,";"),!!
	W $$RPTCHAR(0,"^"),!!
	W $$RPTCHAR(1,"^"),!!
	W $$RPTCHAR(2,"^"),!!
	;
FTEST Q