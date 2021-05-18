% gen_limit

gen_limit(Curr, Max, Curr) :-
    Curr < Max.

gen_limit(Curr, Max, Next) :-
    Curr < Max,
    NewCurr is Curr + 1,
    gen_limit(NewCurr, Max, Next).

% test gen_limit

:- begin_tests(gen_limit).

test(1, [nondet]) :-
    gen_limit(10, 50, 10).

test(2, [nondet]) :-
    gen_limit(0, 5, X),
    X == 1.

test(3, [fail]) :-
    gen_limit(6, 5, _).

:- end_tests(gen_limit).
