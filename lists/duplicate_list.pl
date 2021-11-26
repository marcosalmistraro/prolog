/* duplicate the elements of a list a given number of times */

duplicate(1, [A], [A]):- !.

duplicate(N, [A], [A|Res]):-
    N1 is N - 1, N1 > 0,
    duplicate(N1, [A], Res), !.

duplicate(N, [H|T], Res):-
    duplicate(N, [H], HRes),
    duplicate(N, T, TRes),
    append(HRes, TRes, Res), !.