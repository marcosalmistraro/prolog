% Predicate to determine whether a given integer number is prime

generate_numbers(3, [2]):- !.
generate_numbers(N, [N1|Res]):-
    N > 3,
    N1 is N - 1,
    generate_numbers(N1, Res), !.

all_not_divisible(A, [N]):-
    TmpRes is A / N,
    not(integer(TmpRes)), !.

all_not_divisible(A, [H|T]):-
    TmpRes is A / H,
    not(integer(TmpRes)),
    all_not_divisible(A, T), !.

is_prime(1):- !.
is_prime(2):- !.
is_prime(A):-
    integer(A),
    generate_numbers(A, IntUpToA1),
    all_not_divisible(A, IntUpToA1), !.