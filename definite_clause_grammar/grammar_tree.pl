/* parsing English sentences using DCG trees */

sentence(Number, sentence(NP, VP)) --> 
    noun_phrase(Number, NP), 
    verb_phrase(Number, VP).

verb_phrase(Number, verb_phrase(Verb, NP)) --> 
    verb(Number, Verb), 
    noun_phrase(_, NP).

noun_phrase(Number, noun_phrase(Det, Noun)) --> 
    determiner(Det), 
    noun(Number, Noun).

determiner(determiner(the)) --> [the].

noun(singular, noun(mouse)) --> [mouse].
noun(plural, noun(mice)) --> [mice].
noun(singular, noun(cat)) --> [cat].
noun(plural, noun(cats)) --> [cats].

verb(singular, verb(hates)) --> [hates].
verb(plural, verb(hate)) --> [hate].
verb(singular, verb(loves)) --> [loves].
verb(plural, verb(love)) --> [love].