:- [goals_achieved].

% choose_goal --- z podanej listy celów wybiera do przetwarzania cel, który nie jest spełniony w
% aktualnym stanie.

choose_goal(Goal, [Goal|RestGoals], RestGoals, State) :-
    not(goal_achieved(Goal, State)).
	
choose_goal(Goal, [X|Goals], [X|RestGoals], State) :-
    choose_goal(Goal, Goals, RestGoals, State).
