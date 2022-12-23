% Inverting a list using difference lists

invert_dl([], L-L).
invert_dl([X], [X|L]-L).
invert_dl([H|T], L1-L3):-
    invert_dl(T, L1-L2),
    invert_dl([H], L2-L3), !.