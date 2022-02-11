	;
	SET SEP="^"
	SET TRUE=1,FALSE=0
	;	
fetch(id,data)
	NEW record
	KILL data
	IF id="" QUIT FALSE
	SET record=$get(^departments(id))
	SET data("name")=$piece(record,SEP,1)
	QUIT TRUE
	;
fetchProp(id,propertyName)
	IF id="" QUIT ""
	SET ok=$$fetch(id,.data)
	IF ok=TRUE QUIT data(propertyName)
	IF ok=FALSE QUIT ""
	;
fetchName(id)
	NEW name
	IF id="" QUIT ""
	SET name=$$fetchProp(id,"name")
	IF ok=TRUE QUIT name
	IF ok=FALSE QUIT ""
	;
set(id,data)
	IF id="" QUIT FALSE
	SET name=$piece(data,SEP,1)
	SET ^departments(id)=name
	QUIT TRUE
	;
remove(id)
	IF id="" QUIT FALSE
	KILL ^departments(id)
	QUIT TRUE