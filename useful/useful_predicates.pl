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
   
my_include(Func, [H], Res):-
    F =.. [Func, H],
    (F -> [H] = Res
    ;
    [] = Res).

my_include(Func, [H|T], [H|Res]):-
    F =.. [Func, H], F,
    my_include(Func, T, Res).

my_include(Func, [_|T], Res):-
    my_include(Func, T, Res).
