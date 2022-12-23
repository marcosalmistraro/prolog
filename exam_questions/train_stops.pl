/* Program to manage train trips.
Train paths are described as a list of stop/2 functors.

Example query:
?- costBus([stop(leuven-station, 10), stop(leuven-city-center, 10), stop(heverlee, 4)], C).
C = 18. */

distance(heverlee, leuven-city-center, 10).
distance(leuven-station, leuven-city-center, 8).
distance(c, d, 2).
distance(b, a, 3).
distance(d, e, 9).
distance(c, b, 10).

costBus(Cities, Cost):-
    findall(stop(City, _), (member(City, Cities)), Stops),
    getCost(Stops, Cost).

getCost([_], 0).

getCost([stop(Stop1, _), stop(Stop2, _)], Cost):-
    distance(Stop1, Stop2, Cost).

getCost([stop(Stop1, _), stop(Stop2, _)], Cost):-
    distance(Stop2, Stop1, Cost).

getCost([stop(Stop1, _), stop(Stop2, _)|T], Cost):-
    distance(Stop1, Stop2, TmpCost),
    getCost([stop(Stop2, _)|T], FutureCost),
    Cost is TmpCost + FutureCost.
    
getCost([stop(Stop1, _), stop(Stop2, _)|T], Cost):-
    distance(Stop2, Stop1, TmpCost),
    getCost([stop(Stop2, _)|T], FutureCost),
    Cost is TmpCost + FutureCost.