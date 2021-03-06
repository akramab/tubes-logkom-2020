:- dynamic(height/1).
:- dynamic(width/1).
:- dynamic(store1/2).
:- dynamic(store2/2).
:- dynamic(fence/2).
:- dynamic(posPlayer/2).
:- dynamic(dragon/2).
:- dynamic(wall/2).
:- dynamic(questBoard/2).


/*ZONE*/
/*Zone merupakan sub bagian pada map yang membagi dengan garis horizonal menjadi 3 bagian.
terdapat 3 buah zone dan tiap zone memiliki 
kemungkinan untuk bertemu monster yang berbeda-beda

Zone 1: 60% slime, 35% goblin, 5% wolf
Zone 2: 60% goblin, 25% slime,  15% wolf
Zone 3: 60% wolf, 20% goblin, 20% slime 

fact zoneX menyimpan informasi:
zoneX(Ymin,Ymax)
di mana Ymin dan Ymax adalah partisi terhadap height dari map.*/

zone1(1,4).
zone2(5,8).
zone3(9,12).

initMap :- 
    retractall(height(_)),
    retractall(width(_)),
    retractall(posPlayer(_,_)),
    /*retractall(store1(_,_)),
    retractall(store2(_,_)),
    retractall(fence(_,_)),
    retractall(dragon(_,_)),
    retractall(wall1(_,_)),
    retractall(wall2(_,_)),
    retractall(wall3(_,_)),
    retractall(wall4(_,_)),
    retractall(wall5(_,_)),
    retractall(wall6(_,_)),
    retractall(wall7(_,_)),
    retractall(wall8(_,_)),
    retractall(wall9(_,_)),
    retractall(questBoard(_,_)),*/
    asserta(height(12)),
    asserta(width(24)),
    random(11, 12, YPlayer),
    random(11, 24, XPlayer),
    asserta(posPlayer(XPlayer, YPlayer)).



isEdgeW(_, Y) :- 
    Y is 0, !.
isEdgeA(X, _) :- 
    X is 0, !.
isEdgeS(_, Y) :- 
  height(YMax),
  YEdge is YMax + 1,
  Y is YEdge, !.
isEdgeD(X, _) :- 
  width(XMax),
  XEdge is XMax + 1,
  X is XEdge, !.
isEdge(X, Y) :- 
    isEdgeW(X, Y); 
    isEdgeA(X, Y); 
    isEdgeS(X, Y); 
    isEdgeD(X, Y); 
    wall(X,Y).
store1(10,10).
store2(6,7).
dragon(7,4).
wall(6,4).
wall(6,5).
wall(7,5).
wall(8,5).
wall(1,9).
wall(2,9).
wall(3,9).
wall(4,9).
wall(6,3).
questBoard(9,8).

printPos(X, Y) :- dragon(X, Y), write('D'),!.
printPos(X, Y) :- dragon(X, Y), posPlayer(X,Y), write('D'),!.
printPos(X, Y) :- store1(X, Y), posPlayer(X,Y), write('P'),!.
printPos(X, Y) :- store1(X, Y), write('S'),!.
printPos(X, Y) :- store2(X, Y), posPlayer(X,Y), write('P'),!.
printPos(X, Y) :- store2(X, Y), write('S'),!.
printPos(X, Y) :- wall(X,Y), write('#'),!.
printPos(X, Y) :- questBoard(X,Y), write('Q'),!.
printPos(X, Y) :- posPlayer(X, Y), !, write('P').
printPos(X, Y) :- isEdge(X, Y), !, write('#').
printPos(_, _) :- write('-'), !.

map :-
  width(W),
  height(H),
  XMin is 0,
  XMax is W + 1,
  YMin is 0,
  YMax is H + 1,
  forall(between(YMin, YMax, J), (
    forall(between(XMin, XMax, I),(
      printPos(I, J)
    )),
    nl
  )),
  !
  .
/* Sumber Referensi : https://github.com/littlemight/TubesLogkom-Tokemon */

/* MOVE */
moveW :-
    posPlayer(CurrX,CurrY),
    NewCurrY is (CurrY - 1),
    (isEdge(CurrX,NewCurrY),
        !,write('There\'s a wall, you can\'t move there!\n'),fail
    ;retractall(posPlayer(_,_)),
    asserta(posPlayer(CurrX,NewCurrY)),
    map,
    write('You move north\n'),!
    ).

moveA :-
    posPlayer(CurrX,CurrY),
    NewCurrX is (CurrX - 1),
    (isEdge(NewCurrX,CurrY),
        !,write('There\'s a wall, you can\'t move there!\n'),fail
    ;retractall(posPlayer(_,_)),
    asserta(posPlayer(NewCurrX,CurrY)),
    map,write('You move west\n'),!
    ).
moveS :-
    posPlayer(CurrX,CurrY),
    NewCurrY is (CurrY + 1),
    (isEdge(CurrX,NewCurrY),
        !,write('There\'s a wall, you can\'t move there!\n'),fail
    ;retractall(posPlayer(_,_)),
    asserta(posPlayer(CurrX,NewCurrY)),
    map,
    write('You move south\n'),!
    ).
moveD :-
    posPlayer(CurrX,CurrY),
    NewCurrX is (CurrX + 1),
    (isEdge(NewCurrX,CurrY),
        !,write('There\'s a wall, you can\'t move there!\n'),fail
    ;retractall(posPlayer(_,_)),
    asserta(posPlayer(NewCurrX,CurrY)),
    map,
    write('You move east\n'),!
    ).