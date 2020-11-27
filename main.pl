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

deleteItem :-
    write('You are currently on delete screen'),nl,
    write('Input the name of the item in between of single quotes (ex. \'Hero Sword\') that you want to delete'),nl,
    write('to exit this screen, simply type exitDelItem'),nl,
    write('(You must have said item in your inventory to delete it)'),nl,
    repeat,
        write(' > '),
        read(ItemName),

        (useItemFromInventory(ItemName) ->
            format('You\'ve succesfully deleted ~w from your inventory\n',[ItemName]),fail
        ;ItemName == exitDelItem -> !
        ;write('\nInvalid Command\n'), fail
        ).

equip :-
    write('You are currently on equip screen'),nl,
    write('Input the name of the equipment in between of single quotes (ex. \'Hero Sword\') that you want to equip'),nl,
    write('to exit this screen, simply type exitEquip'),nl,
    write('(You must have said equipment in your inventory to equip it)'),nl,
    repeat,
        write(' > '),
        read(EqName),

        (equipment(_,Type,EqName,Rarity,_), equipmentStats(Type,Rarity,Attack,Defense) ->
            equipEquipment(Type, EqName,Attack, Defense),!
        ;EqName == exitEquip -> !
        ;format('~w is not a known item name!\n',[EqName]), fail
        ).

unequip :-
    write('You are currently on unequip screen'),nl,
    write('Avaible Commmands (type this command in between of single quotes; ex. \'Helmet\'):'),nl,
    write('Helmet -- unequip your helmet'),nl,
    write('Chestplate -- unequip your chestplate'),nl,
    write('Leggings -- unequip your leggings'),nl,
    write('Boots -- unequip your boots\n'),nl,
    write('to exit this screen, simply type exitUnequip'),nl,
    repeat,
        write(' > '),
        read(EqType),

        ((EqType = 'Helmet';EqType = 'Chestplate';EqType= 'Leggings'; EqType = 'Boots') ->
            unequipEquipment(EqType)
        ;EqType = exitUnequip -> !
        ;write('Unknown command!\n'), fail).
takeQuest :-
    posPlayer(CurrX,CurrY),
    \+ questBoard(CurrX,CurrY),!,
    write('You\'re not currently in a spot to take a quest!\n').

takeQuest :-
    questScreen, !.

shop :-
    posPlayer(CurrX,CurrY),
    \+ store1(CurrX,CurrY),
    \+ store2(CurrX,CurrY),!,
    write('You\'re not currently in a shop!\n').

shop :- 
    write('What do you want to buy?'),nl,
    write('1. Gacha (100 gold)'),nl,
    write('2. Health Potion (10 gold)'),nl,
    repeat,
        write(' > '),
        read(X),
        (
        (X == gacha -> !,buy('Gacha'));
        (X == potion -> !,buy('Health Potion'));
        (X == exitShop -> write('Thanks for coming\n')),!;
        (write('There\'s no such item!\n'),fail)
        ).
accessQuest :- !.

specialPlace :-
    posPlayer(CurrX,CurrY),
    questBoard(QX,QY),
    (CurrX = QX, CurrY = QY ->
        accessQuest, !, fail
    ;!).


encounterZone :-
    posPlayer(CurrX,CurrY),
    zone1(_,Y1),
    zone2(_,Y2),
    zone3(_,Y3),

    (dragon(CurrX,CurrY) ->
        encounter('Alduin'), battleEnemy, !
    ;CurrY =< Y1 ->
        encounterRate(60,95,100), !
    ;CurrY =< Y2 ->
        encounterRate(25,85,100), !
    ;CurrY =< Y3 ->
        encounterRate(20,40,100),!
    ).
encounterRate(Slime,Goblin,Wolf) :-
    random(1,11,EncounterEnemy),
    
    (EncounterEnemy >= 8 -> /*encounter rate defaultnya 30%*/
        encounterEnemy(Slime,Goblin,Wolf),!
    ;!).
encounterEnemy(Slime,Goblin,Wolf):-
    random(1,101,Enemy),

    (Enemy =< Slime ->
        encounter('Slime'), battleEnemy,!
    ;Enemy =< Goblin ->
        encounter('Goblin'), battleEnemy,!
    ;Enemy =< Wolf ->
        encounter('Wolf'), battleEnemy,!
    ).


/*GAME STATE*/
/*Terdapat 5 macam game state: 'Safe' 'Roam', 'Battle', 'Game Over', 'Finish'*/
gameState('Safe').

start :-
    write(' ########: ##:::: ##: ########:: ########:: ######::::: ####: ##:::: ##: ########::::: ###::::: ######:: ########:'),nl,
    write('... ##..:: ##:::: ##: ##.... ##: ##.....:: ##... ##::::. ##:: ###:: ###: ##.... ##::: ## ##::: ##... ##:... ##..::'),nl,
    write('::: ##:::: ##:::: ##: ##:::: ##: ##::::::: ##:::..:::::: ##:: #### ####: ##:::: ##:: ##:. ##:: ##:::..::::: ##::::'),nl,
    write('::: ##:::: ##:::: ##: ########:: ######:::. ######:::::: ##:: ## ### ##: ########:: ##:::. ##: ##:::::::::: ##::::'),nl,
    write('::: ##:::: ##:::: ##: ##.... ##: ##...:::::..... ##::::: ##:: ##. #: ##: ##.....::: #########: ##:::::::::: ##::::'),nl,
    write('::: ##:::: ##:::: ##: ##:::: ##: ##::::::: ##::: ##::::: ##:: ##:.:: ##: ##:::::::: ##.... ##: ##::: ##:::: ##::::'),nl,
    write('::: ##::::. #######:: ########:: ########:. ######::::: ####: ##:::: ##: ##:::::::: ##:::: ##:. ######::::: ##::::'),nl,
    write(':::..::::::.......:::........:::........:::......::::::....::..:::::..::..:::::::::..:::::..:::......::::::..:::::'),nl,
    write(':::                                                                                                            :::'),nl,
    write(':::                                                      Welcome to TUBES IMPACT                               :::'),nl,
    write(':::............................................................................................................:::'),nl,
    initClass, /* Inisialisasi class, terdapat di player.pl */
    initMap, /* Inisialisasi map, terdapat di map.pl */
    nl,
    consoleLoop.

help :-
    write('Commands:'), nl, /* Placeholder, silakan diganti, belum diimplementasikan */
    write('Format: <command>.'), nl,
    write('w -- move up'), nl,
    write('a -- move left'), nl,
    write('s -- move down'), nl,
    write('d -- move right'), nl,
    write('status -- show player status'), nl,
    write('inventory -- show list of items in your inventory'),nl,
    write('delItem -- delete an item in you inventory'),nl,
    write('showEquipment -- show your current equipment'),nl,
    write('equip -- equip a new equipment'),nl,
    write('unequip -- unequip a piece of your equipment'),nl,
    write('showQuest -- show current queest (if any)'),nl,
    write('takeQuest -- take a quest (only available on Q spot)'),nl,
    write('shop -- access the shop. Could only be used when you\'re on the shop'),nl,
    write('map -- show the map and your current position'), nl,
    write('potion -- use potion to regain your health'), nl,
    write('help -- show all of the currently available commands'), nl,
    write('quit -- quit the game'), nl.    

consoleLoop :-
    map,
    help,
    repeat,
    /*map, sementara dikomentarin dulu*/
    write(' > '),
    read(X),
    ( /* semua pemanggilan fungsi masuk ke sini */
    /* format if-then-else di Prolog: */
    /* (<if-1> -> <then-1>, fail) ; */
    /* (<else if-2> -> <then-2>, fail) ; */
    /* (<else if-3> -> <then-3>, fail) ; */
    /* Contoh: */
    (X == w -> nl, moveW,specialPlace, encounterZone, gameState('Game Over')) ; /* gameState Game Over akan membuat program berhenti ketika pemain mencapai state game over (HP <= 0) */
    (X == a -> nl, moveA,specialPlace, encounterZone, gameState('Game Over')) ;
    (X == s -> nl, moveS,specialPlace, encounterZone, gameState('Game Over')) ;
    (X == d -> nl, moveD,specialPlace, encounterZone, gameState('Game Over')) ;
    (X == status -> nl, status, fail);
    (X == inventory -> nl, showInventory, fail);
    (X == delItem -> nl, deleteItem, fail);
    (X == showEquipment -> nl, showEq, fail);
    (X == equip -> nl, equip, fail);
    (X == unequip -> nl, unequip, fail);
    (X == showQuest -> nl, showCurrentQuest, fail);
    (X == takeQuest -> nl, takeQuest, fail);
    (X == shop -> nl, shop, fail);
    (X == map -> nl, map, fail );
    (X == potion -> nl, usePotion('Health Potion'), fail);
    (X == help -> nl, help, fail);
    (X == quit); /* program selesai ketika player mengetikkan quit */
    (write('Invalid command!\n Type help if you want to know all the available commands\n'), fail)
    ).
