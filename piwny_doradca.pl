:- use_module(library(jpl)).

% Expert system should be started from here
main :-
  intro,
  reset_answers,
  find_beer(Beer), nl,
  describe(Beer), nl.


intro :-
  write('Which beer should I drink today?'), nl,
  write('To answer, input the number shown next to each answer, followed by a dot (.)'), nl, nl.


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
  bitter(yes),
  eats(something_fat),
  weather(foggy),
  when(evening),
  how_much_time(little_time).

beer(ipa) :-
  color(light),
  drinks(craft_beers),
  bitter(yes),
  eats(duck),
  weather(sunny),
  likes(fruits),
  when(afternoon).

beer(ipa) :-
  color(light),
  drinks(craft_beers),
  bitter(yes),
  eats(nothing),
  weather(sunny),
  likes(fruits),
  when(afternoon).

color(dark) :-
  likes(coffee),
  classic(no).

color(light) :-
  classic(yes).

% Questions for the knowledge base
question(likes) :-
  write('What do you like?'), nl.

question(drinks) :-
  write('Which beers do you drink?'), nl.

question(bitter) :-
  write('Do you like bitter taste?'), nl.

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

% Beer descriptions for the knowledge base
describe(porter) :-
  write('Porter'), nl,
  write('Dark beer, very strong, good beer'), nl.

describe(ipa) :-
  write('India Pale Ale'), nl,
  write('Bright beer, light, with fruit scent and flawour'), nl.

% Assigns an answer to questions from the knowledge base
likes(Answer) :-
  progress(likes, Answer).
likes(Answer) :-
  \+ progress(likes, _),
  ask(likes, Answer, [coffee, fruits, chocolate]).

drinks(Answer) :-
  progress(drinks, Answer).
drinks(Answer) :-
  \+ progress(drinks, _),
  ask(drinks, Answer, [beers_by_big_breweries, craft_beers]).

bitter(Answer) :-
  progress(bitter, Answer).
bitter(Answer) :-
  \+ progress(bitter, _),
  ask(bitter, Answer, [yes, no]).

eats(Answer) :-
  progress(eats, Answer).
eats(Answer) :-
  \+ progress(eats, _),
  ask(eats, Answer, [nothing, dessert, something_fat, duck]).

weather(Answer) :-
  progress(weather, Answer).
weather(Answer) :-
  \+ progress(weather, _),
  ask(weather, Answer, [sunny, rainy, foggy]).

when(Answer) :-
  progress(when, Answer).
when(Answer) :-
  \+ progress(when, _),
  ask(when, Answer, [morning, afternoon, evening]).

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

% Asks the Question to the user and saves the Answer
ask(Question, Answer, Choices) :-
  question(Question),
  jpl_list_to_array(Choices, JavaArray),
  jpl_call('pl.edu.agh.se.run.gui.QuestionGui', askQuestion, ['A question', JavaArray], AnInt),
  write('An int:  '), write(AnInt),
  asserta(progress(Question, Response)),
  Response = Answer.
