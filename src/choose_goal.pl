:- [goals_achieved].

% choose_goal --- z podanej listy celów wybiera do przetwarzania cel, który nie jest spełniony w
% aktualnym stanie.

choose_goal(Goal, [Goal|RestGoals], RestGoals, State) :-
    not(goal_achieved(Goal, State)).
	
choose_goal(Goal, [X|Goals], [X|RestGoals], State) :-
    choose_goal(Goal, Goals, RestGoals, State).

% test choose_goal

:- begin_tests(choose_goal).

test(1, [nondet]) :-
    choose_goal(X, [on(a, b), clear(c)], Y, []),
    X == on(a, b), Y == [clear(c)].

test(2, [nondet]) :-
    choose_goal(X, [on(a, b), clear(c)], Y, [on(a, b)]),
    X == clear(c), Y = [on(a, b)].

:- end_tests(choose_goal).
