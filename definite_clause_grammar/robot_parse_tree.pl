/* parsing the moves of a robot using DCG */

move(move(Step)) --> step(Step).
move(move(Step, Move)) --> step(Step), move(Move).

step(step(up)) --> [up].
step(step(down)) --> [down].

/* computing distances covered by the robot */

meaning(move(Step, Move), Dist):-
    meaning(Step, D1),
    meaning(Move, D2),
    Dist is D1 + D2.

meaning(move(Step), Dist):-
    meaning(Step, Dist).

meaning(step(up), 1).
meaning(step(down), -1).

/* Example query. In this case we need to create the parse tree and use it
as an argument in the query. Collapsed DCG are easier to read and implement.

?- move(T,['up', 'down', 'up'],[]),meaning(T, Dist).*/