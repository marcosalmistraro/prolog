/* Modeling a single-round badminton tournament using Prolog

Representing information on who beats who

beats(1, 2).
beats(1, 3).
beats(1, 4).
beats(1, 5).
beats(1, 6).
beats(7, 1).
beats(8, 1). */

% Introducing info on a given set of games
beats(1, 2).
beats(3, 4).
beats(1, 3).
beats(4, 1).
beats(3, 2).
beats(2, 4).

% Initial sequence is indicated as a list of N members

perm([], []).
perm([H|T], Perm):-
    perm(T, TmpPerm),
    select(H, Perm, TmpPerm).

generate_permutations(List, ListPerm):-
    findall(Perm, perm(List, Perm), ListPerm).

onematch([H1, H2], [Winner]):-
    beats(H1, H2),
    H1 = Winner.

onematch([H1, H2], [Winner]):-
    beats(H2, H1),
    H2 = Winner.

onematch([H1, H2|T], [FirstWinner|Winners]):-
    beats(H1, H2),
    H1 = FirstWinner,
    onematch(T, Winners).

onematch([H1, H2|T], [FirstWinner|Winners]):-
    beats(H2, H1),
    H2 = FirstWinner,
    onematch(T, Winners).

% Implementing the structure of a tournament

tournament([H1, H2], Winner):-
    onematch([H1, H2], Winner).

tournament(Players, Winner):-
    onematch(Players, Winners),
    tournament(Winners, Winner).

numberwins(Players, Player, NumberWins):-
    generate_permutations(Players, PermPlayers),
    findall(SinglePerm,
    (member(SinglePerm, PermPlayers),
    tournament(SinglePerm, [Player])),
    Wins),
    length(Wins, NumberWins).