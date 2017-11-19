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

color(dark) :-
  likes(coffee).

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
  ask(eats, Answer, [nothing, dessert, something_fat]).

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
  question(Question),
  answers(Choices, 0),
  read(Index), nl,
  parse(Index, Choices, Response),
  asserta(progress(Question, Response)),
  Response = Answer.
