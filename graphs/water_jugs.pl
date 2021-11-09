/* Water jugs Problem

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

You need to get 8 liter of water from a river. 
You only have a 15-liter jug and a 16-liter jug. 
How can you obtain 8 liter using only these two jugs ?
Possible operations are: 
- emptying a jug entirely, 
- filling a jug entirely
- emptying one jug into the other

The program computes the shortest solution. */

generate(0, []):- !.
generate(N, [N|List]):-
    N1 is N-1,
    N1 >= 0,
    generate(N1, List).

final_state([jug15(Content1), jug16(Content2)]):-
    Content1 is 8;
    Content2 is 8.

valid_state([jug15(Content1), jug16(Content2)]):-
    Content1 >= 0,
    Content1 =< 15,
    Content2 >= 0,
    Content2 =< 16.

/* Transfer jug1 into jug2 */

try_action([jug15(Content1), jug16(Content2)], NextState):-
    Content1 > (16 - Content2),
    AmountTransfer is abs(16 - Content2),
    NewContent1 is Content1 - AmountTransfer,
    NewContent2 is Content2 + AmountTransfer,
    NextState = [jug15(NewContent1), jug16(NewContent2)].

try_action([jug15(Content1), jug16(Content2)], NextState):-
    Content1 < (16 - Content2),
    AmountTransfer is Content1,
    NewContent1 is Content1 - AmountTransfer,
    NewContent2 is Content2 + AmountTransfer,
    NextState = [jug15(NewContent1), jug16(NewContent2)].

/* Transfer jug2 into jug1 */

try_action([jug15(Content1), jug16(Content2)], NextState):-
    Content2 > (15 - Content1),
    AmountTransfer is abs(15 - Content1),
    NewContent1 is Content1 + AmountTransfer,
    NewContent2 is Content2 - AmountTransfer,
    NextState = [jug15(NewContent1), jug16(NewContent2)].

try_action([jug15(Content1), jug16(Content2)], NextState):-
    Content2 < (15 - Content1),
    AmountTransfer is Content2,
    NewContent1 is Content1 + AmountTransfer,
    NewContent2 is Content2 - AmountTransfer,
    NextState = [jug15(NewContent1), jug16(NewContent2)].

/* Emptying jug1 entirely */

try_action([jug15(_), jug16(Content2)], NextState):-
    NextState = [jug15(0), jug16(Content2)].

/* Emptying jug2 entirely */

try_action([jug15(Content1), jug16(_)], NextState):-
    NextState = [jug15(Content1), jug16(0)].

/* Filling jug1 entirely */

try_action([jug15(_), jug16(Content2)], NextState):-
    NextState = [jug15(15), jug16(Content2)].

/* Filling jug2 entirely */

try_action([jug15(Content1), jug16(_)], NextState):-
    NextState = [jug15(Content1), jug16(16)].

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

all_paths(InitialState, AllPaths):-
    findall(Path, solve(InitialState, Path), AllPaths).

shortest_list([[]], []):- !.
shortest_list([A], A):- !.
shortest_list([H1, H2|T], Shortest):-
    length(H1, LenghtH1),
    length(H2, LengthH2),
    LenghtH1 < LengthH2,
    shortest_list([H1|T], Shortest).
shortest_list([H1, H2|T], Shortest):-
    length(H1, LenghtH1),
    length(H2, LengthH2),
    LenghtH1 > LengthH2,
    shortest_list([H2|T], Shortest).

find_shortest_path(InitialState, ShortestPath):-
    findall(Path, solve(InitialState, Path), AllPaths),
    shortest_list(AllPaths, ShortestPath).