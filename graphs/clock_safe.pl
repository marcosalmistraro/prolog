/*
A graph is represented as a sequence of integers.
Consecutive nodes are connected by a directed edge and all nodes are distinct except for the first and last node.
These are required to be the same. 
We say that a cycle is clock-safe if all but one directed edges 
point from a smaller node to a larger node.
*/

is_higher(H1, H2):-
    V #<==> (H2 #> H1),
    V = 1.

is_lower(H1, H2):-
    V #<==> (H2 #=< H1),
    V = 1.

invert_list(List, Inverted):- invert_acc(List, [], Inverted).
invert_acc([], Acc, Acc).
invert_acc([H|T], Acc, Inverted):-
    invert_acc(T, [H|Acc], Inverted).

first_last_same([H|T]):-
    invert_list([H|T], [HInv|_]),
    H = HInv.
    
clock_safe([H|T]):-
    length([H|T], L),
    L2 is L - 2,
    successive_higher([H|T], L2),
    successive_lower([H|T], 1),
    first_last_same([H|T]).

successive_higher([H1, H2|T], Amount):-
    is_higher(H1, H2),
    successive_higher([H2|T], RestAmount),
    Amount is RestAmount + 1.

successive_higher([H1, H2|T], Amount):-
    is_lower(H1, H2),
    successive_higher([H2|T], Amount).

successive_higher([H1, H2], 1):-
    is_higher(H1, H2).

successive_higher([H1, H2], 0):-
    is_lower(H1, H2).

successive_lower([H1, H2|T], Amount):-
    is_lower(H1, H2),
    successive_lower([H2|T], RestAmount),
    Amount is RestAmount + 1.

successive_lower([H1, H2|T], Amount):-
    is_higher(H1, H2),
    successive_lower([H2|T], Amount).

successive_lower([H1, H2], 1):-
    is_lower(H1, H2).

successive_lower([H1, H2], 0):-
    is_higher(H1, H2).