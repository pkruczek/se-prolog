:- dynamic
    xpozytywne/2,
    xnegatywne/2.

piwo_jest(lager) :- jest(jasne).
piwo_jest(porter) :- jest(ciemne).

jest(jasne) :- pozytywne(czy,klasyczne).

jest(jasne) :- negatywne(dopuszczalne,eksperymentowanie).

jest(ciemne) :- lubi(kawa).

pozytywne(X,Y) :- xpozytywne(X,Y), !.

pozytywne(X,Y) :- \+xnegatywne(X,Y), pytaj(X,Y,tak).

negatywne(X,Y) :- xnegatywne(X,Y), !.

negatywne(X,Y) :- \+xpozytywne(X,Y), pytaj(X,Y,nie).

lubi(X) :- czy_lubi(X,tak).

czy_lubi(X,tak) :- !, format('Czy lubisz ~w? (t/n)~n',[X]),
                    read(Reply),
                    (Reply = 't'),
                    pamietaj(X,lubi,tak).

czy_lubi(X,nie) :- !, format('Czy lubisz ~w? (t/n)~n',[X]),
                    read(Reply),
                    (Reply = 'n'),
                    pamietaj(X,lubi,nie).

pytaj(X,Y,tak) :- !, format('~w jest ~w ? (t/n)~n',[X,Y]),
                    read(Reply),
                    (Reply = 't'),
                    pamietaj(X,Y,tak).

pytaj(X,Y,nie) :- !, format('~w jest ~w ? (t/n)~n',[X,Y]),
                    read(Reply),
                    (Reply = 'n'),
                    pamietaj(X,Y,nie).

pamietaj(X,Y,tak) :- assertz(xpozytywne(X,Y)).

pamietaj(X,Y,nie) :- assertz(xnegatywne(X,Y)).

wyczysc_fakty :- write('Przycisnij cos aby wyjsc'), nl,
                    retractall(xpozytywne(_,_)),
                    retractall(xnegatywne(_,_)),
                    get_char(_).

wykonaj :- piwo_jest(X), !,
            format('~nSpróbuj piwa ~w', X),
            nl, wyczysc_fakty.

wykonaj :- write('Nie można zaleźć piwa spełniającego Twoje wymagania.'), nl,
            wyczysc_fakty.
