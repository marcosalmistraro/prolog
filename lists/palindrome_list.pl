% find out whether a list is a palindrome

reverse_list([], []):- !.
reverse_list([A], [A]):- !.
reverse_list([H|T], Reversed):-
    reverse_list(T, ReversedT),
    append(ReversedT, [H], Reversed), !.
    
palindrome_list([]):- !.
palindrome_list([_]):- !.
palindrome_list(List):-
    reverse_list(List, Reversed),
    List = Reversed, !.