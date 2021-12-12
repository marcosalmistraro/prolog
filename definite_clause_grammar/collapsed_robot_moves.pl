/* example of collapsed DCG program, where the meaning
is interleaved with the syntax for faster and easier development.
In this case the behaviour of a basic robot is simulated. 
Then, the cumulative meaning of the available moves can be read by querying, e.g.,

?- move(D, [up, down, down, down, up], []). */

move(D) --> step(D).
move(D) --> step(D1), move(D2), {D is D1 + D2}.

step(1) --> [up].
step(-1) --> [down].