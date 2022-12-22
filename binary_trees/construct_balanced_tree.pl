/* Constructing all balanced binary trees with a given number of nodes.
A balanced tree is a tree where all left and right subtrees 
differ by at most 1 in length. */

cbal(1, t(nil, _, nil)).
cbal(2, t(L, _, R)):-
    L = t(nil, _, nil), R = nil
    ;
    R = t(nil, _, nil), L = nil.
cbal(N, t(L, _, R)):-
    N > 0,
    N1 is N-1,
    cbal(N1, L),
    cbal(N1, R).