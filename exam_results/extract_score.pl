/* Example exam exercise - represent information using prolog terms */

max_score_list([[MaxName, MaxScore]], [MaxName, MaxScore]).
max_score_list([[HName, HScore]|T], [HName, HScore]):-
    max_score_list(T, [_, MaxT]),
    HScore >= MaxT.
max_score_list([[_, HScore]|T], [MaxName, MaxT]):-
    max_score_list(T, [MaxName, MaxT]),
    HScore < MaxT.

get_list(Course, InputList, NameScoreList):-
    findall([Name, Score], member([Course, Name, Score], InputList), NameScoreList).

top_score(Course, [[Course, TopName, TopScore]], [TopName, TopScore]).

top_score(Course, InputList, [HName, HScore]):-
    get_list(Course, InputList, [[HName, HScore]|T]),
    max_score_list(T, [_, MaxT]),
    HScore >= MaxT.

top_score(Course, InputList, [MaxName, MaxT]):-
    get_list(Course, InputList, [[_, HScore]|T]),
    max_score_list(T, [MaxName, MaxT]),
    HScore < MaxT.