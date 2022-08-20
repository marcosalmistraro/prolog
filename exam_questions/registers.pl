/* representing a set of N registers as a list of length N
[r1, r2, r3, rn] with N = 4

representing a set of actions as a list of functors representing them
e.g. [copy(1,2), swap(2,3)] */

% implement action/3 for copy
action(Registers, Action, ResultRegisters):-
    Action = copy(OriginIndex),
    valid_indexes_copy(OriginIndex, Registers),
    find_value(Registers, OriginIndex, OriginValue),
    get_target_index(OriginIndex, TargetIndex, Registers),
    assign_value(OriginValue, TargetIndex, Registers, ResultRegisters).

% implement action/3 for swap
action(Registers, Action, ResultRegisters):-
    Action = swap(Index1, Index2),
    valid_indexes_swap(Index1, Index2, Registers),
    find_value(Registers, Index1, Value1),
    find_value(Registers, Index2, Value2),
    assign_value(Value1, Index2, Registers, TmpRegisters),
    assign_value(Value2, Index1, TmpRegisters, ResultRegisters).

get_target_index(OriginIndex, TargetIndex, Registers):-
    length(Registers, N),
    OriginIndex < N, 
    TargetIndex is OriginIndex + 1.

get_target_index(OriginIndex, TargetIndex, Registers):-
    length(Registers, N),
    OriginIndex = N, 
    TargetIndex is 1.

valid_indexes_copy(Index, Registers):-
    length(Registers, N),
    1 =< Index,
    Index =< N.

valid_indexes_swap(Index1, Index2, Registers):-
    length(Registers, N),
    1 =< Index1,
    Index1 < Index2, 
    Index2 =< N.

find_value(Registers, Index, Value):-
    is_prefix(SubRegisters, Registers, Index),
    get_last_value(SubRegisters, Value).

is_prefix(L1, L2, Length):-
    append(L1, _, L2),
    length(L1, Length).

get_last_value(List, Value):-
    length(List, Length),
    Length1 is Length - 1,
    is_prefix(List1, List, Length1),
    append(List1, [Value], List).

assign_value(OriginValue, TargetIndex, Registers, ResultRegisters):-
    Index1 is TargetIndex - 1,
    is_prefix(UnchangedRegisters, Registers, Index1),
    append(UnchangedRegisters, [_|RestRegisters], Registers),
    append(UnchangedRegisters, [OriginValue|RestRegisters], ResultRegisters).

generate_instructions(Registers, List):-
    generate_copy(Registers, ListCopy),
    generate_swap(Registers, ListSwap),
    append(ListCopy, ListSwap, List).

generate_numbers(1, [1]).
generate_numbers(N, [N|T]):-
    N > 1,
    N1 is N - 1, 
    generate_numbers(N1, T).

generate_copy(Registers, List):-
    length(Registers, N),
    generate_numbers(N, Indexes),
    findall(copy(Index),
        member(Index, Indexes),
        List).

generate_swap(Registers, List):-
    length(Registers, N),
    generate_numbers(N, Indexes),
    findall(swap(Index1, Index2),
        (member(Index1, Indexes),
        member(Index2, Indexes),
        Index1 < Index2),
        List).

check_sequence(StartRegisters, [Action], EndRegisters):-
    action(StartRegisters, Action, EndRegisters).

check_sequence(StartRegisters, [H|Sequence], EndRegisters):-
    action(StartRegisters, H, TmpRegisters),
    check_sequence(TmpRegisters, Sequence, EndRegisters).