% Extracting a slice from a list, given indexes

cut_from_head(N, List, Res):-
    append(TmpList, Res, List),
    N1 is N - 1,
    length(TmpList, N1).

cut_from_tail(N, List, Res):-
    append(Res, TmpList, List),
    length(TmpList, N).

extract(_, _, [], []).
extract(M, N, _, _):- 
    M > N,
    write('Please enter valid index values').
extract(M, N, List, [H]):-
    M = N,
    cut_from_head(M, List, [H|_]).
extract(M, N, List, Slice):-
    M < N,
    length(List, LengthList),
    cut_from_head(M, List, TmpSlice),
    TailIndex is LengthList - N,
    cut_from_tail(TailIndex, TmpSlice, Slice).