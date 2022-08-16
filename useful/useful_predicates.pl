my_append([], X, X).
my_append([H1|T1], L2, [H1|Res]):-
    my_append(T1, L2, Res).

my_member(X, [Y|T]):-
    X = Y
    ;
    my_member(X, T).

length_list(List, Length):- length_list_acc(List, 0, Length).

length_list_acc([], Length, Length).
length_list_acc([_|T], Acc, Length):-
    Acc1 is Acc + 1,
    length_list_acc(T, Acc1, Length).
   
my_include(Func, [H], [H]):-
    Goal =.. [Func, H],
    Goal.
my_include(Func, [H], []):-
    Goal =.. [Func, H],
    not(Goal).
my_include(Func, [H|T], [H|Res]):-
    Goal =.. [Func, H],
    Goal,
    my_include(Func, T, Res).
my_include(Func, [H|T], Res):-
    Goal =.. [Func, H],
    not(Goal),
    my_include(Func, T, Res).

my_maplist(Func, [H]):-
    F =.. [Func, H],
    F, !.
my_maplist(Func, [H|T]):-
    F =.. [Func, H], F,
    my_maplist(Func, T), !.
my_maplist(Func, [H], [Res]):-
    F =.. [Func, H, Res],
    F, !.
my_maplist(Func, [H|T], [Res|Rest]):-
    F =.. [Func, H, Res], F,
    my_maplist(Func, T, Rest), !.
  
my_not(P):-
    P, !, 
    fail
    ; 
    true.

my_once(P):-
    P, !.

my_select(X, [X], []).
my_select(X, [X|T], T).
my_select(X, [H|T], [H|Res]):-
    my_select(X, T, Res).

permutations([H], [H]).
permutations([H|T], Perm):-
    permutations(T, TmpPerm),
    select(H, Perm, TmpPerm).