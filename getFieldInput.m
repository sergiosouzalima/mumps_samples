	; 
	; It creates a field to read and set data to a variable;
	;
	; File mame: getFieldInput. ;
	; Author: Sergio Lima (Mar, 26 2023)
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
OBT(C,L,T,CM,LM,VTPARAM)
	;
	; VTPARAM: Vetor para recebimento de parametros. ;
	; Parametros:
	N IEXRG    ; Indicador para ativar expressao regular
	N EXPREG   ; Expressao regular
	N IMSGERRO ; Indicador para ativar mensagem de erro
	N MSGERRO  ; Mensagem de erro de preenchimento
	N IMSGINF  ; Indicador para ativar mensagem de orientacao para preenchimento do campo
	N MSGINF   ; Mensagem de orientacao para preenchimento do campo
	N IMANDTR  ; Indicador para ativar campo mandatorio
	N MSGMAND  ; Mensagem para avisar que o campo e' mandatorio
	;
	N CAMPO
	;
	S (IEXRG,IMSGERRO,IMSGINF,IMANDTR)=0
	S MSGINF="Informe o campo corretamente."
	S MSGERRO="Valor invalido. Tente novamente."
	S MSGMAND="Campo de preenchimento obrigatorio."
	S EXPREG=""
	;
	; Ajusta valores iniciais
	I $G(VTPARAM("EXPREG"))'="" S IEXRG=1,EXPREG=VTPARAM("EXPREG") ; Ajuste para expressao regular
	I $G(VTPARAM("IMANDTR"))'="" S IMANDTR=VTPARAM("IMANDTR")      ; Ajuste para campo mandatorio
	I $G(VTPARAM("IMSGINF"))'="" S IMSGINF=VTPARAM("IMSGINF")      ; Ajuste para msg de pre-preenchimento
	I IMSGINF I $G(VTPARAM("MSGINF"))'="" S MSGINF=VTPARAM("MSGINF")
	I $G(VTPARAM("IMSGERRO"))'="" S IMSGERRO=VTPARAM("IMSGERRO")   ; Ajuste para mensagem de erro de preenchimento
	I IMSGERRO I $G(VTPARAM("MSGERRO"))'="" S MSGERRO=VTPARAM("MSGERRO")
	;
	S FIMLER=0
	F  Q:FIMLER  D
	. I IMSGINF D POS(CM,LM) W $J(" ",80) D POS(CM,LM) W MSGINF
	. D POS(C,L) W $J(" ",T+1) D POS(C,L)
	. S CAMPO=""
	. D LECAMPO(.CAMPO,T) ; Leitura do campo
	. I CAMPO="." S FIMLER=1 Q
	. I ('IMANDTR)&('IEXRG) S FIMLER=1 Q ; Campo nao e' mandatorio e nao tem expressao regular, nao tem o que validar.... ;
	. I ('IMANDTR)&($L(CAMPO)=0) S FIMLER=1 Q ; Campo nao e' mandatorio e esta vazio, nao tem o que validar.... 	
	. D VALID(CAMPO,.FIMLER,IEXRG,EXPREG,IMANDTR,IMSGERRO,MSGERRO) ; Validacao
	. D POS(CM,LM) W $J(" ",80)
	;
FOBT Q CAMPO
	;
LECAMPO(CAMPO,TAM)
	N TIMEOUT
	S TIMEOUT=10
	R CAMPO#TAM+1:TIMEOUT	
	;
FLECAMPO Q 
	;
VALID(CAMPO,FIMLER,IEXRG,EXPREG,IMANDTR,IMSGERRO,MSGERRO) ; Leitura e Validacao
	N CMPVALID,CMPVAZIO
	S CMPVALID=0
	S CMPVAZIO=0
	S FIMLER=1
	;
	S CMPVAZIO=($L(CAMPO)=0)
	I (IMANDTR)&(CMPVAZIO) D  Q
	. D POS(CM,LM) W $J(" ",80) D POS(CM,LM) W MSGMAND_"<ENTER>" R X D POS(C,L)
	. S FIMLER=0
	;
	I IEXRG D  Q
	. S CMPVALID=(CAMPO?@(EXPREG))
	. I ('CMPVALID)&(IMSGERRO) D POS(CM,LM) W $J(" ",80) D POS(CM,LM) W MSGERRO_"<ENTER>" R X D POS(C,L)
	. I 'CMPVALID S FIMLER=0
	;
FOBT1 Q
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
	S VTPAR("EXPREG")="5E.25E"
	S VTPAR("IMANDTR")=1
	S VTPAR("IMSGINF")=1
	S VTPAR("MSGINF")="Informe nome de 5 a 30 caracteres."
	S VTPAR("IMSGERRO")=1
	S VTPAR("MSGERRO")="Valor invalido. Informe nome de 5 a 30 caracteres."
	S NOVO=$$OBT(30,10,TAM,10,20) ;,.VTPAR)
	;
	W !
	W NOVO
	W !
	;
FTEST Q