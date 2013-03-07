elimreps([X|[]],[X]).
elimreps([X|Y],B):-
	contains(X,Y),
	elimreps(Y,B).
elimreps([X|Y],[X|B]):-
	not(contains(X,Y)),
	elimreps(Y,B).