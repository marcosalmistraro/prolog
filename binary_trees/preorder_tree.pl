/* write a predicate that outputs a given tree as a list
containing, in the order: root, left subtree, rightsubtree */

preorder(nil, []).
preorder(L-Root+R, Res):-
    preorder(L, ListL),
    preorder(R, ListR),
    append(ListL, ListR, TmpRes),
    append(Root, TmpRes, Res).

% do the same using difference lists

preorder_dl(nil, L-L).
preorder_dl(L-(L1-L2)+R, L1-L4):-
    preorder_dl(L, L2-L3),
    preorder_dl(R, L3-L4).