% predicate outputting a sorted list obtained by merging two inputs

sort_list([H], [H]).
sort_list([H|T], [H|Res]):-
    min_list(T, MinT),
    H =< MinT,
    sort_list(T, Res).
sort_list([H|T], [MinT|Res]):- 
    min_list(T, MinT),
    H > MinT,
    select(MinT, [H|T], TmpList),
    sort_list(TmpList, Res).

union_set([], X, X).
union_set([H|T], Set2, [H|Union]):-
    not(member(H, Set2)),
    union_set(T, Set2, Union).
union_set([H|T], Set2, [H|Union]):-
    member(H, Set2),
    select(H, Set2, TmpSet2),
    union_set(T, TmpSet2, Union).

merge_sort(Set1, Set2, Res):-
    union_set(Set1, Set2, TmpRes),
    sort_list(TmpRes, Res).