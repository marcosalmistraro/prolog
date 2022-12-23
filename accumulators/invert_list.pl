% Inverting the order of items within a given list

invert_list(List, Reversed):- invert_list_acc(List, [], Reversed).

invert_list_acc([], Reversed, Reversed).
invert_list_acc([H|T], Acc, Reversed):-
	invert_list_acc(T, [H|Acc], Reversed).