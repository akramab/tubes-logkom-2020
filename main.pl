:- include('jobs.pl').
:- include('monsters.pl').
:- include('player.pl').
:- include('items.pl').
:- include('battle.pl').
:- include('inventory.pl').
:- include('shop.pl').
:- include('map.pl').

:- dynamic(gameState/1).


/*GAME STATE*/
/*Terdapat 5 macam game state: 'Safe' 'Roam', 'Battle', 'Game Over', 'Finish'*/
gameState('Safe').

start :-
    write('Welcome to Bla.'),
    initClass,
    initMap,
    consoleLoop.

consoleLoop :-
    repeat,
    map,
    write(' > '),
    read(X).