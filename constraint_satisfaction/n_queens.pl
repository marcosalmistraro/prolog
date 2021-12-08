/* The following is an implementation of the N-queens puzzle. 
A solution is provided for any given N integer number of queens.
It is assumed that queens are placed at consecutive, different row numbers */

:- use_module(library(clpfd)).

no_diagonal_attack(_, [], _, _).
no_diagonal_attack(Q, Others, D, N):-
	Others = [H|T],
	Q - H #\= D,
	H - Q #\= D,
	D1 is D + 1, D1 =< N,
	no_diagonal_attack(Q, T, D1, N).

safe_configuration([_], _).
safe_configuration(Queens, N):-
	Queens = [Q1|Others],
	no_diagonal_attack(Q1, Others, 1, N),
	safe_configuration(Others, N).

generate_configuration(Queens, N):-
	length(Queens, N),
	Queens ins 1..N,
	all_different(Queens),
	safe_configuration(Queens, N),
	labeling([], Queens). 

solve:- 
	write("Enter the amount of desired queens: "), read(N),
	write("N is set to: "), write(N), nl,
	generate_configuration(Queens, N),
	write("A possible solution to the puzzle is given below: "), nl,
	write(Queens).