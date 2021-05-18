:- [goals_achieved].

% check_action

check_action(move(What, From, On), AchievedGoals) :-
    not(goal_achieved(on(What, From), AchievedGoals)),
    not(goal_achieved(clear(On), AchievedGoals)).

% test check_action

:- begin_tests(check_action).

test(1) :-
    check_action(move(a, b, c), [on(a, c)]).

test(2, [fail]) :-
    check_action(move(a, b, c), [on(a, b)]).

test(3) :-
    check_action(move(a, b/on(a, b), c), [on(a, c), clear(p1)]).

test(4, [fail]) :-
    check_action(move(a, b/on(a, b), c), [on(a, b)]).

:- end_tests(check_action).
