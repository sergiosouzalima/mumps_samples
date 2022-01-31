	; Prime numbers generator. ;
	;
	; File mame: primenumbers.m
	; Author: Sergio Lima (Jan, 29 2022)
	; How to run: mumps -r ^primenumbers
	;
	; Made with GT.M Mumps for Linux. ;
	;
	SET min=1,max=10000,TRUE=1,FALSE=0
	WRITE !,"Prime Numbers from ",min," to ",max,!!
	FOR i=min:1:max DO  WRITE:(isPrime=TRUE) i," "
	. SET isPrime=$$isPrime(i)
	WRITE !!
	QUIT
	;
isPrime(n)
	; result = 1, n is Prime
	; result = 0, n isn't Prime
	SET divisors=0,result=FALSE
	FOR counter=1:1:n SET:(n#counter=0) divisors=divisors+1
	SET:divisors=2 result=TRUE
	QUIT result
	;