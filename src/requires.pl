% requires --- określa warunki wykonania podanej akcji, które stają się celami dla następnego kroku
% algorytmu.

requires(move(What, From/on(What, From), On), [clear(What), clear(On)]).

requires(move(What/on(What, From), From, _), [clear(What/on(What, From))]).

% test requires

:- begin_tests(requires).

test(1) :-
    requires(move(a, b/on(a, b), c), Conds),
    Conds == [clear(a), clear(c)].

test(2) :-
    requires(move(a/on(a, b), b, c), Conds),
    Conds == [clear(a/on(a, b))].

:- end_tests(requires).
