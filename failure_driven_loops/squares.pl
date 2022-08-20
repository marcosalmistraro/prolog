% compute square of an

do_squares:-
    repeat,
    write('Enter a number. Write stop to terminate'), nl,
    read(X),
    (X = stop, !
    ;
    Y is X*X,
    write('The computed square is '), write(Y), nl,
    fail).