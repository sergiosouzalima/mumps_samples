	;
	zlink "../../app/models/Database"
	zlink "../../app/models/Employee"
	;	
main()
	;
	DO setup()
	;	
	DO create(1,"Washington^Ramos^2700.00^SD")
	DO create(2,"Wilson^Silva^3200.00^SM")
	DO update(2,"Williams^Akron^2700.00^SD") 
	DO fetch(1)
	DO delete(1)
	DO fetchProp(2,"employeeName")
	;	
	DO tearDown()
	QUIT
	;
setup()
	;
	SET SEP="^"
	SET TRUE=1,FALSE=0
	SET CLASSNAME="Employee"
	KILL ^employees
	;
	QUIT
	;
tearDown()
	;
	KILL SEP
	KILL TRUE,FALSE
	KILL CLASSNAME
	WRITE !,"*** END RUN",!
	;	
	QUIT
	;
showResult(operationName,ok,id,content)
	;
	SET failMessage="Operation failed."
	SET successMessage="Operation successfull."
	;	
	WRITE CLASSNAME_" "_operationName_" ==> "
	IF ok WRITE successMessage
	IF 'ok WRITE failMessage
	WRITE !
	ZWRITE id,content
	WRITE !
	;	
	QUIT
	;	
create(id,content)
	;
	; ^employees(1)="Washington^Ramos^2700.00^SD"
	;
	SET operationName="Create"
	SET ok=$$create^employee(id,content)
	DO showResult(operationName,ok,id,^employees(id))
	;
	QUIT
	;	
fetch(id)
	;
	SET operationName="Fetch"
	SET ok=$$fetch^employee(id,.data)
	DO showResult(operationName,ok,id,^employees(id))
	;
	QUIT
	;	
update(id,content) 
	;
	SET operationName="Update"
	SET ok=$$update^employee(id,content)
	DO showResult(operationName,ok,id,^employees(id))
	;	
	QUIT
	;
delete(id)
	;
	SET operationName="Delete"
	SET ok=$$delete^employee(id)
	DO showResult(operationName,ok,id,"")
	;	
	QUIT
	;
fetchProp(id,propertyName)
	;
	SET operationName="fetch by Property"
	SET content=$$fetchProp^employee(id,propertyName)
	DO showResult(operationName,ok,id,content)
	;	
	QUIT
	;
; Drop Database
	;
	;SET ok=$$drop^database()
	;IF ok=TRUE DO
	;. WRITE !,"Database successfully Dropped!",!
	;ELSE  DO
	;. WRITE !,"Whoops! The Database could not be Dropped.",!
	;