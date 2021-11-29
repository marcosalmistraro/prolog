/*

The following program solves a given 9x9 sudoku puzzle.
Alternative solutions are given if available; in case the puzzle is not solvable the system fails.
An example query to be asked via the Prolog prompt is the following; this will generate one unique solution.

solve(
[_,_,_,2,3,_,_,_,5,
_,4,2,_,9,_,_,_,3,
3,_,_,_,_,8,7,_,_,
_,_,7,_,_,_,_,5,6,
_,9,_,7,2,_,_,1,4,
5,_,_,9,_,_,_,_,_,
6,_,_,_,_,2,8,4,9,
_,_,8,_,_,1,_,_,7,
2,5,_,_,_,9,6,_,_]).

*/

solve(Sol) :-
	N is 81,
	stepwise(1,N,Sol),
	write(Sol), nl.

stepwise(Pos,N,_) :-
	Pos > N, !.
stepwise(Pos,N,Sol) :-
	% generate a value from 1 to 9
	member(Val,[1,2,3,4,5,6,7,8,9]),
	% assign it to the element at position Pos in the list Sol
	nth_element(Pos,Sol,Val), % this line does the assignment by unification
	% test the current (partially instantiated) solution:
	test_stepwise(Pos,Sol),
	% generate-and-test the rest:
	Next is Pos + 1,
	stepwise(Next,N,Sol).

test_stepwise(Pos,Sol) :-
	% test the row that contains Pos:
	test_one_dimension(Pos,[r1,r2,r3,r4,r5,r6,r7,r8,r9],Sol),
	% test the column that contains Pos:
	test_one_dimension(Pos,[c1,c2,c3,c4,c5,c6,c7,c8,c9],Sol),
	% test the block that contains Pos:
	test_one_dimension(Pos,[b1,b2,b3,b4,b5,b6,b7,b8,b9],Sol).

test_one_dimension(Pos,GroupList,Sol) :-
	% Find a Group ...
	group(Group,PositionList),
	% ... such that Pos is in the list of positions of the Group ...
	member(Pos,PositionList),
	% ... and Group is in the GroupList under consideration.
	member(Group,GroupList),
	% Then get the values at those positions ...
	get_values(PositionList,Sol,Values),
	% ... and check whether these values are all different.
	all_different(Values).

get_values([],_,[]).
get_values([Pos|T],Sol,ValList) :-
	get_values(T,Sol,T2),
	nth_element(Pos,Sol,Val), % get the value at Pos
	(var(Val) ->
	   % if al is not instantiated yet don't include it in ValList
	   ValList=T2
	;
	   % if Val is instantiated include it in ValList
	   ValList=[Val|T2]).

all_different([]).
all_different([H|T]) :-
	not(member(H,T)),
	all_different(T).

nth_element(N,[H|_],H) :-
	N = 1, !.
nth_element(N,[_|T],E) :-
	N > 1,
	N1 is N - 1,
	nth_element(N1,T,E).

/* Value groups for progressive testing of the generated values on the sudoku table */

group(r1,[1,2,3,4,5,6,7,8,9]).
group(r2,[10,11,12,13,14,15,16,17,18]).
group(r3,[19,20,21,22,23,24,25,26,27]).
group(r4,[28,29,30,31,32,33,34,35,36]).
group(r5,[37,38,39,40,41,42,43,44,45]).
group(r6,[46,47,48,49,50,51,52,53,54]).
group(r7,[55,56,57,58,59,60,61,62,63]).
group(r8,[64,65,66,67,68,69,70,71,72]).
group(r9,[73,74,75,76,77,78,79,80,81]).

group(c1,[1,10,19,28,37,46,55,64,73]).
group(c2,[2,11,20,29,38,47,56,65,74]).
group(c3,[3,12,21,30,39,48,57,66,75]).
group(c4,[4,13,22,31,40,49,58,67,76]).
group(c5,[5,14,23,32,41,50,59,68,77]).
group(c6,[6,15,24,33,42,51,60,69,78]).
group(c7,[7,16,25,34,43,52,61,70,79]).
group(c8,[8,17,26,35,44,53,62,71,80]).
group(c9,[9,18,27,36,45,54,63,72,81]).

group(b1,[1,2,3,10,11,12,19,20,21]).
group(b2,[4,5,6,13,14,15,22,23,24]).
group(b3,[7,8,9,16,17,18,25,26,27]).
group(b4,[28,29,30,37,38,39,46,47,48]).
group(b5,[31,32,33,40,41,42,49,50,51]).
group(b6,[34,35,36,43,44,45,52,53,54]).
group(b7,[55,56,57,64,65,66,73,74,75]).
group(b8,[58,59,60,67,68,69,76,77,78]).
group(b9,[61,62,63,70,71,72,79,80,81]).
