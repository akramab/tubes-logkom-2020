:- dynamic(height/1).
:- dynamic(width/1).
:- dynamic(store1/2).
:- dynamic(store2/2).
:- dynamic(fence/2).
:- dynamic(posPlayer/2).
:- dynamic(dragon/2).
:- dynamic(wall1/2).
:- dynamic(wall2/2).
:- dynamic(wall3/2).
:- dynamic(wall4/2).
:- dynamic(wall5/2).
:- dynamic(wall6/2).
:- dynamic(wall7/2).
:- dynamic(wall8/2).
:- dynamic(wall9/2).
:- dynamic(quest/2).

initMap :- 
  random(10, 25, H),
  random(10, 25, W),
  asserta(height(H)),
  asserta(width(W)).

isEdgeW(_, Y) :- Y =:= 0, !.
isEdgeA(X, _) :- X =:= 0, !.
isEdgeS(_, Y) :- 
  height(YMax),
  YEdge is YMax + 1,
  Y =:= YEdge, !.
isEdgeD(X, _) :- 
  width(XMax),
  XEdge is XMax + 1,
  X =:= XEdge, !.
isEdge(X, Y) :- isEdgeW(X, Y); isEdgeA(X, Y); isEdgeS(X, Y); isEdgeD(X, Y).
store1(X,Y) :- X=10, Y=10.
store2(X,Y) :- X=6, Y=7.
dragon(X,Y) :- X=7, Y=4.
wall1(X,Y) :- X=6, Y=4.
wall2(X,Y) :- X=6, Y=5.
wall3(X,Y) :- X=7, Y=5.
wall4(X,Y) :- X=8, Y=5.
wall5(X,Y) :- X=1, Y=9.
wall6(X,Y) :- X=2, Y=9.
wall7(X,Y) :- X=3, Y=9.
wall8(X,Y) :- X=4, Y=9.
wall9(X,Y) :- X=6, Y=3.
quest(X,Y) :- X=9, Y=8.

printPos(X, Y) :- dragon(X, Y), write('D').
printPos(X, Y) :- store1(X, Y), write('S').
printPos(X, Y) :- store2(X, Y), write('S').
printPos(X, Y) :- wall1(X,Y), write('#').
printPos(X, Y) :- wall2(X,Y), write('#').
printPos(X, Y) :- wall3(X,Y), write('#').
printPos(X, Y) :- wall4(X,Y), write('#').
printPos(X, Y) :- wall5(X,Y), write('#').
printPos(X, Y) :- wall6(X,Y), write('#').
printPos(X, Y) :- wall7(X,Y), write('#').
printPos(X, Y) :- wall8(X,Y), write('#').
printPos(X, Y) :- wall9(X,Y), write('#').
printPos(X, Y) :- quest(X,Y), write('Q').
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