% Predicate to rotate a given list by N places to the left

rotateList(N, List, Res):-
    splitList(N, List, Res1, Res2),
    append(Res2, Res1, Res).

splitList(N, List, Res1, Res2):-
    isSublist(Res1, List),
    length(Res1, N),
    append(Res1, Res2, List).

isSublist([], []).
isSublist([H|T], [H|List]):-
    isSublist(T, List).
isSublist(T, [_|List]):-
    isSublist(T, List).