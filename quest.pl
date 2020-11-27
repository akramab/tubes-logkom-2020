:- dynamic(quest/3).
:- dynamic(questCnt/3).

quest(-1, -1, -1).

questGenerate(Q) :-
    random(2, 10, Slime),
    random(2, 10, Goblin),
    random(2, 10, Wolf),
    Q = quest(Slime, Goblin, Wolf).

questText(Q) :-
    quest(Slime, Goblin, Wolf) = Q,
    write('Defeat '), write(Slime), write(' slimes, '),
    write(Goblin), write(' goblins, and '),
    write(Wolf), write(' wolves.').

questReward(Q, Gold, Exp) :-
    quest(Slime, Goblin, Wolf) = Q,
    Gold is ((Slime * 10) + (Goblin * 30) + (Wolf * 50)),
    Exp is ((Slime * 100) + (Goblin * 300) + (Wolf * 500)).

questActive(True) :-
   quest(Slime, Goblin, Wolf),
   (((Slime == -1, Goblin == -1, Wolf == -1) -> (True is 0)) ; (True is 1)).

questBoard :-
    questActive(True),
    (True == 0 -> (
    retractall(quest(_, _, _)),
    write('Available Quests:'), nl,
    questGenerate(Q1), questGenerate(Q2), questGenerate(Q3),
    questReward(Q1, G1, E1), questReward(Q2, G2, E2), questReward(Q3, G3, E3),
    write('1. '), questText(Q1), nl,
    write('   Reward: '), write(G1), write(' gold, '), write(E1), write(' exp.'), nl,
    write('2. '), questText(Q2), nl,
    write('   Reward: '), write(G2), write(' gold, '), write(E2), write(' exp.'), nl,
    write('3. '), questText(Q3), nl,
    write('   Reward: '), write(G3), write(' gold, '), write(E3), write(' exp.'), nl,
    write('Pick a quest by typing its number, q to exit.'), nl,
    write('TIP: You can refresh the available quests by exiting and entering this vendor.'),
    write('(Format: <number>. or q.)'), nl,
    repeat,
    write(' Pick a quest: '), read(X),
    ((X == 1 -> (asserta(Q1), asserta(questCnt(0, 0, 0)))) ; (X == 2 -> (asserta(Q2), asserta(questCnt(0, 0, 0)))) ; (X == 3 -> (asserta(Q3), asserta(questCnt(0, 0, 0)))) ; (X == q -> asserta(quest(-1, -1, -1))))) ;
    write('Sorry, you must finish your current quest before accepting a new one.')).

questAbort :-
    retractall(quest(_, _, _)),
    retractall(questCnt(_, _, _)),
    asserta(quest(-1, -1, -1)).

questComplete :-
    Q = quest(_, _, _),
    questReward(Q, Gold, Exp),
    /* TAMBAH GOLD DAN EXP BELUM DIIMPLEMENTASIKAN */
    retractall(Q),
    retractall(questCnt(_, _, _)),
    asserta(quest(-1, -1, -1)).

questProgressCheck(True) :-
    ((True == 1 ->
    (quest(S1, G1, W1),
    questCnt(S0, G0, W0),
    delS is S1 - S0,
    delG is G1 - G0,
    delW is W1 - W0,
    (((delS == 0, delG == 0, delW == 0) -> questComplete) ; true))) ;
    true).

questLog :-
    questActive(True),
    ((True == 1 ->
    (write('Active Quest:'), nl,
    quest(S1, G1, W1),
    questCnt(S0, G0, W0),
    write('Defeat '), write(S0), write('/'), write(S1), write(' slimes, '),
    write(G0), write('/'), write(G1), write(' goblins, and '),
    write(W0), write('/'), write(W1), write(' wolves.'), nl)) ;
    (write('You don\'t have any active quests'), nl)).

quest_killSlime :-
    questActive(True),
    ((True == 1 ->
    (Q = questCnt(S0, G0, W0),
    S1 is S0 + 1,
    retractall(Q),
    asserta(questCnt(S1, G0, W0)),
    questProgressCheck(True))) ;
    true).

quest_killGoblin :-
    questActive(True),
    ((True == 1 ->
    (Q = questCnt(S0, G0, W0),
    G1 is G0 + 1,
    retractall(Q),
    asserta(questCnt(S0, G1, W0)),
    questProgressCheck(True))) ;
    true).

quest_killWolf :-
    questActive(True),
    ((True == 1 ->
    (Q = questCnt(S0, G0, W0),
    W1 is W0 + 1,
    retractall(Q),
    asserta(questCnt(S0, G0, W1)),
    questProgressCheck(True))) ;
    true).