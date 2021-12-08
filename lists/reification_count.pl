/* using reification to count occurrencies of an element in a list */

:- use_module(library(clpfd)).

is_head(X, [H|_]):-
    V #<==> H #= X,
    V #= 1.

occur_n_times(X, List, 0):-
    \+ member(X, List), !.

occur_n_times(X, [H|T], N):-
    \+ is_head(X, [H|T]),
    occur_n_times(X, T, N), !.

occur_n_times(X, [H|T], N):-
    is_head(X, [H|T]),
    N1 #= N - 1,
    occur_n_times(X, T, N1), !.