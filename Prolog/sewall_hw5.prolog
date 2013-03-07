%%
% Insertion Sort
%%
isort([], []).
isort([H|Tl], Sortedlist):-
	isort(Tl, TailSort),
	insert_in_place(H, TailSort, Sortedlist).

insert_in_place(Item, [], [Item]).
insert_in_place(Item, [H|Tl], [Item|L]):-
	Item=<H,
	insert_in_place(H, Tl, L).
insert_in_place(Item, [OldH|OldTl], [OldH|NewTl]):-
	Item>OldH,
	insert_in_place(Item, OldTl, NewTl).

%%
% Merge Sort (merge algorithm needs work)
%%
mergesort([], []).
mergesort([H], [H]).
mergesort(Lst, Mlist):-
	split(Lst, L, R),
	mergesort(L,Lsort),
	mergesort(R, Rsort),
	merge(Lsort, Rsort, Mlist).

merge([], Rsort, Rsort).
merge(Lsort, [], Lsort):- isNotEmpty(Lsort).
merge([LHd|LTl], [RHd|RTl], [LHd|MTl]):-
	isNotEmpty([LHd|LTl]), isNotEmpty([RHd|RTl]),
	LHd<RHd,
	merge(LTl, [RHd|RTl], MTl).
merge([LHd|LTl], [RHd|RTl], [RHd|MTl]):-
	isNotEmpty([LHd|LTl]), isNotEmpty([RHd|RTl]),
	LHd>RHd,
	merge([LHd|LTl], RTl, MTl).


split([], [], []).
split([H], [H], []).
split([L,R|Tl], [L|LTl], [R|RTl]):-
	split(Tl, LTl, RTl).
	

myLen([], 0).
myLen([_|[]], 1).
myLen([_|Tl], Len):-
	myLen(Tl, TlLen),
	Len is 1+TlLen.
isEmpty(Lst):-
	myLen(Lst, R),
	R=:=0.
isNotEmpty(Lst):-
	myLen(Lst, R),
	R>0.

%%
% Permute
%%
permute([], []).
permute(Lst, [H2|Tl2]):-
	contains(H2, Lst),
	remove(H2, Lst, NewLst),
	permute(NewLst, Tl2).

contains(Item, [Item|_]).
contains(Item, [_|Tl]):-
	contains(Item, Tl).

remove(_, [], []).
remove(Item, [Item|Tl], Tl).
remove(Item, [H|Tl], [H|NewTl]):-
	Item=\=H,
	remove(Item, Tl, NewTl).

%%
% Show Matrix
%%
showMatrix([]).
showMatrix([H|Tl]):-
	write(H), nl,
	showMatrix(Tl).

%%
% Clump splits L into a matrix of rows of size N
%%
clump(_, [], []).
clump(N, L, [MatH|MatTl]):-
	isNotEmpty(L),
	clumpGroup(N, L, MatH, NewL),
	clump(N, NewL, MatTl).
clumpGroup(N, X, [], X):-
	N=:=0.
clumpGroup(N, [], [], []):-
	N>0.
clumpGroup(N, [H|Tl], [H|NTl], NewL):-
	N>0,
	clumpGroup(N-1, Tl, NTl, NewL).

%%
% pmulc - do each n individually and
%%
pmulc(N, L, ListOfLists):-
	createEmptyLists(N, Init),
	pmulcRec(L, Init, ListOfLists).

%place the hd and
pmulcRec([], F, F).
pmulcRec([Hd|Tl], Init, Final):-
	placeInNext(Hd, Init, Next),
	pmulcRec(Tl, Next, Final).

placeInNext(Item, [InitHd|InitTl], [InitHd|FinalTl]):-
	not(isRectMatrix([InitHd|InitTl])),
	placeInNext(Item, InitTl, FinalTl).

placeInNext(Item, [InitHd|InitTl], [NewHd|InitTl]):-
	isRectMatrix([InitHd|InitTl]),
	append(InitHd,[Item],NewHd).

isRectMatrix([X]):-
	isList(X).
isRectMatrix([Hd1, Hd2|Tl]):-
	myLen(Hd1, Len1),
	myLen(Hd2, Len2),
	Len1=Len2,
	isRectMatrix([Hd2|Tl]).

createEmptyLists(N, [[]]):-N=:=1.
createEmptyLists(N, [[]|Tl]):-
	N>1,
	createEmptyLists(N-1, Tl).

isList([]).
isList([_|Tl]):-
	isList(Tl).

%%
% Transpose!!!!
%%
transpose([H1|Tl], M):-
	isRectMatrix([H1|Tl]),
	flatten([H1|Tl], Temp),
	myLen(H1, N),
	pmulc(N, Temp, M).

%%
% Countries!!!
%%

countries([france,spain,andorra,italy,switzerland]).

color(red).
color(blue).
color(green).
color(yellow).

nbs(X,Y) :- adj(X,Y).
nbs(X,Y) :- adj(Y,X).

adj(spain,france).
adj(spain,andorra).
adj(france,andorra).
adj(france,switzerland).
adj(france,italy).
adj(italy,switzerland).

colorMap(ColorCountries) :-  countries(L),
      colorCountries(L,ColorCountries).

okNbs(c(Country1,Color1),c(Country2,Color2)) :-
	nbs(Country1,Country2),
	Color1\==Color2.
okNbs(c(Country1,_),c(Country2,_)) :-
	not(nbs(Country1,Country2)).

colorCountries([Country], [c(Country, X)]):-
	color(X).
colorCountries([Curr|UncoloredCnt], [c(Curr, Color)|ColoredCnt]):-
	colorCountries(UncoloredCnt, ColoredCnt),
	color(Color),
	okCountries(c(Curr, Color), ColoredCnt).

okCountries(c(_, _), []).
okCountries(New, [Hd|Tl]):-
	okNbs(New, Hd),
	okCountries(New, Tl).