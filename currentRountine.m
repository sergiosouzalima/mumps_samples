	;
	;
	; -------------------------------
	; To get the name of the current function in MUMPS, you can use the `$TLEVEL` function which returns the 
	; current level number of a procedure call stack. You can then use `$TEXT` function to return the text of a 
	; line in a routine at a specified level. Here's an example:
	;
MYFUNC ;
	WRITE $TEXT(+8)_" is the name of this function"
	QUIT
	;
	;In this example, `$TEXT(+0)` returns the text of the first line of the current routine which is `MYFUNCT ;`. ;
	;