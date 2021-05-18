:- [goals_achieved].

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

% test inst_action

:- begin_tests(inst_action).

test(1, [nondet]) :-
    inst_action(move(a, b, c), on(a, c), [on(a, b), clear(d)], X),
    X == move(a, b, c).

test(2, [fail]) :-
    inst_action(move(a, b, c), on(a, c), [on(a, d), clear(c)], _).

test(3, [nondet]) :-
    inst_action(move(a/on(a, b), b, c/clear(c)), clear(b), [on(a, b), clear(c)], X),
    X == move(a, b, c).

test(4, [fail]) :-
    inst_action(move(a, b, c), clear(b), [on(a, d), clear(d)], _).

:- end_tests(inst_action).

% test conds_achieved

:- begin_tests(conds_achieved).

test(1, [nondet]) :-
    conds_achieved(a/on(a, b), c, [on(a, b), clear(c)]).

test(2, [nondet]) :-
    conds_achieved(a, c/clear(c), [on(a, b), clear(c)]).

test(3, [fail]) :-
    conds_achieved(a/on(a, b), c, [on(a, d), clear(c)]).

:- end_tests(conds_achieved).

% test inst

:- begin_tests(inst).

test(1, [nondet]) :-
    inst(a/on(a, b), [on(a, b), clear(c)], X),
    X == a.

test(2) :-
    inst(a, [on(a, b), clear(c)], X),
    X == a.

:- end_tests(inst).
