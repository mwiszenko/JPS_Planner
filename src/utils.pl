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

