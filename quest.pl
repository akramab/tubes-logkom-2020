:- dynamic(quest/3).
:- dynamic(questKillCount/3).


monsterID('Slime',1).
monsterID('Goblin',2).
monsterID('Wolf',3).
quest(-1, -1, -1).

questGenerate(Q) :-
    random(2, 10, Slime),
    random(2, 10, Goblin),
    random(2, 10, Wolf),
    Q = quest(Slime, Goblin, Wolf).

    
showCurrentQuest :-
    quest(Slime,Goblin,Wolf),
    
    (quest(-1,-1,-1) ->
        write('You don\'t have any active quest\n'), !
    ;write('Current Quest Progress:'),nl,
    questKillCount(SKill,GKill,WKill),
    format('Slime kill count: ~w/~w\n',[SKill,Slime]),
    format('Goblin kill count: ~w/~w\n',[GKill,Goblin]),
    format('Wolf kill count: ~w/~w\n', [WKill,Wolf]),!
    ).

questDisplay(Q) :-
    quest(Slime, Goblin, Wolf) = Q,
    write('Defeat '), write(Slime), write(' slimes, '),
    write(Goblin), write(' goblins, and '),
    write(Wolf), write(' wolves.').

questReward(Gold, Exp) :-
    quest(Slime, Goblin, Wolf),
    Gold is ((Slime * 10) + (Goblin * 30) + (Wolf * 50)),
    Exp is ((Slime * 100) + (Goblin * 300) + (Wolf * 500)).


questReward3(Q, Gold, Exp) :-
    quest(Slime, Goblin, Wolf) = Q,
    Gold is ((Slime * 10) + (Goblin * 30) + (Wolf * 50)),
    Exp is ((Slime * 100) + (Goblin * 300) + (Wolf * 500)).

questOpen(True) :-
    quest(Slime, Goblin, Wolf),
    (((Slime == -1, Goblin == -1, Wolf == -1) -> (True is 1)) ; (True is 0)).

questScreen :-
    questKillCount(Slime,Goblin,Wolf),
    quest(Slime,Goblin,Wolf),
    questComplete.
questScreen :-
    questOpen(True),
    (True == 1 -> (
    retractall(quest(_, _, _)),
    write('Available Quests:'), nl,
    questGenerate(Q1), questGenerate(Q2), questGenerate(Q3),
    questReward3(Q1, G1, E1), questReward3(Q2, G2, E2), questReward3(Q3, G3, E3),
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
    ((X == 1 -> asserta(Q1),asserta(questKillCount(0,0,0)),write('You\'ve accepted the quest!\n')) ; (X == 2 -> asserta(Q2),asserta(questKillCount(0,0,0)),write('You\'ve accepted the quest!\n')) ; (X == 3 -> asserta(Q3),asserta(questKillCount(0,0,0)),write('You\'ve accepted the quest!\n')) ; (X == q -> asserta(quest(-1, -1, -1))))) ;
    write('Sorry, you must finish your current quest before accepting a new one.\n')).

questAbort :-
    retractall(quest(_, _, _)),
    retractall(questKillCount(_,_,_)),
    asserta(quest(-1, -1, -1)).

questComplete :-
    quest(Slime,Goblin,Wolf),
    questReward(Gold, Exp),

    playerGold(CurrGold),
    playerCurrentExp(CurrExp),

    NewGold is (CurrGold + Gold),
    NewExp is (CurrExp + Exp),

    retractall(playerGold(_)),
    retractall(playerCurrentExp(_)),
    asserta(playerGold(NewGold)),
    asserta(playerCurrentExp(NewExp)),

    format('You\'ve succesfully slain:\n~w Slimes\n~w Goblins\n~w Wolves\n',[Slime,Goblin,Wolf]),
    format('You\'ve completed your quest!\nYou got ~w Exp\nYou got ~w Gold\n',[Exp,Gold]),

    playerLevelUp,

    retractall(quest(_,_,_)),
    asserta(quest(-1, -1, -1)),
    retractall(questKillCount(_,_,_)).