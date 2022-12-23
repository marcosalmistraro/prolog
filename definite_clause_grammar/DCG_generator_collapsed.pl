/* The following grammar generates strings of the type:

count_times_a, c, count_times_b

Conditions are implemented in the collapsed DCG form, using curly brackets.
A parse tree is thereby not necessary */

s(0) --> [c].
s(Count) --> [a], s(C0), [b], {Count is C0 + 1}.