divisors(X,Y):-
	X>0,
	dividesless(X,X,Y).

dividesless(_,1,[1]).
dividesless(X, I, [I|B]):-
	I1 is I-1,
	divides(I,X),
	dividesless(X,I1,B).
dividesless(X, I, B):-
	not(divides(I,X)),
	I1 is I-1,
	dividesless(X,I1,B).

divides(X,Y):-
	Y mod X=:=0.


prime(X):-
	divisors(X,[_,_|[]]).
primelist(2,[2]).
primelist(I, [I|B]):-
	I>2,
	prime(I),
	I1 is I-1,
	primelist(I1,B).
primelist(I, B):-
	I>2,
	not(prime(I)),
	I1 is I-1,
	primelist(I1,B).