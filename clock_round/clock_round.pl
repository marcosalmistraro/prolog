clock_round(N, Sum, Tuple):-
    generate_numbers(N, Numbers),
    generate_tuple(Numbers, Tuple),
    check_triplets(Tuple, Sum).

generate_numbers(1, [1]).
generate_numbers(N, [N|T]):-
    N > 0,
    N1 is N - 1,
    generate_numbers(N1, T).

perm([], []).
perm([H|T], Perm):-
    perm(T, PermT),
    select(H, Perm, PermT).

generate_tuple(Numbers, Tuple):-
    perm(Numbers, Tuple).

is_prefix(Prefix, List):-
    append(Prefix, _, List).

is_suffix(Suffix, List):-
    append(_, Suffix, List).

consecutive_elements([A, B, C], List):-
    is_prefix(Prefix, List),
    append(Prefix, [A], TmpList1),
    append(TmpList1, [B], TmpList2),
    append(TmpList2, [C], TmpList3),
    is_suffix(Suffix, List),
    append(TmpList3, Suffix, List).

all_less_than([H], Sum):-
    list_sum(H, SumH),
    SumH < Sum.

all_less_than([H|T], Sum):-
    list_sum(H, SumH),
    SumH < Sum,
    all_less_than(T, Sum).

list_sum([H], H).
list_sum([H|T], Sum):-
    list_sum(T, TmpSum),
    Sum is TmpSum + H.
    
check_triplets(Tuple, Sum):-
    findall(Triplet,
    consecutive_elements(Triplet, Tuple),
    Triplets),
    all_less_than(Triplets, Sum).

rotation(Tuple, Rotated):-
    is_prefix(Prefix, Tuple),
    Prefix \= [],
    append(Prefix, LeftOver, Tuple),
    LeftOver \= [],
    append(LeftOver,Prefix, Rotated).

anticlockwise(Tuple, Inverted):-
    inverse_acc(Tuple, [], Inverted).

inverse_acc([], Acc, Acc).
inverse_acc([H|T], Acc, Inverted):-
    inverse_acc(T, [H|Acc], Inverted).