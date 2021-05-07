% check_action

check_action(move(What, From, On), AchievedGoals) :-
    not(goal_achieved(on(What, From), AchievedGoals)),
    not(goal_achieved(clear(On), AchievedGoals)).
