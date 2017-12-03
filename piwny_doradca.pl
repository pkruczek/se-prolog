:- use_module(library(jpl)).

% Expert system should be started from here
main :-
  intro,
  reset_answers,
  find_beer(Beer), nl,
  describe(Beer), nl.

main :-
  reset_answers,
  describe(beer_not_found).

intro :-
  jpl_call('pl.edu.agh.se.run.gui.IntroGui', intro, [], _).


find_beer(Beer) :-
  beer(Beer), !.


% Store user answers to be able to track his progress
:- dynamic(progress/2).


% Clear stored user progress
% reset_answers must always return true; because retract can return either true
% or false, we fail the first and succeed with the second.
reset_answers :-
  retract(progress(_, _)),
  fail.
reset_answers.


% Rules for the knowledge base
beer(porter) :-
  color(dark),
  drinks(beers_by_big_breweries),
  bitter(medium),
  eats(something_fat),
  weather(foggy),
  when(evening),
  how_much_time(little_time).

beer(ipa) :-
  color(light),
  drinks(craft_beers),
  bitter(medium),
  eats(duck),
  weather(sunny),
  likes(fruits),
  when(afternoon).

beer(ipa) :-
  color(light),
  drinks(craft_beers),
  bitter(medium),
  eats(nothing),
  weather(sunny),
  likes(fruits),
  when(afternoon).

beer(double_ipa) :-
  color(amber),
  drinks(craft_beers),
  bitter(high),
  weather(foggy),
  when(evening),
  how_much_time(a_lot_of_time).

beer(lager) :-
  color(light),
  drinks(beers_by_big_breweries),
  bitter(light),
  eats(chips),
  weather(sunny),
  when(afternoon).

beer(sour_ale) :-
  color(light),
  jelly_beans(sour),
  drinks(craft_beers),
  bitter(light),
  eats(nothing),
  weather(sunny),
  when(all_day),
  how_much_time(little_time),
  likes(whatever).

beer(barley_wine) :-
  color(amber),
  jelly_beans(sweet),
  drinks(craft_beers),
  bitter(medium),
  eats(pie),
  weather(cold),
  when(evening),
  how_much_time(a_lot_of_time),
  likes(whatever).

color(dark) :-
  likes(coffee),
  classic(no).

color(light) :-
  classic(yes).

color(amber) :-
  classic(yes),
  likes(malt).

color(amber) :-
  classic(yes),
  jelly_beans(sweet).

bitter(light) :-
  perfect_coffee(latte).

bitter(medium) :-
  perfect_coffee(black).

bitter(high) :-
  perfect_coffee(espresso).

% Questions for the knowledge base
question(likes) :-
  write('What do you like?'), nl.

question(drinks) :-
  write('Which beers do you drink?'), nl.

question(eats) :-
  write('What are you going to eat with beer?'), nl.

question(weather) :-
  write('What is the weather like?'), nl.

question(when) :-
  write('When are you going to drink beer?'), nl.

question(how_much_time) :-
  write('How much time do you have?'), nl.

question(classic) :-
  write('Do you want it to be more classic'), nl.

question(jelly_beans) :-
  write('What kind of jelly beans you like the most?'), nl.

question(perfect_coffee) :-
  write('What coffee you like the most'), nl.

% Answers for the knowledge base
answer(yes) :-
  write('Yes').

answer(no) :-
  write('No').

answer(coffee) :-
  write('Coffee').

answer(fruits) :-
  write('Fruits').

answer(chocolate) :-
  write('Chocolate').

answer(malt) :-
  write('Malt').

answer(beers_by_big_breweries) :-
  write('Beers by big breweries').

answer(craft_beers) :-
  write('Craft beers').

answer(nothing) :-
  write('Nothing').

answer(dessert) :-
  write('Dessert').

answer(something_fat) :-
  write('Something fat').

answer(chips) :-
  write('Chips').

answer(duck) :-
  write('Duck').

answer(sunny) :-
  write('Sunny').

answer(rainy) :-
  write('Rainy').

answer(foggy) :-
  write('Foggy').

answer(morning) :-
  write('In the morning').

answer(afternoon) :-
  write('In the afternoon').

answer(evening) :-
  write('In the evening').

answer(a_lot_of_time) :-
  write('A lot of time').

answer(not_so_much_time) :-
  write('Not so much time').

answer(little_time) :-
  write('Little time').

answer(sour) :-
  write('Sour').

answer(sweet) :-
  write('Sweet').

answer(black) :-
  write('Black').

answer(espresso) :-
  write('Espresso').

answer(latte) :-
  write('Latte').

answer(poland) :-
  write('Poland').

answer(foreign) :-
  write('Foreign').

answer(all_day) :-
  write('All day').

answer(whatever) :-
  write('Whatever').

answer(pie) :-
  write('Pie').

answer(cold) :-
  write('Cold').

% Beer descriptions for the knowledge base
describe(porter) :-
  jpl_call('pl.edu.agh.se.run.gui.DescribeGui', describe, ['Porter', 'Dark beer, very strong, good beer.'], _).

describe(ipa) :-
  jpl_call('pl.edu.agh.se.run.gui.DescribeGui', describe, ['India Pale Ale', 'Bright beer, light, with fruit scent and flavour.'], _).

describe(double_ipa) :-
  jpl_call('pl.edu.agh.se.run.gui.DescribeGui', describe, ['Double India Pale Ale', 'Amber beer, heavy, with fruit scent and flawour.'], _).

describe(lager) :-
  jpl_call('pl.edu.agh.se.run.gui.DescribeGui', describe, ['Lager', 'Bright beer, very light, with no specific scent or flavour, most common.'], _).

describe(sour_ale) :-
  jpl_call('pl.edu.agh.se.run.gui.DescribeGui', describe, ['Sour Ale', 'Bright beer, very light, sour, with mostly with fruit flavours.'], _).

describe(barley_wine) :-
  jpl_call('pl.edu.agh.se.run.gui.DescribeGui', describe, ['Barley wine', 'Beer with amber colour, strong heavy sweet with scent of raisins and malt.'], _).

describe(beer_not_found) :-
  jpl_call('pl.edu.agh.se.run.gui.DescribeGui', describe, ['Cannot find beer matching your criteria', 'Please try again!'], _).

% Assigns an answer to questions from the knowledge base
likes(Answer) :-
  progress(likes, Answer).
likes(Answer) :-
  \+ progress(likes, _),
  ask(likes, Answer, [coffee, fruits, chocolate, malt, whatever]).

drinks(Answer) :-
  progress(drinks, Answer).
drinks(Answer) :-
  \+ progress(drinks, _),
  ask(drinks, Answer, [beers_by_big_breweries, craft_beers]).

eats(Answer) :-
  progress(eats, Answer).
eats(Answer) :-
  \+ progress(eats, _),
  ask(eats, Answer, [nothing, dessert, something_fat, duck, chips, pie]).

weather(Answer) :-
  progress(weather, Answer).
weather(Answer) :-
  \+ progress(weather, _),
  ask(weather, Answer, [sunny, rainy, foggy, cold]).

when(Answer) :-
  progress(when, Answer).
when(Answer) :-
  \+ progress(when, _),
  ask(when, Answer, [morning, afternoon, evening, all_day]).

how_much_time(Answer) :-
  progress(how_much_time, Answer).
how_much_time(Answer) :-
  \+ progress(how_much_time, _),
  ask(how_much_time, Answer, [a_lot_of_time, not_so_much_time, little_time]).

classic(Answer) :-
  progress(classic, Answer).
classic(Answer) :-
  \+ progress(classic, _),
  ask(classic, Answer, [yes, no]).

jelly_beans(Answer) :-
  progress(jelly_beans, Answer).
jelly_beans(Answer) :-
  \+ progress(jelly_beans, _),
  ask(jelly_beans, Answer, [sour, sweet]).

perfect_coffee(Answer) :-
  progress(perfect_coffee, Answer).
perfect_coffee(Answer) :-
  \+ progress(perfect_coffee, _),
  ask(perfect_coffee, Answer, [black, espresso, latte]).

origin(Answer) :-
  progress(origin, Answer).
origin(Answer) :-
  \+ progress(origin, _),
  ask(origin, Answer, [poland, foreign]).

% Outputs a nicely formatted list of answers
% [First|Rest] is the Choices list, Index is the index of First in Choices
answers([], _).
answers([First|Rest], Index) :-
  write(Index), write(' '), answer(First), nl,
  NextIndex is Index + 1,
  answers(Rest, NextIndex).


% Parses an Index and returns a Response representing the "Indexth" element in
% Choices (the [First|Rest] list)
parse(0, [First|_], First).
parse(Index, [First|Rest], Response) :-
  Index > 0,
  NextIndex is Index - 1,
  parse(NextIndex, Rest, Response).

% Asks the Question to the user and saves the Answer
ask(Question, Answer, Choices) :-
  jpl_list_to_array(Choices, JavaArray),
  jpl_call('pl.edu.agh.se.run.gui.QuestionGui', askQuestion, [Question, JavaArray], AnInt),
  parse(AnInt, Choices, Response),
  asserta(progress(Question, Response)),
  Response = Answer.