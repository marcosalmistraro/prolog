/* The following grammar generates strings of the type
count_times_a, c, count_times_b 

In spite of constructing a parse tree we implement conditions 
in the collapsed DCG form, using curly brackets */


s(0) --> [c].
s(Count) --> [a], s(C0), [b], {Count is C0 + 1}.