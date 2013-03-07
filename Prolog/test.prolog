t(X,Y):-p(X),q(Y).
tc(X,Y):- p(X), !, q(Y).
p(pa).
p(pb).
q(qa).
q(qb).
r(ra).
r(rb).

max(_,[]).
max(Item, [H|Tl]):-
	Item>=H,
	max(Item, Tl).

select(1,[H|_],H).
select(N,[_|Tl],Item):-
	N1 is N-1,
	select(N1, Tl, Item).

diagonal(_,[],[]).
diagonal(N,[MHd|MTl],[DHd|DTl]):-
	length(MHd, N),
	diagonal(N, MTl, DTl),
	length(DTl, A),
	Selector is N-A,
	select(Selector, MHd, DHd).

isSquare(_,[]).
isSquare(N,[MHd|MTl]):-
	length(MHd, N),
	isSquare(N, MTl).
