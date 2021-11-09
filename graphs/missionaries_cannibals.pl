/* Graph Problem - Missionaries and cannibals

The adopted implementation follows the pattern explained below to traverse the different states

solve(InitialState, Path):-
    search(InitialState, [InitialState], Path).

search(CurrentState, CurrentPath, Path)
    is_solution(CurrentState),
    Path = CurrentPath.

search(CurrentState, CurrentPath, Path):-
    try_action(CurrenState, NextState),
    validate_state(NextState),
    no_loop(NextState, CurrentPath),
    search(NextState, [NextState|CurrentPath], Path).

3 missionaries and 3 cannibals are walking together through the forest. 
They arrive at a river they have to cross, but there is only one boat, which can carry at most 2 people. 
For the boat to cross the river, there should be at least one person in the boat. 
The issue is that if there are more cannibals than missionaries at any place, those will eat the missionaries. */

initial_state([[m,m,m,c,c,c], []]).

final_state([[], RB]):-
    select(m, RB, RB1),
    select(m, RB1, RB2),
    select(m, RB2, RB3),   
    select(c, RB3, RB4),
    select(c, RB4, RB5),
    select(c, RB5, []), !.

valid_state([LB, RB]):-
    findall(M, (member(M, LB), M=m), MissionariesLB),
    findall(C, (member(C, LB), C=c), CannibalsLB),
    length(MissionariesLB, CountMissionariesLB),
    length(CannibalsLB, CountCannibalsLB),
    (CountCannibalsLB =< CountMissionariesLB
    ;
    CountMissionariesLB = 0), !,
    findall(M, (member(M, RB), M=m), MissionariesRB),
    findall(C, (member(C, RB), C=c), CannibalsRB),
    length(MissionariesRB, CountMissionariesRB),
    length(CannibalsRB, CountCannibalsRB),
    (CountCannibalsRB =< CountMissionariesRB
    ;
    CountMissionariesRB = 0), !.

try_action([LB1, RB1], [LB2, RB2]):-
    (select(Pass1, LB1, LB2),
    append(RB1, [Pass1], RB2))
    ;
    (select(Pass1, LB1, LB1Temp),
    append(RB1, [Pass1], RB1Temp),
    select(Pass2, LB1Temp, LB2),
    append(RB1Temp, [Pass2], RB2)).

no_loop(NextState, CurrentPath):-
    not(member(NextState, CurrentPath)).

search(CurrentState, CurrentPath, Path):-
    final_state(CurrentState),
    Path = CurrentPath.

search(CurrentState, CurrentPath, Path):-
    try_action(CurrentState, NextState),
    valid_state(NextState),
    no_loop(NextState, CurrentPath),
    search(NextState, [NextState|CurrentPath], Path).

solve(InitialState, Path):-
    search(InitialState, [InitialState], Path).