# Prolog

A collection of Prolog programs written during the **Programming Languages and Methodologies** course
of my Advanced Master's in Artificial Intelligence at KU Leuven.

Each folder groups programs around one concept or technique. Most files are small, self-contained
exercises that can be loaded and queried independently.

## Getting started

Install [SWI-Prolog](https://www.swi-prolog.org/Download.html), then load any file and run a query:

```bash
swipl accumulators/factorial.pl
```

```prolog
?- factorial(5, X).
```

*(Replace the predicate in the example with the one actually defined in the file.)*

## Contents

| Folder | Topic | Programs |
| --- | --- | --- |
| `accumulators/` | Accumulator-based recursion | factorial, list length, list inversion |
| `arithmetic/` | Number theory | Goldbach conjecture, prime checker |
| `binary_trees/` | Tree construction and traversal | balanced tree, depth, membership, balance check, preorder |
| `constraint_satisfaction/` | Constraint logic programming (CLP) | cryptoarithmetic, N-queens, safe combination, sudoku generator |
| `definite_clause_grammar/` | DCGs and parsing | number converter, robot moves, parse trees, context dependency |
| `difference_lists/` | Difference lists | flatten list/tree, increment list, invert list |
| `failure_driven_loops/` | Failure-driven loops | average, squares, list iteration |
| `graphs/` | Search and state-space problems | graph paths and loops, missionaries and cannibals, water jugs |
| `knights_tour/` | Heuristic search | knight's tour |
| `lists/` | List manipulation | slices, rotations, palindromes, sorting, permutations, reification count |
| `machine_learning/` | Machine learning in Prolog | k-nearest neighbours on the wine dataset |
| `useful/` | Reusable helper predicates | general-purpose predicates used across the other programs |

## Concepts covered

Accumulators, binary trees, constraint logic programming, definite clause grammars,
declarative vs procedural meaning, difference lists, failure-driven loops,
generate-and-test, heuristic functions, list manipulation, reification.

## Notes

This is learning material, written as coursework. The code favours clarity over performance.