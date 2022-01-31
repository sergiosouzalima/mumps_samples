#!/usr/bin/mumps
	;
	; file name: shell_command.mps
	;
	shell/p sort numbers.txt
	open 1:"new_numbers.txt,new"
	for  do
	. use 6
	. read line
	. if '$test break
	. use 1
	. write line,!
	close 1
	;	