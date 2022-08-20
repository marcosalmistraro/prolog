/* is_balanced/1 predicate to verify whether a given binary tree is balanced.
Balanced means that the depths of the left and right subtrees at any node differ by at most 1 */

is_balanced(nil).
is_balanced(t(L, _, R)):-
    depth(L, DepthL),
    depth(R, DepthR),
    abs(DepthR - DepthL) =< 1,
    is_balanced(L),
    is_balanced(R).