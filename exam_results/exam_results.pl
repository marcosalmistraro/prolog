/* Representing exam results by using Prolog facts and terms */

% Facts

exam(danny, fai, 20).
exam(danny, plpm, 15).
exam(toon, plpm, 18).
exam(toon, fai, 14).
exam(toon, uai, 4).

/* Terms

danny/fai/20
danny/plplm/15
toon/plpm/18
toon/fai/14
toon/uai/4 */

% define the predicate topscore/2 for facts

max_list([H], H).
max_list([H|T], H):-
    max_list(T, MaxT),
    H >= MaxT.
max_list([H|T], MaxT):-
    max_list(T, MaxT),
    H < MaxT.

find_top_student(List, TopStudent):-
    findall(Score, member((_, Score), List), Scores),
    max_list(Scores, TopScore),
    member((TopStudent, TopScore), List).

topscore(Course, Student):-
    findall((Student, Score), exam(Student, Course, Score), NamesScores),
    find_top_student(NamesScores, Student).

% define the predicate topscore/3 for prolog terms

topscore_terms(Course, TermList, Student):-
    findall((Student, Score), member(Student/Course/Score, TermList), NamesScores),
    find_top_student(NamesScores, Student).