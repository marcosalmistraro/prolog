/* 
Goldbach's conjecture says that every positive even number greater than 2 
is the sum of two prime numbers. As an example: 28 = 5 + 23. 
Although it has not been proved to be correct in the general case, it has been numerically confirmed up to very large numbers. 
The predicate finds all combinations of two prime numbers that sum up to a given even integer. */

% generates an integer range without the specified extremes
generate_numbers_no_bounds(3, [2]).
generate_numbers_no_bounds(N, [N1|Res]):-
    N > 3,
    N1 is N - 1,
    generate_numbers_no_bounds(N1, Res).

all_not_divisible(A, [N]):-
    TmpRes is A / N,
    not(integer(TmpRes)).

all_not_divisible(A, [H|T]):-
    TmpRes is A / H,
    not(integer(TmpRes)),
    all_not_divisible(A, T).

% checks if a number is a prime
is_prime(1).
is_prime(2).
is_prime(A):-
    integer(A),
    generate_numbers_no_bounds(A, IntUpToA1),
    all_not_divisible(A, IntUpToA1).

% checks if a number is even
is_even(N):-
    0 is mod(N, 2).

% generates an integer range including the extremes
generate_numbers_with_bounds(1, [1]).
generate_numbers_with_bounds(N, [N|T]):-
    N > 1, N1 is N-1, 
    generate_numbers_with_bounds(N1, T).

% goldbach's conjecture only applies to even integers
goldbach(N, _):-
    not(is_even(N)),
    write("Goldbach's conjecture only applies to even integers"), !.

% goldbach conjecture in action
goldbach(N, [A, B]):-
    is_even(N),
    generate_numbers_with_bounds(N, List),
    member(A, List),
    is_prime(A),
    member(B, List),
    is_prime(B),
    A =< B,
    N is A + B.

% outputs all possible goldbach compositions for each integer within a range
goldbach_list(Number, Number, [Res]):-
    goldbach(Number, Res).

goldbach_list(Lower, Upper, [TmpRes|Others]):-
    is_even(Lower),
    goldbach(Lower, TmpRes),
    NewLower is Lower + 2, NewLower =< Upper,
    goldbach_list(NewLower, Upper, Others).

% treat case where lower only is not even
goldbach_list(Lower, Upper, [TmpRes|Others]):-
    not(is_even(Lower)),
    AdjLower is Lower + 1,
    goldbach(AdjLower, TmpRes),
    NewLower is AdjLower + 2, NewLower =< Upper,
    goldbach_list(NewLower, Upper, Others).

% treat case where upper only is not even
goldbach_list(Lower, Upper, [TmpRes|Others]):-
    not(is_even(Upper)),
    AdjUpper is Upper - 1,
    is_even(Lower),
    goldbach(Lower, TmpRes),
    NewLower is Lower + 2, NewLower =< AdjUpper,
    goldbach_list(NewLower, AdjUpper, Others).

% treat case where both lower and upper are not even
goldbach_list(Lower, Upper, [TmpRes|Others]):-
    not(is_even(Upper)),
    not(is_even(Lower)),
    AdjUpper is Upper - 1,
    AdjLower is Lower + 1,
    goldbach(AdjLower, TmpRes),
    NewLower is AdjLower + 2, NewLower =< AdjUpper,
    goldbach_list(NewLower, AdjUpper, Others).