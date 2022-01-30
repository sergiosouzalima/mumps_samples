	; Prints prime numbers from 1 to 10000
	;
	; File mame: primenumbers.mps
	; Author: Sergio Lima (Jan, 29 2022)
	; How to run: mumps primenumbers.mps
	;
	; Made in Open Mumps for Linux. ;
	; http://www.cs.uni.edu/~okane/
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