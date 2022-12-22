% Sorting a list of lists according to sublist length.

shortest_list([A], A).
shortest_list([H|T], H):-
    shortest_list(T, MinT),
    length(H, LengthH),
    length(MinT, LengthMinT),
    LengthH =< LengthMinT, !.
shortest_list([H|T], MinT):-
    shortest_list(T, MinT),
    length(H, LengthH),
    length(MinT, LengthMinT),
    LengthH > LengthMinT, !.

sub_sort([], []).
sub_sort(List, Res):-
    shortest_list(List, Shortest),
    select(Shortest, List, NewList),
    sub_sort(NewList, NewSorted),
    append([Shortest], NewSorted, Res), !.