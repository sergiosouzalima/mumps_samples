	;
	zlink "../../app/models/Database"
	zlink "../../app/models/Department"
	;	
	SET SEP="^"
	SET TRUE=1,FALSE=0
	;
setup()
	;
	SET SEP="^"
	SET TRUE=1,FALSE=0
	;	
	KILL ^departments
	;
	QUIT
	;
tearDown()
	;
	WRITE !,"*** END RUN",!
	;
; create Department
	;
	SET ok=$$set^department("SD","Software Development")
	IF ok DO
	. WRITE "Department created:",!
	. zwrite ^departments("SD")
	ELSE  DO
	. WRITE "Whoops! The Department could not be created.",!
	;
	SET ok=$$set^department("SM","Software Managment")
	IF ok DO
	. WRITE !,"Department created:",!
	. zwrite ^departments("SM")
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be created.",!
	;
; fetch a Department 
	;
	SET id="SD"
	SET ok=$$fetch^department(id,.data)
	IF ok DO
	. WRITE !,"Department fetched (",id,"):",!
	. zwrite data
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be fetched.",!
	;
; update a Department 
	;
	SET id="SM"
	SET ok=$$set^department(id,"Software Managment Project")
	IF ok DO
	. WRITE !,"Department updated (",id,"):",!
	. zwrite ^departments("SM")
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be updated.",!
	;
; fetch a Department 
	;
	SET id="SM"
	SET ok=$$fetch^department(id,.data)
	IF ok DO
	. WRITE !,"Department fetched (",id,"):",!
	. zwrite data
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be fetched.",!
	;
; delete a Department 
	;
	SET id="SM"
	SET ok=$$remove^department(id)
	IF ok DO
	. WRITE !,"Department Deleted (",id,")",!
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be Deleted.",!
	;
; fetch a Department 
	;
	SET id="SM"
	SET ok=$$fetch^department(id,.data)
	IF ok DO
	. WRITE !,"Department fetched (",id,"):",!
	. zwrite data
	ELSE  DO
	. WRITE !,"Whoops! The Department could not be fetched.",!
	;
; fetch Department property name
	;	
	SET id="SD"
	SET deptName=$$fetchProp^department(id,"name")
	IF deptName="" DO
	. WRITE !,"Whoops! The Department name could not be fetched.",!
	ELSE  DO
	. WRITE !,"Department name fetched (",deptName,"):",!
	;
; fetch Department name
	;	
	SET id="SD"
	SET deptName=$$fetchName^department(id)
	IF deptName="" DO
	. WRITE !,"Whoops! The Department name could not be fetched.",!
	ELSE  DO
	. WRITE !,"Department name fetched (",deptName,"):",!
	;
; Drop Database
	;
	SET ok=$$drop^database()
	IF ok DO
	. WRITE !,"Database successfully Dropped!",!
	ELSE  DO
	. WRITE !,"Whoops! The Database could not be Dropped.",!
	;