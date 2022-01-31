	; Giving a number, this program checks if a sequence of digits
	; can be read the same backward as forward. ;
	;
	; Eg., the following numbers are palindromes:
	; 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 505, 1001, 2002, 3003
	;
	; File mame: palindrome.m
	; Author: Sergio Lima (Jan, 29 2022)
	; How to run: mumps -r ^palindrome
	;
	; Made with GT.M Mumps for Linux. ;
	;
	SET min=1,max=3003,TRUE=1,FALSE=0
	WRITE #,!,"Palindrome Numbers from ",min," to ",max,!!
	FOR i=min:1:max DO
	. SET isPalindrome=$$isPalindrome(i)
	. WRITE:isPalindrome i," "
	WRITE !!
	QUIT
	;
isPalindrome(n)
	; result = 1, n is Palindrome
	; result = 0, n isn't Palindrome
	; SET reversed=$REVERSE(n) ; Alternatively $REVERSE function can be used. ;
	SET reversed=$$reversedNumber(n)
	QUIT:(n=reversed) TRUE
	QUIT FALSE
	;
reversedNumber(n)
	; result = reversed Number
	SET result=n,len=$LENGTH(n),reversedNumber=""
	FOR counter=len:-1:1 DO
	. SET reversedNumber=reversedNumber_$EXTRACT(n,counter)
	SET result=reversedNumber
	QUIT result
	;