/* The following program generates all possible solutions for a 4X4 Sudoku Puzzle */

:- use_module(library(clpfd)).

generate:-

    [R1C1, R1C2, R1C3, R1C4,
    R2C1, R2C2, R2C3, R2C4,
    R3C1, R3C2, R3C3, R3C4,
    R4C1, R4C2, R4C3, R4C4] ins 1..4,
    
    /* check rows */
    all_different([R1C1, R1C2, R1C3, R1C4]),
    all_different([R2C1, R2C2, R2C3, R2C4]),
    all_different([R3C1, R3C2, R3C3, R3C4]),
    all_different([R4C1, R4C2, R4C3, R4C4]),

    /* check columns */
    all_different([R1C1, R2C1, R3C1, R4C1]),
    all_different([R1C2, R2C2, R3C2, R4C2]),
    all_different([R1C3, R2C3, R3C3, R4C3]),
    all_different([R1C4, R2C4, R3C4, R4C4]),

    /* check squares */
    all_different([R1C1, R1C2, R2C1, R2C2]),
    all_different([R1C3, R1C4, R2C3, R2C4]),
    all_different([R3C1, R3C2, R4C1, R4C2]),
    all_different([R3C3, R3C4, R4C3, R4C4]),

    labeling([], [R1C1, R1C2, R1C3, R1C4,
                R2C1, R2C2, R2C3, R2C4,
                R3C1, R3C2, R3C3, R3C4,
                R4C1, R4C2, R4C3, R4C4]),

    write('Proposed solution to the Sudoku Puzzle:'), nl,
    write(R1C1), tab(1), write(R1C2), tab(1),  write(R1C3), tab(1),  write(R1C4), nl,
    write(R2C1), tab(1), write(R2C2), tab(1),  write(R2C3), tab(1),  write(R2C4), nl,
    write(R3C1), tab(1), write(R3C2), tab(1),  write(R3C3), tab(1),  write(R3C4), nl,
    write(R4C1), tab(1), write(R4C2), tab(1),  write(R4C3), tab(1),  write(R4C4).