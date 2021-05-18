% achieves --- określa akcję osiągającą podany cel. Cel może być zarówno ukonkretniony, jak i nie
% ukonkretniony--z argumentami w postaci zmiennych z nałożonymi warunkami. W konsekwencji
% również struktura reprezentująca akcję--wynik wykonania procedury--może zawierać zarówno
% symbole, reprezentujące konkretne obiekty, jak i zmienne z nałożonymi warunkami.

achieves(on(What, On), move(What, From/(on(What, From)), On)).

achieves(clear(On), move(What/on(What, On), On, _)).

% test achieves

:- begin_tests(achieves).

test(1) :-
    achieves(on(a, b), move(X, c/on(Y, c), Z)),
    X == a, Y == a, Z == b.

test(2) :-
    achieves(clear(a), move(b/on(b, X), Y, c)),
    X == a, Y == a.

:- end_tests(achieves).
