/* 
Describing items by prolog facts and terms

item(Name, Weight, Value) -- this is done by means of a /3 functor
name/weight/value --- this is an atom
*/

% -- FACTS --
item(ax, 50, 40).
item(book, 50, 50).
item(box, 10, 5).
item(laptop, 99, 60).
% item(monitor, 70, 60).

/* -- TERMS --
[ax/50/40, book/50/50, box/10/5, laptop/99/60]
*/

is_subset([], []).
is_subset([H|T1], [H|T2]):-
    is_subset(T1, T2).
is_subset([_|T1], T2):-
    is_subset(T1, T2).

totalweight([H], SetW):-
    H = item(_,SetW,_).
totalweight([H|T], SetW):-
    H = item(_,W,_),
    totalweight(T, TmpW),
    SetW is W + TmpW.

totalvalue([H], SetV):-
    H = item(_,_,SetV).
totalvalue([H|T], SetV):-
    H = item(_,_,V),
    totalvalue(T, TmpV),
    SetV is V + TmpV.

find_all_items(Items):-
    findall(item(Item, W, V),
    item(Item, W, V),
    Items).

extract_subset(Items, MaxW, MaxV, SubSet):-
    is_subset(Items, SubSet),
    totalweight(SubSet, SetW), SetW =< MaxW,
    totalvalue(SubSet, SetV), SetV =< MaxV.

search(MaxW, MaxV, SubSet):-
    find_all_items(Items),
    extract_subset(Items, MaxW, MaxV, SubSet).

% predicate highest/1 to find the list whith all items having the highest value

max_list([Max], Max).
max_list([H|T], H):-
    max_list(T, MaxT),
    H >= MaxT.
max_list([H|T], MaxT):-
    max_list(T, MaxT),
    H < MaxT.

find_highest_value(HighestValue, Items):-
    findall(Value,
    (member(Item, Items),
    Item = item(_,_,Value)),
    Values),
    max_list(Values, HighestValue).

highest(List):-
    find_all_items(Items),
    find_highest_value(HighestValue, Items),
    findall(Item,
    (member(Item, Items),
    Item = item(_,_,HighestValue)),
    List).