/* 

data structure for domino (N1, N2)
data structure for configuration [(N1, N2), (N3, N4), (N5, N6), (N7, N8)]

*/

generate_numbers(0, [0]).
generate_numbers(N, [N|T]):-
    N > 0,
    N1 is N-1,
    generate_numbers(N1, T).

generate_dominos(Dominos):-
    generate_numbers(6, Numbers),
    findall((N1, N2),
        (member(N1, Numbers),
        member(N2, Numbers),
        N2 >= N1),
        Dominos).

invert_tile((N1, N2), (N2, N1)).

check_valid_tiles(Configuration, Dominos):-
    Configuration = [D1, D2, D3, D4],
    invert_tile(D1, D1_Inv),
    (member(D1, Dominos); member(D1_Inv, Dominos)),
    invert_tile(D2, D2_Inv),
    (member(D2, Dominos); member(D2_Inv, Dominos)),
    invert_tile(D3, D3_Inv),
    (member(D3, Dominos); member(D3_Inv, Dominos)),
    invert_tile(D4, D4_Inv),
    (member(D4, Dominos); member(D4_Inv, Dominos)).

all_different_tiles(Configuration):-
    findall(Inverted, 
        (invert_tile(Tile, Inverted), member(Tile, Configuration), Tile \= (N, N)),
        InvertedConfig),
    append(Configuration, InvertedConfig, AllConfigs),
    all_different_elements(AllConfigs).

all_different_elements([_]).
all_different_elements([H|T]):-
    not(member(H, T)),
    all_different_elements(T).

check_sum(Configuration):-
    Configuration = [(N1, N2), (N3, N4), (N5, N6), (N7, N8)],
    TmpSum1 is N1 + N2, Sum is TmpSum1 + N3,
    TmpSum2 is N3 + N4, Sum is TmpSum2 + N5,
    TmpSum3 is N5 + N6, Sum is TmpSum3 + N7,
    TmpSum4 is N7 + N8, Sum is TmpSum4 + N1.

check_configuration(Configuration, Dominos):-
    generate_dominos(Dominos),
    check_valid_tiles(Configuration, Dominos),
    all_different_tiles(Configuration),
    check_sum(Configuration).

check_variant(Config1, Config2):-
    Config1 = [(N1, N2), (N3, N4), (N5, N6), (N7, N8)],
    (Config2 = [(N7, N8), (N1, N2), (N3, N4), (N5, N6)]
    ;
    Config2 = [(N5, N6), (N7, N8), (N1, N2), (N3, N4)]
    ;
    Config2 = [(N3, N4), (N5, N6), (N7, N8), (N1, N2)]).

write_config(Configuration):-
    Configuration = [(N1, N2), (N3, N4), (N5, N6), (N7, N8)],
    write(N1), tab(1),
    write(N2), tab(1),
    write(N3), tab(1),
    write(N4), tab(1),
    write(N5), tab(1),
    write(N6), tab(1),
    write(N7), tab(1),
    write(N8), nl.

generate_solutions_no_variants(Dominos, ValidConfigs):-
    findall(ValidConfig,
        (check_configuration(ValidConfig, Dominos),
        check_variant(ValidConfig, Variant),
        ValidConfig \= Variant),
        ValidConfigs).

search:-
    generate_dominos(Dominos),
    generate_solutions_no_variants(Dominos, ValidConfigs),
    maplist(write_config, ValidConfigs).