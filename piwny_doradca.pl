:- dynamic
    xpozytywne/2,
    xnegatywne/2.

piwo_jest(lager) :- barwa_jest(jasne).
piwo_jest(lager) :- zapach_jest(slodowy).
piwo_jest(lager) :- goryczka_jest(mala).

piwo_jest(ipa) :- barwa_jest(jasne).
piwo_jest(ipa) :- zapach_jest(owocowy).
piwo_jest(ipa) :- goryczka_jest(srednia).

piwo_jest(double_ipa) :- barwa_jest(jasne).
piwo_jest(double_ipa) :- zapach_jest(owocowy).
piwo_jest(double_ipa) :- goryczka_jest(duza).

piwo_jest(porter) :- barwa_jest(ciemne).

barwa_jest(jasne) :- pozytywne(czy,klasyczne).
barwa_jest(jasne) :- negatywne(dopuszczalne,eksperymentowanie).
barwa_jest(ciemne) :- lubi(kawa).

goryczka_jest(mala) :- lubi(piwo_wielkich_browarow).
goryczka_jest(srednia) :- lubi(kawa).
goryczka_jest(duza) :- lubi(bardzo_gorzki_smak).

zapach_jest(slodowy) :- lubi(zwyczajne_piwo).
zapach_jest(owocowy) :- lubi(owoce).
zapach_jest(mocno_alkoholowy) :- lubi(mocne_alkohole).

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
