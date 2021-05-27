% Pusta lista celów:
% plan([on(b3, b1), on(b1, b4), on(b4, p1), on(b2, p3), clear(b3), clear(p2), clear(b2), clear(p4)], [], 5, A, B).

% Wszystkie cele od razu osiągnięte:
% plan([on(b3, b1), on(b1, b4), on(b4, p1), on(b2, p3), clear(b3), clear(p2), clear(b2), clear(p4)], [on(b3, b1), on(b4, p1), clear(b3)], 5, A, B).

% Jeden cel do osiągnięcia:
% plan([on(b3, b1), on(b1, b4), on(b4, p1), on(b2, p3), clear(b3), clear(p2), clear(b2), clear(p4)], [on(b4, b2)], 5, A, B).

% Wiele celi do osiągnięcia:
% plan([on(b3, b1), on(b1, b4), on(b4, p1), on(b2, p3), clear(b3), clear(p2), clear(b2), clear(p4)], [on(b4, b2), clear(p1), on(b2, b1), clear(p2), on(b1, p4)], 10, A, B).

% Za mały limit długości planu:
% plan([on(b3, b1), on(b1, b4), on(b4, p1), on(b2, p3), clear(b3), clear(p2), clear(b2), clear(p4)], [on(b4, b2), clear(p1), on(b2, b1), clear(p2), on(b1, p4)], 4, A, B).

% Niemożliwy do zrealizowania:
% plan([on(b3, b1), on(b1, b4), on(b4, p1), on(b2, p3), clear(b3), clear(p2), clear(b2), clear(p4)], [on(b4, b1), on(b1, b4)], 10, A, B).

:- [utils, goals_achieved, requires, achieves, inst_action, perform_action, check_action, gen_limit, choose_goal].

plan(InitState, Goals, MaxLimit, Plan, FinalState) :-
    gen_limit(0, MaxLimit + 1, Limit),
    write('Current plan length limit: '), write(Limit), nl,
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
