/* This program computes the combination of an imaginary safe. 
There are 9 digits in total; they are all different and all in the range 1..9.

- The 1st digit is not 1, the 2nd digit is not 2, etc. 
- The absolute difference between the 4th and the 6th digit is equal to the 7th digit.
- The product of the first three digits is equal to the sum of the last two digits.
- The sum of the 2nd, 3th and 6th digit is less than the 8th digit.
- The last digit is less than the 8th digit.

The program uses CLPFD in order to find a solution. */

:- use_module(library(clpfd)).

solve():-
    [A, B, C, D, E, F, G, H, I] ins 1..9,
    
    A #\= 1, B #\= 2, C #\= 3, 
    D #\= 4, E #\= 5, F #\= 6,
    G #\= 7, H #\= 8, I #\= 9,

    all_different([A, B, C, D, E, F, G, H, I]),

    abs(D - F) #= G,
    A * B * C #= H + I,
    B + C + F #< H,
    I #< H,

    labeling([], [A, B, C, D, E, F, G, H, I]),

    write('The resulting combination is the following: '), nl,
    write(A), tab(1), write(B), tab(1), write(C), nl,
    write(D), tab(1), write(E), tab(1), write(F), nl,
    write(G), tab(1), write(H), tab(1), write(I).