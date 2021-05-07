% requires --- określa warunki wykonania podanej akcji, które stają się celami dla następnego kroku
% algorytmu.

requires(move(What, From/on(What, From), On), [clear(What), clear(On)]).

requires(move(What/on(What, From), From, _), [clear(What/on(What, From))]).
