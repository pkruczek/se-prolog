% Expert system should be started from here
main :-
  intro,
  reset_answers,
  find_beer(Beer),
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
  color(dark).

beer(ipa) :- 
  color(light).

color(dark) :-
  likes(coffee)
  classic(no_answer).

color(light) :- 
  classic(yes_answer).

scent(tropical) :-
  likes(friuts).
 
% Questions for the knowledge base
question(likes) :-
  write('What do you like?'), nl.

question(classic) :-
  write('Do you want your beer to be more classic?'), nl.

% Answers for the knowledge base
answer(coffee) :-
  write('Coffee').

answer(friuts) :- 
  write('Tropical Fruits').

answer(yes_answer) :-
  write('Yes').

answer(no_answer) :-
  write('No').

% Beer descriptions for the knowledge base
describe(porter) :-
  write('Porter'), nl,
  write('Dark beer, very strong, good beer'), nl.


% Assigns an answer to questions from the knowledge base
likes(Answer) :-
  progress(likes, Answer).
likes(Answer) :-
  \+ progress(likes, _),
  ask(likes, Answer, [coffee, friuts]).

classic(Answer) :-
  progress(classic, Answer).
classic(Answer) :-
  \+ progress(classic, _),
  ask(classic, Answer, [yes_answer, no_answer]).

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
  read(Index),
  parse(Index, Choices, Response),
  asserta(progress(Question, Response)),
  Response = Answer.
