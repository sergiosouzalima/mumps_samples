	; returning a value from a function
	;IF 1=1 W "1#2=",1#2,", 1\2=",1\2,!
	SET numberToCheck=997
	SET result=$$isPrime(numberToCheck)
	DO showResults(numberToCheck,result)
	QUIT
	;
isPrime(n)
	; result = 1, n is Prime
	; result = 0, n isn't Prime
	;
	SET divisors=0,result="NIL"
	;FOR i=1:1:n W "n#i=",n,"#",i,"=",n#i,"  " IF (n#i=0) SET divisors=divisors+1
	;FOR i=1:1:n IF (n#i=0) SET divisors=divisors+1
	FOR i=1:1:n SET:(n#i=0) divisors=divisors+1
	;W !,"divisors ",divisors,!!
	SET result=0
	SET:divisors=2 result=1
	;IF divisors=2 DO
	;. S result=1
	;E DO
	;. S result=0
	;
	KILL i,divisors
	QUIT result
	;
showResults(numberToCheck,result)
	SET not="not "
	SET:result=1 not=""
	WRITE !,"Number ",numberToCheck," is ",not,"Prime!",!!
	KILL not
	QUIT
	;