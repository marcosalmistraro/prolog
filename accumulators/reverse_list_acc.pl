reverse_list(List, Reversed):- reverse_acc(List, [], Reversed).

reverse_acc([], Reversed, Reversed).
reverse_acc([H|T], Acc, Reversed):-
	reverse_acc(T, [H|Acc], Reversed).