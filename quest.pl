:- dynamic(quest/3).

quest(-1, -1, -1).

questGenerate(Q) :-
    random(2, 10, Slime),
    random(2, 10, Goblin),
    random(2, 10, Wolf),
    Q = quest(Slime, Goblin, Wolf).

questDisplay(Q) :-
    quest(Slime, Goblin, Wolf) = Q,
    write('Defeat '), write(Slime), write(' slimes, '),
    write(Goblin), write(' goblins, and '),
    write(Wolf), write(' wolves.').

questReward(Q, Gold, Exp) :-
    quest(Slime, Goblin, Wolf) = Q,
    Gold is ((Slime * 10) + (Goblin * 30) + (Wolf * 50)),
    Exp is ((Slime * 100) + (Goblin * 300) + (Wolf * 500)).

questOpen(True) :-
   quest(Slime, Goblin, Wolf),
   (((Slime == -1, Goblin == -1, Wolf == -1) -> (True is 1)) ; (True is 0)).

questScreen :-
    questOpen(True),
    (True == 1 -> (
    retractall(quest(_, _, _)),
    write('Available Quests:'), nl,
    questGenerate(Q1), questGenerate(Q2), questGenerate(Q3),
    questReward(Q1, G1, E1), questReward(Q2, G2, E2), questReward(Q3, G3, E3),
    write('1. '), questDisplay(Q1), nl,
    write('   Reward: '), write(G1), write(' gold, '), write(E1), write(' exp.'), nl,
    write('2. '), questDisplay(Q2), nl,
    write('   Reward: '), write(G2), write(' gold, '), write(E2), write(' exp.'), nl,
    write('3. '), questDisplay(Q3), nl,
    write('   Reward: '), write(G3), write(' gold, '), write(E3), write(' exp.'), nl,
    write('Pick a quest by typing its number, q to exit.'), nl,
    write('(Format: <number>. or q.)'), nl,
    repeat,
    write(' > '), read(X),
    ((X == 1 -> asserta(Q1)) ; (X == 2 -> asserta(Q2)) ; (X == 3 -> asserta(Q3)) ; (X == q -> asserta(quest(-1, -1, -1))))) ;
    write('Sorry, you must finish your current quest before accepting a new one.')).

questAbort :-
    retractall(quest(_, _, _)),
    asserta(quest(-1, -1, -1)).

questComplete :-
    Q = quest(Slime, Goblin, Wolf),
    questReward(Q, Gold, Exp),
    /* TAMBAH GOLD DAN EXP BELUM DIIMPLEMENTASIKAN */
    retractall(Q),
    asserta(quest(-1, -1, -1)).