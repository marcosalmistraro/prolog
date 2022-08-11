% defining the graph
arc(g, h).
arc(k, f).
arc(f, b).
arc(f, c).
arc(b, c).
arc(b, e).
arc(c, e).
arc(e, j).

try_action(X, Y):-
    arc(X, Y)
    ;
    arc(Y, X).

is_solution(Node, Node).

no_loop(Node, CurrentPath):-
    not(member(Node, CurrentPath)).

% predicate to identify all acyclic paths from a starting node to a terminal one

path(Start, End, CurrentPath, Path):-
    is_solution(Start, End),
    Path = CurrentPath.

path(Start, End, CurrentPath, Path):-
    try_action(Start, Next),
    no_loop(Next, CurrentPath),
    path(Next, End, [Next|CurrentPath], Path).




    
    
