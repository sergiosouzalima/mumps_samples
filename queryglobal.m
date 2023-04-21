	; Hello world program. ;
	;
	; File mame: queryglobal.m
	; Author: Sergio Lima (Apr, 21 2023)
	; How to run: mumps -r ^queryglobal
	; ---
	; If needed:
	; ln -s /home/sergio/workspace/github/sergiosouzalima/mumps_samples/*.m ~/.fis-gtm/V6.3-007_x86_64/r
	; ---	
	;
	; Made with GT.M Mumps for Linux. ;
	;
	; Clear ^Data
	K ^Data
	;
	; Set data in ^Data
	S ^Data(1)=""
	S ^Data(1,1)=""
	S ^Data(1,2)=""
	S ^Data(2)=""
	S ^Data(2,1)=""
	S ^Data(2,2)=""
	S ^Data(5,1,2)=""
	;
	; Get first node
	S node=$Q(^Data(""))
	;
	; Traverse the global
	F  Q:node=""  D
	. W node,!
	. ; Get next node
	. S node=$Q(@node)
	;			