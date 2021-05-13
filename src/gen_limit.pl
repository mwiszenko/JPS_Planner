% gen_limit

gen_limit(Curr, Max, Curr) :-
    Curr < Max.

gen_limit(Curr, Max, Next) :-
    Curr < Max,
    NewCurr is Curr + 1,
    gen_limit(NewCurr, Max, Next).
