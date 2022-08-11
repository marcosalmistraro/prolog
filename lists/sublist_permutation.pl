% in how many ways can a N-length sublist of a list be extracted?

perm([], []).
perm([H|T], Perm):-
    perm(T, PermT),
    select(H, Perm, PermT).

is_sublist([H], List):-
    member(H, List).
is_sublist([H|Sub], List):-
    member(H, List),
    select(H, List, TmpList),
    is_sublist(Sub, TmpList).
    
extract(N, List, Res):-
    is_sublist(SubList, List),
    length(SubList, N),
    perm(SubList, Res).

% only extract unique permutations of the N-length sublist
extract_all(N, List, ListSubs):-
    setof(SubList,
        extract(N, List, SubList),
        ListSubs).