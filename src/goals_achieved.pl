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
