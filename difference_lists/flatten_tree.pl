% Flattening a binary tree using difference lists

flatten_tree_dl(nil, L-L).
flatten_tree_dl(t(L, X, R), L3-L1):-
    flatten_tree_dl(L, L1-L2),
    flatten_tree_dl(R, [X|L2]-L3).