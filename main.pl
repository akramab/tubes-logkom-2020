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
    initClass, /* Inisialisasi class, terdapat di player.pl */
    initMap, /* Inisialisasi map, terdapat di map.pl */
    nl,
    consoleLoop.

consoleLoop :-
    repeat,
    map,
    write('Commands:'), nl, /* Belum diimplementasikan */
    write('1. moveW'), nl,
    write('2. moveA'), nl,
    write('3. moveS'), nl,
    write('4. moveD'), nl,
    write(' > '),
    read(X),
    ( /* semua pemanggilan fungsi masuk ke sini */
    /* (<if> -> <then>) ; */
    /* (<if> -> <then>) ; */
    (X == quit) /* program selesai ketika player mengetikkan quit */
    ).