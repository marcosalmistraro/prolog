/* Exact covering problem

Items to be covered are represented as a list
e.g. [a, b, c]

The set of options is a list of lists
e.g. [[a, c], [e], [a, b]] */

isCovered(I, Os, O):-
    member(O, Os),
    member(I, O).

getResIs(Is, O, ResIs):-
    % Remove all I contained in O from Is to get ResIs
    findall(IToRemove, member(IToRemove, O), IsToRemove),
    findall(ResI, (member(ResI, Is), not(member(ResI, IsToRemove))), ResIs).
    
residual(I, Is, O, Os, ResIs, ResOs):-
    member(I, Is),
    isCovered(I, Os, O),
    getResIs(Is, O, ResIs),
    select(O, Os, ResOs).

% Make sure that no element in O is contained in any of the sublists in Os

% Flatten list of lists
flatten_Os(Os, FlatOs):-
    findall(Element,
        (member(O, Os),
        member(Element, O)),
        FlatOs).

% no_intersection/2 predicate
no_intersection([O], Os):-
    flatten_Os(Os, FlatOs),
    not(member(O, FlatOs)).

no_intersection([H|T], Os):-
    flatten_Os(Os, FlatOs),
    not(member(H, FlatOs)),
    no_intersection_flat(T, FlatOs).

% Implement case when Os is already flattened
no_intersection_flat([H], FlatOs):-
    not(member(H, FlatOs)).

no_intersection_flat([H|T], FlatOs):-
    not(member(H, FlatOs)),
    no_intersection_flat(T, FlatOs).

% Implement recursive search for disjunct exact covering Os
findexactcovering(Is, Os, [O]):-
    member(I, Is),
    isCovered(I, Os, O),
    residual(I, Is, O, Os, [], _).

findexactcovering(Is, Os, [O|Covering]):-
    member(I, Is),
    isCovered(I, Os, O),
    residual(I, Is, O, Os, ResIs, ResOs),
    findexactcovering(ResIs, ResOs, Covering),
    no_intersection(O, Covering).

% Only find unique covering solutions
findallcoverings(Is, Os, Coverings):-
    setof(Covering,
        findexactcovering(Is, Os, Covering),
        Coverings).