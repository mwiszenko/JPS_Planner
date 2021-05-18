:- [utils].

% goals_achieved --- sprawdza, czy wszystkie cele z podanej listy są spełnione w aktualnym stanie.
% Cele mogą być zarówno ukonkretnione, jak i nie ukonkretnione—z argumentami w postaci zmiennych
% z nałożonymi warunkami.
% W zależności od wyniku sprawdzenia wykonanie procedury kończy się powodzeniem albo
% niepowodzeniem.

goals_achieved([], _).

goals_achieved([Goal|RestGoals], State) :-
    goal_achieved(Goal, State),
    goals_achieved(RestGoals, State).

% goal_achieved --- sprawdza, czy pojedynczy cel jest spełniony z podanej listy.

goal_achieved(clear(A), State) :-
    mem(clear(A), State).

goal_achieved(clear(A/B), State) :-
    nonvar(B),
    mem(clear(A), State),
    goal_achieved(B, State).

goal_achieved(on(A, B), State) :-
    mem(on(A, B), State).

goal_achieved(on(A, B/C), State) :-
    nonvar(C),
    mem(on(A, B), State),
    goal_achieved(C, State).

% test goals_achieved

:- begin_tests(goals_achieved).

test(1) :-
    goals_achieved([], [on(a, b), clear(b)]).

test(2, [nondet]) :-
    goals_achieved([on(a, X)], [on(a, b), clear(b)]),
    X == b.

test(3, [nondet]) :-
    goals_achieved([on(a, b), clear(b)], [clear(c), clear(b), on(a, b)]).

:- end_tests(goals_achieved).

% test goal_achieved

:- begin_tests(goal_achieved).

test(1, [nondet]) :-
    goal_achieved(clear(a), [on(a, b), clear(a)]).

test(2, [nondet]) :-
    not(goal_achieved(clear(a), [on(a, b), clear(b)])).

test(3, [nondet]) :-
    not(goal_achieved(on(a, _), [clear(a), clear(b)])).

test(4, [nondet]) :-
    goal_achieved(clear(a/on(a, X)), [clear(a), clear(b), on(a, b)]),
    X == b.

:- end_tests(goal_achieved).
