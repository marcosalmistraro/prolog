% Example exam exercise - represent information using prolog predicates

score(fai, johan, 20).
score(plpm, johan, 15).
score(fai, timothy, 14).
score(plpm, timothy, 18).
score(uai, timothy, 4).

max_score_list([[MaxName, MaxScore]], [MaxName, MaxScore]).
max_score_list([[HName, HScore]|T], [HName, HScore]):-
    max_score_list(T, [_, MaxT]),
    HScore >= MaxT.
max_score_list([[_, HScore]|T], [MaxName, MaxScore]):-
    max_score_list(T, [MaxName, MaxScore]),
    HScore < MaxScore.

get_list(Course, NameScoreList):-
    findall([Student, Score], score(Course, Student, Score), NameScoreList).

top_score(Course, [TopName, TopScore]):-
    get_list(Course, [[TopName, TopScore]]).

top_score(Course, [TopName, TopScore]):-
    get_list(Course, [[HName, HScore]|T]),
    max_score_list(T, [_, MaxT]),
    HScore >= MaxT,
    HName = TopName,
    HScore = TopScore.

top_score(Course, [TopName, TopScore]):-
    get_list(Course, [[_, HScore]|T]),
    max_score_list(T, [TopName, TopScore]),
    HScore < TopScore.