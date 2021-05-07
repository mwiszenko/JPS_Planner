% conc

conc([], L, L) :- !.

conc([H|T1], L, [H|T2]) :-
    conc(T1, L, T2).

% mem

mem(X, [X|_]).

mem(X, [_|T]) :-
    mem(X, T).

% del

del(X, [X|T], T) :- !.

del(X, [Y|T1], [Y|T2]) :-
    del(X, T1, T2).

% test conc

:- begin_tests(conc).

test(1, Res == []) :-
    conc([], [], Res).

test(2, Res == [a, b, c]) :-
    conc([], [a, b, c], Res).

test(3, Res == [a, b, c]) :-
    conc([a, b, c], [], Res).

test(4, Res == [a, b, c]) :-
    conc([a], [b, c], Res).

test(5, Res == [a, a, b, a]) :-
    conc([a], [a, b, a], Res).

:- end_tests(conc).

% test mem

:- begin_tests(mem).

test(1, [nondet]) :-
    mem(a, [a, b, c]).

test(2, [nondet]) :-
    mem(a, [a, b, c]).

test(3, [nondet]) :-
    not(mem(a, [])).

test(4, [nondet]) :-
    not(mem(a, [b, c, d])).

test(5, [nondet]) :-
    mem(a, [a, b, a]).

:- end_tests(mem).

% test del

:- begin_tests(del).

test(1, Res == [b, c]) :-
    del(a, [a, b, c], Res).

test(2, Res == [b, c]) :-
    del(a, [b, a, c], Res).

test(3, Res == [a, a]) :-
    del(a, [a, a, a], Res).

:- end_tests(del).
