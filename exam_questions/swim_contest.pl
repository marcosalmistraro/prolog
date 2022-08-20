/* Using CLPFD to solve a CLP problem

Names       1. Sarah    2. Rachel   3. Melony   4. Amelia   5. Julia
Surnames    1. Sanford  2. Travers  3. James    4. West     5. Couch
Colors      1. Red      2. White    3. Yellow   4. Black    5. Blue
Piece       1. One      2. One      3. One      4. Two      5. Two */

:- use_module(library(clpfd)).

swim:-
    [N1, N2, N3, N4, N5] ins 1..5,
    [S1, S2, S3, S4, S5] ins 1..5,
    [C1, C2, C3, C4, C5] ins 1..5,
    [P1, P2, P3, P4, P5] ins 1..5,
    all_different([N1, N2, N3, N4, N5]),
    all_different([S1, S2, S3, S4, S5]),
    all_different([C1, C2, C3, C4, C5]),
    all_different([P1, P2, P3, P4, P5]),

    % hint 1
    N2 #= S2, 
    N2 #\= C1,
    (C2 #= P1; C2 #= P2; C2 #= P3),
    N2 #= C2 - 1,
    % hint 2
    N3 #\= S3, N3 #= 1,
    % hint 3
    (P1 #= 2; P2 #= 2; P3 #= 2),
    (P1 #= C3; P2 #= C3; P3 #= C3),
    (P1 #= N4; P2 #= N4; P3 #= N4),
    N4 #\= S4,
    C3 #\= 2, C3 #\= N4, N4 #\= 2,
    % hint 4
    N2 #= S5 - 1,
    N2 #= C5 + 2,
    % hint 5
    N5 #\= S5,
    (S3 #= P4; S3 #= P5),
    % hint 6
    (C4 #= P4; C4 #= P5),
    all_different([S3, N5, C4, S4]),
    S3 #\= 5, N5 #\= 5, S4 #\= 5, C4 #\= 5,

    label([N1, N2, N3, N4, N5]),
    label([S1, S2, S3, S4, S5]),
    label([C1, C2, C3, C4, C5]),
    label([P1, P2, P3, P4, P5]),

    write(N1), tab(1), write(N2), tab(1), write(N3), tab(1), write(N4), tab(1), write(N5), nl,
    write(S1), tab(1), write(S2), tab(1), write(S3), tab(1), write(S4), tab(1), write(S5), nl,
    write(C1), tab(1), write(C2), tab(1), write(C3), tab(1), write(C4), tab(1), write(C5), nl,
    write(P1), tab(1), write(P2), tab(1), write(P3), tab(1), write(P4), tab(1), write(P5).