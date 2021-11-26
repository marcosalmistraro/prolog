/* eliminate consecutive duplicates of list elements. */

eliminate([], []).
eliminate([A], [A]).

eliminate([H1, H1], [H1]).
eliminate([H1, H2], [H1, H2]):- H1 \= H2.

eliminate([H1, H2|[HT|TT]], [H1, H2|Res]):-
    H1 \= H2,
    H2 \= HT,
    eliminate([HT|TT], Res), !.
eliminate([H1, H2|[HT|TT]], [H1|Res]):-
    H1 \= H2,
    H2 = HT,
    eliminate([HT|TT], Res), !.
eliminate([H1, H2|[HT|TT]], [H2|Res]):-
    H1 = H2,
    H2 \= HT,
    eliminate([HT|TT], Res), !.
eliminate([H1, H2|[HT|TT]], Res):-
    H1 = H2,
    H2 = HT,
    eliminate([HT|TT], Res), !.