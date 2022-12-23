/* Example of DCG parsing English sentences.
This grammar also generates sentences that 
are not entirely correct since it lacks context-dependency */

sentence --> noun_phrase, verb_phrase.

verb_phrase --> verb, noun_phrase.
noun_phrase --> determiner, noun.

determiner --> [a].
determiner --> [the].

noun --> [cat].
noun --> [cats].
noun --> [mouse].
noun --> [mice].

verb --> [scares].
verb --> [hates].

% Implementing context-dependency by adding arguments

cd_sentence(Number) --> cd_noun_phrase(Number), cd_verb_phrase(Number).

cd_verb_phrase(Number) --> cd_verb(Number), cd_noun_phrase(_).
cd_noun_phrase(Number) --> cd_determiner, cd_noun(Number).

cd_determiner --> [a].
cd_determiner --> [the].

cd_noun(singular) --> [mouse].
cd_noun(plural) --> [mice].
cd_noun(singular) --> [cat].
cd_noun(plural) --> [cats].

cd_verb(singular) --> [hates].
cd_verb(plural) --> [hate].