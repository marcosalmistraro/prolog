length_list(List, Length):- length_acc(List, 0, Length).

length_acc([], Length, Length).
length_acc([_|T], Acc, Length):-
	Acc1 is Acc + 1,
	length_acc(T, Acc1, Length).