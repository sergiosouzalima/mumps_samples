	;
	; Count and show chess pieces on a chessboard. ;
	;
	; File mame: chessboard.m
	; Author: Sergio Lima (Jan, 30 2022)
	; How to run: mumps -r ^chessboard
	;
	; Made with GT.M Mumps for Linux. ;
	;
	; Considering:
	; Pawn		.....	code 1, max quantity: 8
	; Bishop	..... 	code 2, max quantity: 2
	; Knight	.....	code 3, max quantity: 2
	; Rook		.....	code 4, max quantity: 2
	; Queen		.....	code 5, max quantity: 1
	; King		.....	code 6, max quantity: 1
	; Empty		.....	code 0
	;
	WRITE !,"Chessboard Pieces Counter",!
	;
	DO Initialize
	DO loadPieces
	DO loadChessBoard
	DO showChessBoard
	DO countPiecesOnChessBoard
	DO showPieces
	DO Finalize
	QUIT
	;
Initialize
	;
	SET TRUE=1,FALSE=0,(COLS,ROWS)=8
	FOR row=1:1:ROWS FOR col=1:1:COLS SET board(col,row)=0
	QUIT
	;
Finalize
	;
	W !!
	QUIT
	;
loadPieces
	;
	SET pieces(0)="Null^0"
	SET pieces(1)="Pawn^0",pieces(2)="Bishop^0",pieces(3)="Knight^0"
	SET pieces(4)="Rook^0",pieces(5)="Queen^0",pieces(6)="King^0"
	QUIT
	;
loadChessBoard
	;
	; There are 4 Pawns, 2 Queens, 1 King,
	; 			3 Bishops, 3 Rooks on the chessboard
	;
	; 0 0 2 5 0 2 0 4
	; 0 0 0 0 0 0 0 0
	; 0 0 0 0 0 0 0 0
	; 0 0 0 1 1 0 0 0
	; 0 0 0 1 1 0 0 0
	; 0 0 0 0 0 0 0 0
	; 0 0 0 0 0 0 0 0
	; 4 0 0 5 6 2 0 4
	;
	SET board(4,4)=1,board(5,4)=1
	SET board(4,5)=1,board(5,5)=1
	;
	SET board(3,1)=2,board(4,1)=5
	SET board(6,1)=2,board(8,1)=4
	;
	SET board(4,8)=5,board(5,8)=6
	SET board(1,8)=4,board(6,8)=2,board(8,8)=4
	;
	QUIT
	;
showPieces
	;
	WRITE !,"Pieces",!
	FOR i=1:1 QUIT:'$DATA(pieces(i))  DO showPiece(pieces(i)) WRITE !
	QUIT
	;
showPiece(piece)
	;
	SET name=$PIECE(piece,"^",1)
	SET quantity=$PIECE(piece,"^",2)
	WRITE name_": "_quantity_" piece(s)"
	QUIT
	;
showChessBoard
	;
	SET showRow=0
	WRITE !,"Chessboard"
	WRITE !,"   1 2 3 4 5 6 7 8"
	FOR row=1:1:ROWS S showRow=showRow+1 W !,showRow,") " FOR col=1:1:COLS WRITE board(col,row)," "
	WRITE !
	QUIT
	;
countPiecesOnChessBoard
	;
	SET pieceCode=0
	FOR col=1:1 QUIT:'$ORDER(board(col,""))  FOR row=1:1 QUIT:'$DATA(board(col,row))  DO addPiece(board(col,row))
	QUIT
	;
addPiece(pieceCode)
	;
	SET name=$PIECE(pieces(pieceCode),"^",1)
	SET quantity=$PIECE(pieces(pieceCode),"^",2)
	SET quantity=quantity+1
	SET pieces(pieceCode)=name_"^"_quantity
	QUIT
	;