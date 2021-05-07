% inst_action --- ukonkretnia akcję przed wykonaniem . W zależności od rodzaju celu, 
% do którego akcja była dobrana przez procedurę achieves, niektóre/wszystkie zmienne 
% występujące w argumentach akcji nie ukonkretnionej mogą mieć w chwili wywołania inst_action 
% przypisane wartości (przypisanie wartości nastąpiło w ramach konstruowania preplanu).

inst_action(move(What, From, On), on(What, On), State, move(InstWhat, InstFrom, InstOn)) :-
    goals_achieved([on(What, From)], State),
    inst(What, State, InstWhat),
    inst(From, State, InstFrom),
    inst(On, State, InstOn).

inst_action(move(What, From, On), clear(From), State, move(InstWhat, InstFrom, InstOn)) :-
    goals_achieved([clear(On)], State),
    conds_achieved(What, On, State),
    inst(What, State, InstWhat),
    inst(From, State, InstFrom),
    inst(On, State, InstOn).

% conds_achieved

conds_achieved(A/B, C, State) :-
    A \= C,
    goal_achieved(B, State).

conds_achieved(A, B/C, State) :-
    A \= B,
    goal_achieved(C, State).

% inst

inst(A, _, A).

inst(A/B, State, A) :-
    goal_achieved(B, State).
