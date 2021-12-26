/* check if a binary tree is a binary dictionary, that is, sorted */

linearize(X, List):-
    X = nil -> List = []
    ;
    atomic(X),
    List = [X].

linearize(t(L,X,R), [X|List]):-
    linearize(L, ListL),
    linearize(R, ListR),
    append(ListL, ListR, List).

max_value([H], H):- !.
max_value([H1, H2|T], Max):-
    H1 =< H2 -> max_value([H2|T], Max)
    ;
    max_value([H1|T], Max).

min_value([H], H):- !.
min_value([H1, H2|T], Min):-
    H1 >= H2 -> min_value([H2|T], Min)
    ;
    min_value([H1|T], Min).

sorted_tree(nil).
sorted_tree(A):- integer(A).
sorted_tree(t(nil,X,R)):- 
    integer(X), integer(R),
    X < R.
sorted_tree(t(L,X,nil)):- 
    integer(L), integer(X),
    L < X.
sorted_tree(t(L,X,R)):-
    integer(L), integer(X), integer(R),
    L < X,
    X < R.

sorted_tree(t(L,X,R)):-
    linearize(L, FlatL),
    max_value(FlatL, MaxL),
    MaxL < X,
    linearize(R, FlatR),
    min_value(FlatR, MinR),
    MinR > X,
    sorted_tree(L),
    sorted_tree(R), !.