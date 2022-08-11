% defining the graph
arc(g, h).
arc(k, f).
arc(f, b).
arc(f, c).
arc(b, c).
arc(b, e).
arc(c, e).
arc(e, j).
arc(c, e).

no_loop(Next, CurrentPath):-
    not(member(Next, CurrentPath)).

try_action(Start, Next):-
    arc(Start, Next)
    ;
    arc(Next, Start).

path(Node, Node, CurrentPath, Path):-
    CurrentPath = Path.

path(Start, End, CurrentPath, Path):-
    try_action(Start, Next),
    no_loop(Next, CurrentPath),
    path(Next, End, [Next|CurrentPath], Path).

% predicate to identify all existing loops starting from a given node

loop(Start, [Start|TmpPath]):-
    path(Start, Last, [Start], TmpPath),
    try_action(Last, Start).

findloops(Start, Loops):-
    setof(Loop,
        loop(Start, Loop),
        Loops),
    no_variants(Loops, UniqueLoops),
    listwrite(UniqueLoops).

% eliminate variants, e.g. [b, f, c, b] for [b, c, f, b]

no_variants([], []).
no_variants([H|T], [H|NewLoops]):-
    invert_list(H, Variant),
    member(Variant, T),
    select(Variant, T, TmpT),
    no_variants(TmpT, NewLoops).
no_variants([H|T], [H|NewLoops]):-
    invert_list(H, Variant),
    not(member(Variant, T)),
    no_variants(T, NewLoops).

invert_list(List, Rev):- invert_list_acc(List, [], Rev).
invert_list_acc([], Acc, Acc).
invert_list_acc([H|T], Acc, Rev):-
    invert_list_acc(T, [H|Acc], Rev).

listwrite([H]):-
    write(H), nl.

listwrite([H|T]):-
    write(H), nl,
    listwrite(T).