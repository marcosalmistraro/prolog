/* -- representing consecutive working shifts by facts --

shifts(Name, MinShifts, MaxShifts)
e.g. shifts(Danny, 3, 7).

-- representing shifts by terms --

danny/3/7 */

% using prolog facts to define possible/2

shifts(danny, 3, 7).
shifts(jef, 2, 2).
shifts(ann, 2, 4).

is_odd(NumberShifts):-
    1 is mod(NumberShifts, 2), !.

is_even(NumberShifts):-
    0 is mod(NumberShifts, 2), !.

all_smaller([H], V):-
    H =< V.
all_smaller([H|T], V):-
    H =< V,
    all_smaller(T, V).

all_greater([H], V):-
    H >= V.
all_greater([H|T], V):-
    H >= V,
    all_greater(T, V).

odd_smaller([A, B], V):-
    (A =< V,
    V1 is V + 1,
    B =< V1)    
    ;
    (B =< V,
    V1 is V + 1,
    A =< V1).

odd_greater([A, B], V):-
    (A >= V,
    V1 is V - 1,
    B >= V1)    
    ;
    (B >= V,
    V1 is V - 1,
    A >= V1).

possible(Workers, NumberShifts):-
    is_even(NumberShifts),
    RequiredShifts is NumberShifts/2,
    findall(MinShifts, (member(Worker, Workers), shifts(Worker, MinShifts, _)), ListMins),
    findall(MaxShifts, (member(Worker, Workers), shifts(Worker, _, MaxShifts)), ListMaxs),
    all_smaller(ListMins, RequiredShifts),
    all_greater(ListMaxs, RequiredShifts).

possible(Workers, NumberShifts):-
    is_odd(NumberShifts),
    MinRequiredShifts is (NumberShifts - 1)/2,
    MaxRequiredShits is MinRequiredShifts + 1,
    findall(MinShifts, (member(Worker, Workers), shifts(Worker, MinShifts, _)), ListMins),
    findall(MaxShifts, (member(Worker, Workers), shifts(Worker, _, MaxShifts)), ListMaxs),
    odd_smaller(ListMins, MinRequiredShifts),
    odd_greater(ListMaxs, MaxRequiredShits).
    
% using prolog terms to define possible/2

possible_term(Workers, NumberShifts):-
    is_even(NumberShifts),
    RequiredShifts is NumberShifts/2,
    findall(MinShifts, (member(Worker/MinShifts/_, Workers)), ListMins),
    findall(MaxShifts, (member(Worker/_/MaxShifts, Workers)), ListMaxs),
    all_smaller(ListMins, RequiredShifts),
    all_greater(ListMaxs, RequiredShifts).

possible_term(Workers, NumberShifts):-
    is_odd(NumberShifts),
    MinRequiredShifts is (NumberShifts - 1)/2,
    MaxRequiredShits is MinRequiredShifts + 1,
    findall(MinShifts, (member(Worker/MinShifts/_, Workers)), ListMins),
    findall(MaxShifts, (member(Worker/_/MaxShifts, Workers)), ListMaxs),
    odd_smaller(ListMins, MinRequiredShifts),
    odd_greater(ListMaxs, MaxRequiredShits).