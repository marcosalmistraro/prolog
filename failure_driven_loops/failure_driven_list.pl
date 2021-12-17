/* another example of implementation of failure_driven loops */

create_list:-
    repeat,
    write("Enter the first element to be inserted into the list"), nl,
    read(X),
    (X = stop, !;
    write("Enter the second element to be inserted into the list"), nl,
    read(Y),
    write("Enter the third element to be inserted into the list"), nl,
    read(Z),
    List = [X, Y, Z],
    write("The list obtained is "), nl,
    write(List), nl,
    fail).