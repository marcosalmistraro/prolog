/* Five men with different nationalities live in the first five houses of a street. 
They practice five distinct professions.
Each of them has a favorite animal and a favorite drink, all of them different. 
The five houses are painted different colors.

The following facts are known:

1. The English man lives in a red house.
2. The Spanish man owns a dog.
3. The Japanese is a painter.
4. The Italian drinks tea.
5. The Norwegian lives in the first house on the left.
6. The owner of the green house drinks coffee.
7. The green house is on the right of the white one.
8. The sculptor breeds snails.
9. The diplomat lives in the yellow house.
10. Milk is drunk in the middle house.
11. The Norwegian's house is next to the blue one. 
12. The violinist drinks fruit juice.
13. The fox is in the house next to that of the doctor.
14. The horse is in the house next to that of the diplomat. 

The following program identifies who owns a zebra and who drinks water.

    House Order:    1.           2.             3.              4.              5.
    Nationalities:  1. English   2. Italian     3. Japanese     4. Norwegian    5. Spanish
    Professions:    1. Painter   2. Violinist   3. Sculptor     4. Diplomat     5. Doctor
    House Colors:   1. Red       2. Blue        3. Green        4. Yellow       5. White
    Animals:        1. Dog       2. Horse       3. Fox          4. Snails       5. Zebra        
    Drinks:         1. Tea       2. Coffee      3. Juice        4. Milk         5. Water
*/

:- use_module(library(clpfd)).

solve(Water, Zebra):-

    Vars = [English, Italian, Japanese, Norwegian, Spanish,
    Painter, Violinist, Sculptor, Diplomat, Doctor,
    Red, Blue, Green, Yellow, White,
    Dog, Horse, Fox, Snails, Zebra,
    Tea, Coffee, Juice, Milk, Water],
    
    Vars ins 1..5,

    English #= Red,
    Spanish #= Dog,
    Japanese #= Painter,
    Coffee #= Green,
    Italian #= Tea,
    Norwegian #= 1,
    Green #= Coffee,
    Green #= White + 1,
    Sculptor #= Snails,
    Diplomat #= Yellow,
    Milk #= 3,
    next_to(Norwegian, Blue),
    Violinist #= Juice,
    next_to(Fox, Doctor),
    next_to(Horse, Diplomat),

    all_different([English, Spanish, Italian, Japanese, Norwegian]),
    all_different([Red, Green, Yellow, Blue, White]),
    all_different([Coffee, Water, Milk, Juice, Tea]),
    all_different([Dog, Fox, Horse, Snails, Zebra]),
    all_different([Painter, Violinist, Sculptor, Diplomat, Doctor]),

    labeling([], Vars),

    write(Vars).

next_to(A, B):-
    abs(A - B) #= 1.