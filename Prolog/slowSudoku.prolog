% Test Matrix
% [[ 4 , 3 ,X13, 5 ,X15,X16,X17,X18, 7 ],
%  [X21,X22,X23,X24,X25, 4 , 2 , 5 , 9 ],
%  [X31, 5 ,X33, 8 , 6 ,X36,X37, 4 , 3 ],
%  [ 3 ,'_', 7 ,'_','_', 9 ,'_','_','_'],
%  ['_','_', 6 , 4 ,'_', 1 , 7 ,'_','_'],
%  ['_','_','_', 2 ,'_','_', 6 ,'_', 4 ],
%  [ 5 , 1 ,'_','_', 4 , 8 ,'_', 2 ,'_'],
%  [ 8 , 9 , 2 , 3 ,'_','_','_','_','_'],
%  [ 7 ,'_','_','_','_', 5 ,'_', 8 , 1 ]]

doStuff(B):-
	B is [[4,3,_,5,_,_,_,_,7],[_,_,_,_,_,4,2,5,9],[_,5,_,8,6,_,_,4,3],[3,_,7,_,_,9,_,_,_],[_,_,6,4,_,1,7,_,_],[_,_,_,2,_,_,6,_,4],[5,1,_,_,4,8,_,2,_],[8,9,2,3,_,_,_,_,_],[7,_,_,_,_,5,_,8,1]]
	,!,solve(B),
	printSudoku(B).

printSudoku([]).
printSudoku([H|Tl]):-
	write(H), nl,
	printSudoku(Tl).
% Generate row permutations then generate col permutations from the new rows, then generate box permutations from the new cols
% Generate box permutations
solve(Board):-
	Board is [R1,R2,R3,R4,R5,R6,R7,R8,R9],
	%Board is [[X11,X12,X13,X14,X15,X16,X17,X18,X19],[X21,X22,X23,X24,X25,X26,X27,X28,X29],[X31,X32,X33,X34,X35,X36,X37,X38,X39],[X41,X42,X43,X44,X45,X46,X47,X48,X49]],
	Digits is [1,2,3,4, 5, 6, 7, 8, 9],
	genRows(Board, Digits),
	genCols(Board, Digits),
	fixSquares(Board, Digits),
	printSudoku(Board),	

%genRows(Board, Digits):-
%	Board is [R1, R2, R3, R4, R5, R6, R7, R8],
%	permute(R1, Digits),
%	permute(R2, Digits),
%	permute(R3, Digits),
%	permute(R4, Digits),
%	permute(R5, Digits),
%	permute(R6, Digits),
%	permute(R7, Digits),
%	permute(R8, Digits),
%	permute(R9, Digits).

genRows([],_).
genRows([Row|Tl], Digits):-
	permute(Row, Digits),
	genRows(Tl, Digits).

permute([H|Tl], L):-
	member(H, L),
	select(H, L, NewL),
	permute(Tl, NewL).
permute([],[]).