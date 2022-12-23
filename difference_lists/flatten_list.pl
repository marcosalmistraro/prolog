% Flattening a list by using difference lists

flatten_dl([], L-L).
flatten_dl(X, [X|L]-L):-
    atomic(X), X \= [].
flatten_dl([H|T], L1-L3):-
    flatten_dl(H, L1-L2),
    flatten_dl(T, L2-L3).