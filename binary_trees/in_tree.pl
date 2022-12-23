/* intree/2 predicate to verify whether a given element is contained 
in an ordered binary tree. An ordered binary tree is a data structure 
satisfying the following conditions:

 - The internal nodes all store a key greater than all the keys in the their left subtree.
 - The key also has to be less than the keys in the right subtree. */

intree2(V, t(_,V,_)).
intree2(V, t(L,X,_)):-
    V < X,
    intree2(V, L).
intree2(V, t(_,X,R)):-
    V > X,
    intree2(V, R).