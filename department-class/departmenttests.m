	;
	zlink "routines/Database"
	zlink "routines/Department"
	;	
	SET SEP="^"
	SET TRUE=1,FALSE=0
	;
; create Departments
	;
	SET ok=$$set^Department("SD","Software Development")
	IF ok=TRUE DO
	. WRITE "Department created:",!
	. zwrite ^departments("SD")
	ELSE  DO
	. WRITE "Whoops! The Department could not be created.",!
	;
	SET ok=$$set^Department("SM","Software Managment")
	IF ok=TRUE DO
	. WRITE !,"Department created:",!
	. zwrite ^departments("SM")
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be created.",!
	;
; fetch a Department 
	;
	SET id="SD"
	SET ok=$$fetch^Department(id,.data)
	IF ok=TRUE DO
	. WRITE !,"Department fetched (",id,"):",!
	. zwrite data
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be fetched.",!
	;
; update a Department 
	;
	SET id="SM"
	SET ok=$$set^Department(id,"Software Managment Project")
	IF ok=TRUE DO
	. WRITE !,"Department updated (",id,"):",!
	. zwrite ^departments("SM")
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be updated.",!
	;
; fetch a Department 
	;
	SET id="SM"
	SET ok=$$fetch^Department(id,.data)
	IF ok=TRUE DO
	. WRITE !,"Department fetched (",id,"):",!
	. zwrite data
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be fetched.",!
	;
; delete a Department 
	;
	SET id="SM"
	SET ok=$$remove^Department(id)
	IF ok=TRUE DO
	. WRITE !,"Department Deleted (",id,")",!
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be Deleted.",!
	;
; fetch a Department 
	;
	SET id="SM"
	SET ok=$$fetch^Department(id,.data)
	IF ok=TRUE DO
	. WRITE !,"Department fetched (",id,"):",!
	. zwrite data
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be fetched.",!
	;
; Drop Database
	;
	SET ok=$$drop^Database()
	IF ok=TRUE DO
	. WRITE !,"Database successfully Dropped!",!
	ELSE  DO
	. WRITE !,"Whoops! The Database could not be Dropped.",!