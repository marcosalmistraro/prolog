/* 
Train paths are described as a list of stop/2 functors.
Example query:

?- costBus([stop(leuven-station, 10), stop(leuven-city-center, 10), stop(heverlee, 4)], C).
C = 18.
*/

distance(heverlee, leuven-city-center, 10).
distance(leuven-station, leuven-city-center, 8).
distance(c, d, 2).
distance(b, a, 3).
distance(d, e, 9).
distance(c, b, 10).

costBus([stop(_, _)], 0).

costBus(Tour, Cost):-
    Tour = [stop(Stop1, _), stop(Stop2, _)],
    distance(Stop1, Stop2, Cost), !.

costBus(Tour, Cost):-
    Tour = [stop(Stop1, _), stop(Stop2, _)],
    distance(Stop2, Stop1, Cost), !.

costBus(Tour, Cost):-
    Tour = [stop(Stop1, _), stop(Stop2, _)|T],
    distance(Stop1, Stop2, TmpCost),
    costBus([stop(Stop2, _)|T], FutureCost),
    Cost is TmpCost + FutureCost, !.

costBus(Tour, Cost):-
    Tour = [stop(Stop1, _), stop(Stop2, _)|T],
    distance(Stop1, Stop2, TmpCost),
    costBus([stop(Stop1, _)|T], FutureCost),
    Cost is TmpCost + FutureCost, !.

costBus(Tour, Cost):-
    Tour = [stop(Stop1, _), stop(Stop2, _)|T],
    distance(Stop2, Stop1, TmpCost),
    costBus([stop(Stop1, _)|T], FutureCost),
    Cost is TmpCost + FutureCost, !.

costBus(Tour, Cost):-
    Tour = [stop(Stop1, _), stop(Stop2, _)|T],
    distance(Stop2, Stop1, TmpCost),
    costBus([stop(Stop2, _)|T], FutureCost),
    Cost is TmpCost + FutureCost, !.