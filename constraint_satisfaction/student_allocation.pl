/* The problem involves five students attending a singing masterclass.
There are one soprano, one mezzo-soprano, two tenors, and one bass. 
Their first names are in random order Chris, J.P., Lee, Pat, and Val.
The last names are Kingsley, Robinson, Robinson, Ulrich, and Walker. 
There are indeed two people with the same surname, although they are unrelated.
Other given facts are as follows:

1. The first and second students were, in some order, Pat and the bass
2. At least one of the second and the third students is a tenor
3. Kingsley and the fifth student (who isn't named Robinson) are, in some order, a mezzo-soprano and a tenor.
4. Neither the third student, whose name is Robinson, nor Walker are named Chris.
5. Ulrich is not the bass or the mezzo-soprano.
6. Neither Lee or Val (who wasn't third) is a tenor.
7. J.P. wasn't third, and Chris wasn't fifth.
8. The bass isn't named Robinson.

The task is to identify the name, surname and voice type of each single student, in the right order.

The problem makes use of the clpfd Prolog library for proper investigation of the problem,
using a dedicated syntax which is well-suited for constraint-satisfaction problems.

Names =     1. Chris    2. JP       3. Lee      4. Pat      5. Val
Surnames =  1. Kingsley 2. Robinson 3. Robinson 4. Ulrich   5. Walker
Voices =    1. soprano  2. msoprano 3. tenor    4. tenor    5. bass

*/

:- use_module(library(clpfd)).

solve():-

    [N1, N2, N3, N4, N5] ins 1..5,
    all_different([N1, N2, N3, N4, N5]),
    [S1, S2, S3, S4, S5] ins 1..5,
    all_different([S1, S2, S3, S4, S5]),
    [V1, V2, V3, V4, V5] ins 1..5,
    all_different([V1, V2, V3, V4, V5]),

    ((N1 #= 4, V2 #= 5); (N2 #= 4, V1 #= 5)),

    ((V2 #= 3); (V2 #= 4 ); (V3 #= 3); (V3 #= 4); 
    ((V2 #=3 ),(V3 #= 4)); ((V2 #=4 ),(V3 #= 3))),

    ((S5 in {1, 4, 5}),

    (((S1 #= 1, V1 #= 2, V5 in {3,4}); (S1 #= 1, V1 in {3,4}, V5 #= 2));
    ((S2 #= 1, V2 #= 2, V5 in {3,4}); (S2 #= 1, V2 in {3,4}, V5 #= 2));
    ((S3 #= 1, V3 #= 2, V5 in {3,4}); (S3 #= 1, V3 in {3,4}, V5 #= 2));
    ((S4 #= 1, V4 #= 2, V5 in {3,4}); (S4 #= 1, V4 in {3,4}, V5 #= 2)))),

    (S3 in {2,3}, N3 #\= 1,
    ((S1 #= 5, N1 #\= 1); (S2 #= 5, N2 #\= 1);
    (S4 #= 5, N4 #\= 1); (S5 #= 5, N5 #\= 1))), 

    ((S1 #= 4, V1 in {1, 3, 4});
    (S2 #= 4, V2 in {1, 3, 4});
    (S3 #= 4, V3 in {1, 3, 4});
    (S4 #= 4, V4 in {1, 3, 4});
    (S5 #= 4, V5 in {1, 3, 4})),

    ((N3 #\= 5),
    (((N1 #= 3, V1 in {1, 2, 5}); 
    (N2 #= 3, V2 in {1, 2, 5}); 
    (N3 #= 3, V3 in {1, 2, 5}); 
    (N4 #= 3, V4 in {1, 2, 5}); 
    (N5 #= 3, V5 in {1, 2, 5})),
    ((N1 #= 5, V1 in {1, 2, 5}); 
    (N2 #= 5, V2 in {1, 2, 5}); 
    (N4 #= 5, V4 in {1, 2, 5}); 
    (N5 #= 5, V5 in {1, 2, 5})))),

    (N3 #\= 2, N5 #\= 1),

    ((S1 in {1, 4, 5}, V1 #= 5);
    (S2 in {1, 4, 5}, V2 #= 5);
    (S3 in {1, 4, 5}, V3 #= 5);
    (S4 in {1, 4, 5}, V4 #= 5);
    (S5 in {1, 4, 5}, V5 #= 5)),

    labeling([], 
        [N1, S1, V1, 
        N2, S2, V2, 
        N3, S3, V3,
        N4, S4, V4,
        N5, S5, V5]),

    write('Student1 = '), write('[ '), write(N1), tab(1), write(S1), tab(1), write(V1), write(' ]'), nl,
    write('Student2 = '), write('[ '), write(N2), tab(1), write(S2), tab(1), write(V2), write(' ]'), nl,
    write('Student3 = '), write('[ '), write(N3), tab(1), write(S3), tab(1), write(V3), write(' ]'), nl,
    write('Student4 = '), write('[ '), write(N4), tab(1), write(S4), tab(1), write(V4), write(' ]'), nl,
    write('Student5 = '), write('[ '), write(N5), tab(1), write(S5), tab(1), write(V5), write(' ]').