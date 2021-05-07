% requires --- określa warunki wykonania podanej akcji, które stają się celami dla następnego kroku
% algorytmu.

requires(move(What, From/on(What, From), On), [clear(What), clear(On)]).

requires(move(What/on(What, From), From, _), [clear(What/on(What, From))]).

:- begin_tests(requires).

test(1, Conds == [clear(a), clear(c)]) :-
    requires(move(a, b/on(a, b), c), Conds).

test(2, Conds == [clear(a/on(a, b))]) :-
    requires(move(a/on(a, b), b, c), Conds).

:- end_tests(requires).
