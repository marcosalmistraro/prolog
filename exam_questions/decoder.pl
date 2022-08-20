/* The program accepts a list of binary integers (0s and 1s) and outputs
a decompressed representation (a list of lists) where each single nested list
corresponds to a certain carachter in the input.
The rules are as follows:

- A code is a sequence of 0s and 1s
- No character's code is a prefix to another (if character k has 0 as its code, 
then all codes for other characters must start with a 1 to prevent ambiguity)
- The amount of character codes to be generated is given by the input parameter N

As an example, the input sequence 001110 could be decomposed in N = 3 single characters,
with codes 00, 11 and 10. It can not be decomposed into 00, 11, 1 and 0.
The case where N = 1 is trivial and gives the input sequence as a character code. */

decode(1, List, List):- !.

decode(N, List, Res):-
    splitNlists(N, List, Res),
    checkalldiff(Res),
    checknotprefix(Res).

splitNlists(1, List, [List]).

splitNlists(N, List, Res):-
    append(List1, List2, List),
    length(List1, L1), length(List2, L2), L1 > 0, L2 > 0,
    N1 is N - 1,
    splitNlists(N1, List2, TmpRes),
    Res = [List1|TmpRes].

checkalldiff([_]).
checkalldiff([H|T]):-
    not(member(H, T)),
    checkalldiff(T).

checknotprefix2([H1, H2]):-
    not(append(H1, _, H2)),
    not(append(H2, _, H1)).

checknotprefix(List):-
    findall([H1, H2], ((member(H1, List), member(H2, List), H1 \= H2)), Couples),
    maplist(checknotprefix2, Couples).