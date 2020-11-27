:- include('jobs.pl').
:- include('monsters.pl').
:- include('player.pl').
:- include('items.pl').
:- include('battle.pl').
:- include('inventory.pl').
:- include('shop.pl').
:- include('map.pl').
:- include('quest.pl').

:- dynamic(gameState/1).


/*GAME STATE*/
/*Terdapat 5 macam game state: 'Safe' 'Roam', 'Battle', 'Game Over', 'Finish'*/
gameState('Safe').

start :-
    write('Welcome to <INSERT GAME NAME HERE>.'), nl,
    initClass, /* Inisialisasi class, terdapat di player.pl */
    initMap, /* Inisialisasi map, terdapat di map.pl */
    nl,
    map,
    consoleLoop.

consoleLoop :-
    repeat,
    write('Commands:'), nl, /* Placeholder, silakan diganti, belum diimplementasikan */
    write('Format: <command>.'), nl,
    write('w -- move up'), nl,
    write('a -- move left'), nl,
    write('s -- move down'), nl,
    write('d -- move right'), nl,
    write('map -- show map (will automatically be shown if the player moves)'), nl,
    write('status -- show player status'), nl,
    write('quest -- show active quest'), nl,
    write('quit -- quit the game'), nl,
    write(' > '),
    read(X),
    ( /* semua pemanggilan fungsi masuk ke sini */
    /* format if-then-else di Prolog: */
    /* (<if-1> -> <then-1>, fail) ; */
    /* (<else if-2> -> <then-2>, fail) ; */
    /* (<else if-3> -> <then-3>, fail) ; */
    /* Contoh: */
    (X == w -> nl, moveW, fail) ; /* diberi fail agar program balik ke repeat */
    (X == a -> nl, moveA, fail) ;
    (X == s -> nl, moveS, fail) ;
    (X == d -> nl, moveD, fail) ;
    (X == map -> nl, map, fail) ;
    (X == status -> nl, status, fail) ;
    (X == quest -> nl, questLog, fail) ;
    (X == quit) /* program selesai ketika player mengetikkan quit */
    ).