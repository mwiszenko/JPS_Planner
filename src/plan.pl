:- [utils, goals_achieved, requires, achieves, inst_action, perform_action, check_action, gen_limit, choose_goal].

plan(InitState, Goals, MaxLimit, Plan, FinalState) :-
    gen_limit(0, MaxLimit, Limit),
    plan(InitState, Goals, [], Limit, Plan, FinalState).

plan(State, Goals, _, _, [], State) :- goals_achieved(Goals, State).

plan(InitState, Goals, AchievedGoals, Limit, Plan, FinalState) :-
    Limit >= 0,
    gen_limit(0, Limit, LimitPre),
    choose_goal(Goal, Goals, RestGoals, InitState),
    achieves(Goal, Action),
    requires(Action, CondGoals),
    plan(InitState, CondGoals, AchievedGoals, LimitPre, PrePlan, State1),
    inst_action(Action, Goal, State1, InstAction),
    perform_action(State1, InstAction, State2),
    check_action(InstAction, AchievedGoals),
    LimitPost is Limit - LimitPre - 1,
    conc([Goal], AchievedGoals, AchievedGoals1),
    plan(State2, RestGoals, AchievedGoals1, LimitPost, PostPlan, FinalState),
    conc(PrePlan, [ InstAction | PostPlan ], Plan).
