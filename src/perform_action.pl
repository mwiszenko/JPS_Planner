:- [utils].

% perform_action - określa stan osiągany ze stanu podanego przez wykonanie podanej akcji. 
% wykonuje akcje, czyli: z podanych operacji move oraz stanu, do którego chcemy dojść wyłuskujemy
% informacje o tym, jaki stan wyjściowy powinien mieć zależności a jakich nie, i odpowiednio
% te zależności dodajemy (procedura listowa member) oraz usuwamy (procedura listowa delete)

perform_action(State1, move(What, From, On), [on(What, On), clear(From) | State2]) :-
    mem(clear(On), State1),
    mem(on(What, From), State1),
    del(on(What, From), State1, StateTemp),
    del(clear(On), StateTemp, State2).

% test perform_action

:- begin_tests(perform_action).

test(1, [nondet]) :-
    perform_action([on(a, b), clear(a), on(b, p1), clear(p2)], move(a, b, p2), X),
    X == [on(a, p2), clear(b), clear(a), on(b, p1)].

:- end_tests(perform_action).
