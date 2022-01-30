	; Giving a number, this program checks if a sequence of digits
	; can be read the same backward as forward. ;
	; eg, the following numbers are palindromes:
	; 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 505, 1001, 2002, 3003. ;
	;
	; File mame: palindrome.mps
	; Author: Sergio Lima (Jan, 29 2022)
	; How to run: mumps palindrome.mps
	;
	; Made in Open Mumps for Linux. ;
	; http://www.cs.uni.edu/~okane/
	;
	SET min=1,max=3003,TRUE=1,FALSE=0
	WRITE !,"Palindrome Numbers from ",min," to ",max,!!
	FOR i=min:1:max DO
	. SET isPalindrome=$$isPalindrome(i)
	. WRITE:(isPalindrome=TRUE) i," "
	WRITE !!
	QUIT
	;
isPalindrome(n)
	; result = 1, n is Palindrome
	; result = 0, n isn't Palindrome
	SET reversed=$$reversedNumber(n)
	QUIT:(n=reversed) TRUE
	QUIT FALSE
	;
reversedNumber(n)
	; result = reversed Number
	SET result=n,len=$LENGTH(n),reversedNumber=""
	FOR counter=len:-1:1 DO
	. SET reversedNumber=reversedNumber_$Extract(n,counter)
	SET result=reversedNumber
	QUIT result
	;