/*  
Using CLPFD to solve a CLP problem
    -- Domain values --

    1. monday           2. tuesday              3. wednesday    4. thursday     5. friday

    -- Variables --

    1. bioinformatics   2. physical hygiene     3. modern art   4. nutrition    5. study habits
    1. alice            2. bernadette           3. charles      4. duane        5. eddie
    1. felicidad        2. garber               3. haller       4. itakura      5. jeffreys
*/

:- use_module(library(clpfd)).

solve:- 
    
    [T1, T2, T3, T4, T5] ins 1..5,
    [N1, N2, N3, N4, N5] ins 1..5,
    [S1, S2, S3, S4, S5] ins 1..5,
    all_different([T1, T2, T3, T4, T5]),
    all_different([N1, N2, N3, N4, N5]),
    all_different([S1, S2, S3, S4, S5]),

    N1 #= 1,
    N3 #= T2, N3 #\= 5, T2 #\= 5,
    S5 #= T4,
    (T3 #= N3; T3 #= N4; T3 #= N5),
    abs(S4 - T5) #= 1, (S4 #= 1; S4 #= 2),
    S3 #> N5,
    N4 #= S1, (S1 #= N1; S1 #= N2), 

    label([T1, T2, T3, T4, T5]),
    label([N1, N2, N3, N4, N5]),
    label([S1, S2, S3, S4, S5]),
    
    write(T1), tab(1), write(T2), tab(1), write(T3), tab(1), write(T4), tab(1), write(T5), nl,
    write(N1), tab(1), write(N2), tab(1), write(N3), tab(1), write(N4), tab(1), write(N5), nl,
    write(S1), tab(1), write(S2), tab(1), write(S3), tab(1), write(S4), tab(1), write(S5).