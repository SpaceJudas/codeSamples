:- use_module(library(clpfd)).

/* Defines the sudoku board in terms of a matrix written as a list of
   the rows of the sudoku */
sudoku(RowBoard):-
%Flattens the board for easy use with domain constraints
	flatten(RowBoard, FlatBoard),
	FlatBoard ins 1..9,

%Constrains all members of the rows to be different from each other
	constrainListDifferent(RowBoard).
	
%Constrains all members of the columns to be different from each other
	transpose(RowBoard,ColBoard),
	constrainListDifferent(ColBoard).

%Defines all members so that boxes can be explicitly defined
	RowBoard = [[X11,X12,X13,X14,X15,X16,X17,X18,X19],
		    [X21,X22,X23,X24,X25,X26,X27,X28,X29],
		    [X31,X32,X33,X34,X35,X36,X37,X38,X39],
		    [X41,X42,X43,X44,X45,X46,X47,X48,X49],
		    [X51,X52,X53,X54,X55,X56,X57,X58,X59],
		    [X61,X62,X63,X64,X65,X66,X67,X68,X69],
		    [X71,X72,X73,X74,X75,X76,X77,X78,X79],
		    [X81,X82,X83,X84,X85,X86,X87,X88,X89],
		    [X91,X92,X93,X94,X95,X96,X97,X98,X99]],
%Constrains all members of the boxes to be different from each other
	all_different([X11,X12,X13,X21,X22,X23,X31,X32,X33]),
	all_different([X41,X42,X43,X51,X52,X53,X61,X62,X63]),
	all_different([X71,X72,X73,X81,X82,X83,X91,X92,X93]),
	all_different([X14,X15,X16,X24,X25,X26,X34,X35,X36]),
	all_different([X44,X45,X46,X54,X55,X56,X64,X65,X66]),
	all_different([X74,X75,X76,X84,X85,X86,X94,X95,X96]),
	all_different([X17,X18,X19,X27,X28,X29,X37,X38,X39]),
	all_different([X47,X48,X49,X57,X58,X59,X67,X68,X69]),
	all_different([X77,X78,X79,X87,X88,X89,X97,X98,X99]),
%Tries to unify all elements of the FlatBoard with its domain based
%on the previously defined constraints
	label(FlatBoard). 

constrainListDifferent([]).
constrainListDifferent([H|Tl]):-
	all_different(H), constrainListDifferent(Tl).
/* Takes the rows of a matrix and makes them the columns of a new matrix.
   In sudoku, this makes comparison against the columns quick and painless */
transpose([Lst], Cols) :- !,
	listToCol(Lst, Cols).
transpose([H|Tl], Cs) :- !,
	transpose(Tl, Cs0),
	putCols(H, Cs0, Cs).

/* listToCol takes a list and puts its elements in the columns of a matrix
   This is a helper method for transpose/2 */
listToCol([], []).
listToCol([X|Xs], [[X]|Zs]) :- listToCol(Xs, Zs).

/* putCols puts a given list into the head of the columns of a matrix.
   This is a helper method for transpose/2 */
putCols([], Cs, Cs).
putCols([X|Xs], [C|Cs0], [[X|C]|Cs]) :-
	putCols(Xs, Cs0, Cs).

/* renamed from printMatrix */
printSudoku([]).
printSudoku([H|Tl]) :-
	write(H),nl,
	printSudoku(Tl).

testSudoku :-
	Sud=[[_,6,_,1,_,4,_,5,_],
	     [_,_,8,3,_,5,6,_,_],
	     [2,_,_,_,_,_,_,_,1],
	     [8,_,_,4,_,7,_,_,6],
	     [_,_,6,_,_,_,3,_,_],
	     [7,_,_,9,_,1,_,_,4],
	     [5,_,_,_,_,_,_,_,2],
	     [_,_,7,2,_,6,9,_,_],
	     [_,4,_,5,_,8,_,7,_]],
	sudoku(Sud),
	printSudoku(Sud).