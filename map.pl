:- dynamic(height/1).
:- dynamic(width/1).
:- dynamic(store1/2).
:- dynamic(store2/2).
:- dynamic(fence/2).
:- dynamic(posPlayer/2).
/* Kode program masih akan diubah dan dikembangkan. Ini masih tahap mencoba. Sumber : https://github.com/littlemight/TubesLogkom-Tokemon */

initMap :- 
  random(10, 21, H),
  random(10, 21, W),
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
store2(X,Y) :- X=6, Y=4.

printPos(X, Y) :- store1(X, Y), write('S').
printPos(X, Y) :- store2(X, Y), write('S').
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