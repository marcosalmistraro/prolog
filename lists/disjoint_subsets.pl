/* In how many ways can a list of N items be subdivided 
into 3 disjoint sublists of lengths L1, L2 and L3?
The predicate generates all the possibilities via backtracking. */

group(List, [L1, L2, L3], Res):-
    is_sublist(List1, List),
    length(List1, L1),
    is_sublist(List2, List),
    length(List2, L2),
    is_sublist(List3, List),
    length(List3, L3),
    disjoint_sets(List1, List2),
    disjoint_sets(List1, List3),
    disjoint_sets(List2, List3),
    Res = [List1, List2, List3].

is_sublist([], _).
is_sublist([H|Sub], List):-
    member(H, List),
    select(H, List, TmpList),
    is_sublist(Sub, TmpList).

disjoint_sets([], _).
disjoint_sets([H|Set1], Set2):-
    not(member(H, Set2)),
    disjoint_sets(Set1, Set2).