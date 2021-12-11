/* incrementing every element of a list using difference lists */

increment_dl([], T-T).
increment_dl([X], [Res|T]-T):-
    Res is X + 1.
increment_dl([H|T], L1-L3):-
    increment_dl([H], L1-L2),
    increment_dl(T, L2-L3), !.