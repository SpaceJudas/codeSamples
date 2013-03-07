powerset([],[[]]).
powerset([H|Tl],L)  :-
	powerset(Tl,L1),
	appendtoEach([H],L1,L2),
	append(L1,L2,L).

appendtoEach(X,[H0|[]],[H1]):-
	append(X,H0,H1).
appendtoEach(X,[H0|Tl0],[H1|Tl1]):-
	append(X,H0,H1),
	appendtoEach(X,Tl0,Tl1).

append([], L, L).
append([X|L1],L2,[X|L3]):-
      append(L1,L2,L3).