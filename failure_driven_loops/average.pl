% example of implementation of failure_driven loops

compute_average_3:-
    repeat,
    write('Enter the first of three numbers.'), nl, 
    write('Input stop to terminate'), nl,
    read(X), 
    (X = stop, !
    ;
    write('Enter the second number'), read(Y),
    write('Enter the third number'), read(Z),
    TmpSum is X + Y,
    Sum is TmpSum + Z,
    Avg is Sum/3,
    write('The average value is '), write(Avg), nl,
    fail).