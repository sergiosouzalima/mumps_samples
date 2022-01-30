#!/usr/bin/mumps
	;
	; file name: shell_command02.mps
	;
	S sourceFileName="numbers.txt"
	S destFileName="new_numbers.txt"
	S commandLine="sort "_sourceFileName_" > "_destFileName
	DO sortFile
	DO showNewFile
	H
	;
sortFile
	shell &~commandLine~
	Q
	;	
showNewFile
	OPEN 1:(destFileName_",old")
	WRITE destFileName,!
	FOR  DO
	. USE 1
	. READ line
	. IF '$test BREAK
	. USE 5
	. WRITE line,!
	CLOSE 1
	Q
	;