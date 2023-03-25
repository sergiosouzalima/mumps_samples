	; 
	; It creates a field to read and set data to a variable;
	;
	; File mame: getFieldInput.m
	; Author: Sergio Lima (Mar, 25 2023)
	;
	; ---
	; If needed:
	; ln -s /home/sergio/workspace/github/sergiosouzalima/mumps_samples/*.m ~/.fis-gtm/V6.3-007_x86_64/r
	; ---
	; How to run: mumps -r INI^getFieldInput
	; How to run: mumps -r TEST^getFieldInput
	;
	; Made with GT.M Mumps for Linux. ;
	;
INI ;
	W "It creates a field to read and set data to a variable.",!!
	D PROCESS
	W "***",!
	Q
	;
OBT(C,L,T,CM,LM,CAMPO,ATMSGER,MSGER,ATMSGINF,MSGINF,EXPREG,ATVALINI)
	;
	; ATMSGER =1 Ativa mostrar mensagem de preenchimento errado
	;         =0 Nao mostra mensagem de preenchimento errado (default)
	; MSGER   =  Mensagem caso o preenchimento esteja errado
	;         =  "Valor preenchido incorretamente. Tente de novo." (default)
	;
	; ATMSGINF=1 Ativa mostrar mensagem de informacao para preenchimento
	;         =0 Nao mostra mensagem de informacao para preenchimento (default)
	; MSGINF  =  Mensagem de informacao para preenchimento
	;         =  "Preencha o campo corretamente." (default)
	; 
	; EXPREG  = Expressao regular para validar esse campo
	;         = Sem expressao regular. (default)
	;
	; ATVALINI=1 Ativa assumir valor inicial do campo caso usuario saia com "."
	;         =0 Nao assumir valor inicial do campo (default)
	;
	N NOVCAMP,TIMEOUT,CMDSAI,TAMCAMP
	S NOVCAMP="",TIMEOUT=10,CMDSAI=""
	; Ajuste de valores default para os parametros
	S ATMSGER=$G(ATMSGER,0),MSGER=$G(MSGER) 
	I MSGER="" S MSGER="Valor preenchido incorretamente. Tente de novo."
	S ATMSGINF=$G(ATMSGINF,0),MSGINF=$G(MSGINF) 
	I MSGINF="" S MSGINF="Preencha o campo corretamente."
	S EXPREG=$G(EXPREG),ATEXRG=1 I EXPREG="" S ATEXRG=0
	S ATVALINI=$G(ATVALINI,0)
	;	
	I ATMSGINF D POS(CM,LM) W MSGINF
	D POS(C,L)
	;
	S INVALCMP=1
	S CMDSAI=0
	F  Q:'INVALCMP!(CMDSAI)  D
	. R NOVCAMP#T+1:TIMEOUT
	. S CMDSAI=(NOVCAMP=".")
	. Q:CMDSAI
	. S TAMCAMP=$L(NOVCAMP)
	. S INVALCMP=0
	. I ATEXRG D
	. . S INVALCMP='(NOVCAMP?@(EXPREG))
	. I INVALCMP D 
	. . I ATMSGER D POS(CM,LM) W MSGER_" <ENTER>" R X
	. . D POS(CM,LM) W $J(" ",80)
	. . I ATMSGINF D POS(CM,LM) W MSGINF
	. . S NOVCAMP=""
	. . D POS(C,L) W $J(" ",T) D POS(C,L)
	I CMDSAI&(ATVALINI) S NOVCAMP=CAMPO
	;
FOBT Q NOVCAMP
	;
POS(C,L)
	U $i:(X=C:Y=L)
FPOS Q
	;	
TEST ;
	; 
	W #
	D POS(10,10)
	W "Entre com um valor:"
	S TAM=30,NOVO="",NOME="SERGIO"
	S ATMSGER=1
	S MSGER="Valor invalido. Informe nome de 5 a 30 caracteres."
	S ATMSGINF=1
	S MSGINF="Informe nome de 5 a 30 caracteres."
	S ATVALINI=1
	S NOVO=$$OBT(30,10,TAM,10,20,NOME,ATMSGER,MSGER,ATMSGINF,MSGINF,"5E.25E",ATVALINI)
	;
	W !
	W NOVO
	W !
	;
FTEST Q