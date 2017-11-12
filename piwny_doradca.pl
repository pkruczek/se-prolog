:- dynamic
    xlubi/1,
    xnie_lubi/1.

piwo_jest(lager) :- barwa_jest(jasne), zapach_jest(slodowy).
piwo_jest(lager) :- barwa_jest(jasne), goryczka_jest(mala).

piwo_jest(ipa) :- barwa_jest(jasne), zapach_jest(owocowy).
piwo_jest(ipa) :- barwa_jest(jasne), goryczka_jest(srednia).

piwo_jest(double_ipa) :- barwa_jest(jasne), zapach_jest(owocowy).
piwo_jest(double_ipa) :- barwa_jest(jasne), goryczka_jest(duza).

piwo_jest(porter) :- barwa_jest(ciemne).

barwa_jest(jasne) :- lubi(klasyczne_piwo).
barwa_jest(jasne) :- nie_lubi(piwne_eksperymenty).
barwa_jest(ciemne) :- lubi(kawa).

goryczka_jest(mala) :- lubi(piwo_wielkich_browarow).
goryczka_jest(srednia) :- lubi(kawa).
goryczka_jest(duza) :- lubi(bardzo_gorzki_smak).

zapach_jest(slodowy) :- lubi(klasyczne_piwo).
zapach_jest(owocowy) :- lubi(owoce).
zapach_jest(mocno_alkoholowy) :- lubi(mocne_alkohole).

lubi(X) :- xlubi(X), !.
lubi(X) :- \+xnie_lubi(X), pytaj(X,tak).

nie_lubi(X) :- xnie_lubi(X), !.
nie_lubi(X) :- \+xlubi(X), pytaj(X,nie).

pytaj(X,tak) :- !, format('Czy lubisz ~w ? (t/n)~n',[X]),
                    read(Reply),
                    (Reply = 't'),
                    pamietaj(X,tak).

pytaj(X,nie) :- !, format('Czy lubisz ~w ? (t/n)~n',[X]),
                    read(Reply),
                    (Reply = 'n'),
                    pamietaj(X,nie).

pamietaj(X,tak) :- assertz(xlubi(X)).
pamietaj(X,nie) :- assertz(xnie_lubi(X)).

wyczysc_fakty :- write('Przycisnij cos aby wyjsc'), nl,
                    retractall(xlubi(_,_)),
                    retractall(xnie_lubi(_,_)),
                    get_char(_).

wykonaj :- piwo_jest(X), !,
            format('~nSpróbuj piwa ~w', X),
            nl, wyczysc_fakty.

wykonaj :- write('Nie można zaleźć piwa spełniającego Twoje wymagania.'), nl,
            wyczysc_fakty.
