plan(State, Goals, [ ], State) :- goals_achieved(Goals, State), !.

plan(InitState, Goals, Plan, FinalState) :-
	choose_goal(Goal, Goals, RestGoals, InitState),
    achieves(Goal, Action),
    requires(Action, CondGoals),
    plan(InitState, CondGoals, PrePlan, State1),
    inst_action(Action, Goal, State1, InstAction),
    perform_action(State1, InstAction, State2),
    plan(State2, RestGoals, PostPlan, FinalState),
    conc(PrePlan, [ InstAction | PostPlan ], Plan), !.

% conc
conc([], L, L) :- !.

conc([H|T1], L, [H|T2]) :-
    conc(T1, L, T2).

% mem
mem(X, [X|_]).

mem(X, [_|T]) :-
    mem(X, T).

% del
del(X, [X|T], T) :- !.

del(X, [Y|T1], [Y|T2]) :-
    del(X, T1, T2).

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

goal_achieved(on(A, B), State) :-
	mem(on(A, B), State).

goal_achieved(clear(A), State) :-
    mem(clear(A), State).
	
goal_achieved(clear(A/Goal), State) :-
	goal_achieved(Goal, State),
	mem(clear(A), State).

goal_achieved(on(A, B/Goal), State) :-
	goal_achieved(Goal, State),
	mem(on(A, B), State).

goal_achieved(dif(A/W1, B/W2), State) :-
	goal_achieved(W1, State),
	goal_achieved(W2, State),
	dif(A, B).

% requires --- określa warunki wykonania podanej akcji, które stają się celami dla następnego kroku
% algorytmu.

requires(move(What, From/on(What, From), On), [clear(What), clear(On)]).

requires(move(What, _, _), [clear(What)]).

% achieves --- określa akcję osiągającą podany cel. Cel może być zarówno ukonkretniony, jak i nie
% ukonkretniony--z argumentami w postaci zmiennych z nałożonymi warunkami. W konsekwencji
% również struktura reprezentująca akcję--wynik wykonania procedury--może zawierać zarówno
% symbole, reprezentujące konkretne obiekty, jak i zmienne z nałożonymi warunkami.

achieves(on(What, On), move(What, From/(on(What, From)), On)).

achieves(clear(On), move(What/on(What, On), On, _)).

% choose_goal --- z podanej listy celów wybiera do przetwarzania cel, który nie jest spełniony w
% aktualnym stanie.

choose_goal(Goal, [Goal|RestGoals], RestGoals, State) :-
	not(goal_achieved(Goal, State)).
	
choose_goal(Goal, [X|Goals], [X|RestGoals], State) :-
	choose_goal(Goal, Goals, RestGoals, State).

% perform_action - określa stan osiągany ze stanu podanego przez wykonanie podanej akcji. 
% wykonuje akcje, czyli: z podanych operacji move oraz stanu, do którego chcemy dojść wyłuskujemy
% informacje o tym, jaki stan wyjściowy powinien mieć zależności a jakich nie, i odpowiednio
% te zależności dodajemy (procedura listowa member) oraz usuwamy (procedura listowa delete)

perform_action(State1, move(What, From, On), [on(What, On), clear(From) | State2]) :-
    mem(clear(On), State1),
    mem(on(What, From), State1),
    del(on(What, From), State1, StateTemp),
    del(clear(On), StateTemp, State2).

% inst_action --- ukonkretnia akcję przed wykonaniem . W zależności od rodzaju celu, 
% do którego akcja była dobrana przez procedurę achieves, niektóre/wszystkie zmienne 
% występujące w argumentach akcji nie ukonkretnionej mogą mieć w chwili wywołania inst_action 
% przypisane wartości (przypisanie wartości nastąpiło w ramach konstruowania preplanu).

inst_action(move(What, From, On), on(_, _), State, move(InstWhat, InstFrom, InstOn)) :-
	goal_achieved(on(What, From), State),
    inst_variable(What, State, InstWhat),
	inst_variable(From, State, InstFrom),
	inst_variable(On, State, InstOn).

inst_action(move(What, From, On), clear(_), State, move(InstWhat, InstFrom, InstOn)) :-
	goals_achieved([clear(On), dif(On, What)], State),
    inst_variable(What, State, InstWhat),
	inst_variable(From, State, InstFrom),
	inst_variable(On, State, InstOn).

inst_variable(A/B, State, A) :-
	goal_achieved(B, State).
	
inst_variable(A, _, A).