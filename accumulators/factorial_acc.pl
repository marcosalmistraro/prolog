factorial(N, Fact):- fact_acc(N, 1, Fact).

fact_acc(1, Fact, Fact).
fact_acc(N, Acc, Fact):-
	N > 1,
	N1 is N - 1,
	Acc1 is Acc * N,
	fact_acc(N1, Acc1, Fact), !.