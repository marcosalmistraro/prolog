/* preorder/2 predicate outputting a given tree as a list.
The list contains, in the order: root, left subtree, right subtree. */

preorder(nil, []).
preorder(L-Root+R, Res):-
    preorder(L, ListL),
    preorder(R, ListR),
    append(ListL, ListR, TmpRes),
    append(Root, TmpRes, Res).

% Implementing the same predicate using difference lists.

preorder_dl(nil, L-L).
preorder_dl(L-(L1-L2)+R, L1-L4):-
    preorder_dl(L, L2-L3),
    preorder_dl(R, L3-L4).