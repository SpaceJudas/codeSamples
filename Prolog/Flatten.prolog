isList([]).
isList([H|Tl]) :- isList(Tl).

flatten([],[]).
flatten(X, [X]):-
	not(isList(X)).
flatten([X|[]],A):-
	flatten(X,A).
flatten([X|Y],C):-
	flatten(X,A),
	flatten(Y,B),
	append(A,B,C).

contains(X,[X|L]).
contains(X,[H|L]):-
	X=\=H,
	contains(X,L).