#!/usr/bin/mumps
	;
	; file name: shell_command03.mps
	;
	S destFileName="posts.json"
	S commandLine="curl -s https://jsonplaceholder.typicode.com/posts?id=1 > "_destFileName
	DO apiGET
	DO showJsonFile
	Q
	;
apiGET
	shell &~commandLine~
	Q
	;
showJsonFile
	OPEN 1:(destFileName_",old")
	WRITE !,destFileName,!
	FOR  DO
	. USE 1
	. READ line
	. IF '$test BREAK
	. USE 5
	. WRITE line,!
	CLOSE 1
	Q
	;