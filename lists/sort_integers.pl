/* sort list of integers */

minimum_list([A], A).
minimum_list([H|T], H):-
    minimum_list(T, MinT),
    H =< MinT, !.
minimum_list([_|T], Res):-
    minimum_list(T, Res), !.

my_sort([], []).
my_sort([A], [A]).
my_sort([H|L], [H|Res]):-
    minimum_list(L, Min),
    H =< Min,
    my_sort(L, Res), !.
my_sort([H|L], [Min|Res]):-
    minimum_list(L, Min),
    H > Min,
    select(Min, L, NewL),
    my_sort([H|NewL], Res), !.