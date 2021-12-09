/* Knight's Tour puzzle 

How can a knight move around an empty chessboard and visit each of the squares exactly once? 

- The starting position can be input at the prompt stage - see the solve/2 predicate.
- A knight can only make L-shaped moves. One move consists of:
going one square horizontally and two squares vertically or vice-versa. */

board(Board):- Board = [1/1, 1/2, 1/3, 1/4, 1/5, 1/6, 1/7, 1/8,
                        2/1, 2/2, 2/3, 2/4, 2/5, 2/6, 2/7, 2/8,
                        3/1, 3/2, 3/3, 3/4, 3/5, 3/6, 3/7, 3/8,
                        4/1, 4/2, 4/3, 4/4, 4/5, 4/6, 4/7, 4/8,
                        5/1, 5/2, 5/3, 5/4, 5/5, 5/6, 5/7, 5/8,
                        6/1, 6/2, 6/3, 6/4, 6/5, 6/6, 6/7, 6/8,
                        7/1, 7/2, 7/3, 7/4, 7/5, 7/6, 7/7, 7/8,
                        8/1, 8/2, 8/3, 8/4, 8/5, 8/6, 8/7, 8/8].

generate_numbers(1, [1]).
generate_numbers(N, [N|T]):-
    N > 1, N1 is N - 1,
    generate_numbers(N1, T).

valid_position(X/Y):-
    generate_numbers(8, XValues),
    generate_numbers(8, YValues),
    member(X, XValues),
    member(Y, YValues).

generate_moves(X/Y, Moves):-
    XM2 is X - 2,
    XM1 is X - 1,
    XP1 is X + 1,
    XP2 is X + 2,
    YM2 is Y - 2,
    YM1 is Y - 1,
    YP1 is Y + 1,
    YP2 is Y + 2,
    AllMoves = [XP1/YP2, XP2/YP1, XP2/YM1, XP1/YM2, XM1/YM2, XM2/YM1, XM2/YP1, XM1/YP2],
    include(valid_position, AllMoves, Moves).
    
possible_move(Xs/Ys, CurrentPath, Xe/Ye):-
    generate_moves(Xs/Ys, Moves),
    member(Xe/Ye, Moves),
    \+(member(Xe/Ye, CurrentPath)).

is_solution(CurrentPath):-
    length(CurrentPath, 64). % set the final goal to covering the whole board

/* tackling the problem with a simple generate-and-test approach is extremely slow.
As an alternative, an heuristic evaluation can be implemented 
for assessing wich action to take from a given position. 
For each possible new position NewPos:

- calculate the number of positions that NewPos can reach and that have not been visited yet.
This number is referred to as the heuristic value of NewPos
- always try out the new position with the smallest heuristic value first. */

minimum_list([[A, B]], [A, B]).
minimum_list([[A, B], [C, D]], Res):-
    B =< D -> Res = [A, B]
    ;
    Res = [C, D].
minimum_list([[A, B], [C, D]|T], Res):-
    minimum_list(T, MinT),
    minimum_list([[A, B], [C, D]], MinH),
    MinH = [_, MinHB],
    MinT = [_, MinTB],
    (MinHB =< MinTB -> Res = MinH
    ;
    Res = MinT).

sort_list([[A, B]], [[A, B]]).
sort_list([[A, B]|T], [[A, B]|Res]):-
    minimum_list(T, MinT),
    MinT = [_, MinTB],
    B =< MinTB,
    sort_list(T, Res).
sort_list([[A, B]|T], [MinT|Res]):-
    minimum_list(T, MinT),
    MinT = [_, MinTB],
    B > MinTB,
    select(MinT, T, NewT),
    sort_list([[A, B]|NewT], Res).

amount_possible_moves(CurrentPos, CurrentPath, Amount):-
    findall(PossibleMove, 
        possible_move(CurrentPos, CurrentPath,PossibleMove), List),
    length(List, Amount).

compute_heuristic(CurrentPos, CurrentPath, BestMove):-
    % for every new position NextPos
    findall(NextPos, possible_move(CurrentPos, CurrentPath, NextPos), NextPositions),
    % calculate the number of positions that can be reached from there
    % and collect the pairs (NextPos, PossibleActions) into FutureMoves
    findall([NextPos, Amount], 
        (member(NextPos, NextPositions),
        amount_possible_moves(NextPos, CurrentPath, Amount)),
        FutureMoves),
    % sort the list and pick the action with the smallest number
    sort_list(FutureMoves, SortedFutureMoves),
    SortedFutureMoves = [[BestMove, _]|_].

solve(StartPos, Path):-
    valid_position(StartPos),
    search([StartPos], Path), !. % only give one solution

search(CurrentPath, Path):-
    is_solution(CurrentPath),
    Path = CurrentPath.

search(CurrentPath, Path):-
    CurrentPath = [CurrentPos|_],
    compute_heuristic(CurrentPos, CurrentPath, NextPos),
    search([NextPos|CurrentPath], Path).