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

test(1) :-
    conc([], [], Res),
    Res == [].

test(2) :-
    conc([], [a, b, c], Res),
    Res == [a, b, c].

test(3) :-
    conc([a, b, c], [], Res),
    Res == [a, b, c].

test(4) :-
    conc([a], [b, c], Res),
    Res == [a, b, c].

test(5) :-
    conc([a], [a, b, a], Res),
    Res == [a, a, b, a].

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

test(1) :-
    del(a, [a, b, c], Res),
    Res == [b, c].

test(2) :-
    del(a, [b, a, c], Res),
    Res == [b, c].

test(3) :-
    del(a, [a, a, a], Res),
    Res == [a, a].

:- end_tests(del).
