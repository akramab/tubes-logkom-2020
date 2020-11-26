:- dynamic(currentEnemyName/1).
:- dynamic(currentEnemyRank/1).
:- dynamic(currentEnemyAttackType/1).
:- dynamic(currentEnemyAttackElement/1).
:- dynamic(currentEnemyLevel/1).
:- dynamic(currentEnemyMaxHealth/1).
:- dynamic(currentEnemyHealth/1).
:- dynamic(currentEnemyAttack/1).
:- dynamic(currentEnemyDefense/1).
:- dynamic(playerSpecialAttackCharge/1).
:- dynamic(playerRunAttempt/1).

/*PLACEHOLDER*/
/*jangan diilangin karena info elemen monster belom ada xD*/
currentEnemyAttackElement('None').

/*ENCOUNTER ENEMY*/
encounter(Enemy) :-
    retractall(gameState(_)),
    asserta(gameState('Battle')),
    asserta(playerSpecialAttackCharge(0)),
    asserta(playerRunAttempt(3)),

    asserta(currentEnemyName(Enemy)),
    monster(EnemyRank, Enemy), asserta(currentEnemyRank(EnemyRank)),
    monsterAttackType(Enemy, AttackType), asserta(currentEnemyAttackType(AttackType)),
    monsterBaseLevel(Enemy, Level), asserta(currentEnemyLevel(Level)),
    monsterBaseHealth(Enemy,MaxHealth), asserta(currentEnemyMaxHealth(MaxHealth)),
    asserta(currentEnemyHealth(MaxHealth)),
    monsterBaseAttack(Enemy, Attack), asserta(currentEnemyAttack(Attack)),
    monsterBaseDefense(Enemy, Defense), asserta(currentEnemyDefense(Defense)),
    

    (EnemyRank = 'Normal' ->
        format('You\'ve encountered a ~w!\nEngaging the enemy!',[Enemy]),!
    ;EnemyRank = 'Boss' ->
        format('You\'ve encountered a Boss Monster: ~w.\nBe careful, it\'s a lot stronger than the usual ones!\nEngaging the enemy!',[Enemy]),!
    ;EnemyRank = 'Final Boss' ->
        format('At long last, this is the fated final battle.\nPlease defeat ~w and save the world!\nEngaging the enemy!',[Enemy]),!
    ;
    !).

/*BATTLE CONDITION*/
loseCondition :- 
    retractall(gameState(_)),
    asserta(gameState('Game Over')),
    write('You\'ve died. Because of your incompetence, the world is now doomed!'),nl,
    write('You can try again by selecting New Game or Load to start from your last saved checkpoint.'),nl,
    write('Or you can also quit the game by terminating the Terminal. Your choice.').
winBattleCondition :-
    retractall(gameState(_)),
    asserta(gameState('Roam')),

    currentEnemyLevel(ELevel),
    playerCurrentExp(CurrentExp),
    ExpFromE is (ELevel*10),
    ExpNow is (CurrentExp + ExpFromE),

    retractall(playerCurrentExp(_)),
    asserta(playerCurrentExp(ExpNow)),

    format('You won the battle!\nYou got ~w Exp!\n',[ExpFromE]),

    playerLevelUp,!.


/*TURN CHANGE
endTurn(PCurrentHealth,ECurrentHealth,Turn) :-
    (PCurrentHealth < 0 ->
        loseCondition,! 
    ;ECurrentHealth < 0 ->
        winBattleCondition,! 
    ;Turn = 1 ->
        enemyTurn,!
    ;Turn = 0 ->
        ! Harusnya nanti manggil playerTurn. Tapi belum diimplementasiin
    ).*/

endTurn(Turn) :-
    playerCurrentHealth(PCurrentHealth),
    currentEnemyHealth(ECurrentHealth),

    (PCurrentHealth < 0 ->
        loseCondition,! 
    ;ECurrentHealth < 0 ->
        winBattleCondition,! 
    ;Turn = 1 ->
        enemyTurn,!
    ;Turn = 0 ->
        ! /*Harusnya nanti manggil playerTurn. Tapi belum diimplementasiin*/
    ).



/*PLAYER'S TURN*/
elementalModifier(X,X,1,1) :- !.
elementalModifier('None',_,1,1) :- !.

elementalModifier(PlayerElement, EnemyElement, PlayerModifier,EnemyModifier) :-
    (PlayerElement = 'Fire', EnemyElement = 'Water' ->
        PlayerModifier is (0.5), EnemyModifier is (2),!
    ;PlayerElement = 'Fire', EnemyElement = 'Dark' ->
        PlayerModifier is (2), EnemyModifier is (0.5),!
    ;PlayerElement = 'Fire', EnemyElement = 'Light' ->
        PlayerModifier is (1), EnemyModifier is (1), !
    ;PlayerElement = 'Water', EnemyElement = 'Light' ->
        PlayerModifier is (0.5), EnemyModifier is (2),!
    ;PlayerElement = 'Water', EnemyElement = 'Dark' ->
        PlayerModifier is (1), EnemyModifier is (1),!
    ;PlayerElement = 'Light', EnemyElement = 'Dark' ->
        PlayerModifier is (2), EnemyModifier is (2),!
    ;elementalModifier(EnemyElement, PlayerElement, EnemyModifier, PlayerModifier),!
    ).

typeModifier(X,X,1,1) :- !.
typeModifier('Magic',_,(1.5),(1.25)) :- !.

typeModifier(PlayerType,EnemyType, PlayerModifier, EnemyModifier) :-
    (PlayerType = 'Slash', EnemyType = 'Pierce' ->
        PlayerModifier is (2), EnemyModifier is (2),!
    ;PlayerType = 'Slash', EnemyType = 'Strike' ->
        PlayerModifier is (0.5), EnemyModifier is (2),!
    ;PlayerType = 'Pierce', EnemyType = 'Strike' -> 
        PlayerModifier is (2), EnemyModifier is (0.5),!
    ;typeModifier(EnemyType,PlayerType,EnemyModifier,PlayerModifier),!
    ).


totalDamage(Level,Power,Attack,Defense,Modifier,TotalDamage) :-
    random(0.8,1.0,Random),
    TotalDamage is (floor(((((((2*Level)/5)+2)*Power*(Attack/Defense))/50)+2)*Modifier*Random)).



attack :-
    gameState(CurrentState),

    (CurrentState = 'Battle' ->
        Turn is 1,
        playerSpecialAttackCharge(CurrentSPCharge),
        NewSPCharge is (CurrentSPCharge + 1),
        retractall(playerSpecialAttackCharge(_)),
        asserta(playerSpecialAttackCharge(NewSPCharge)),

        playerAttackType(PAttackType),
        playerAttackElement(PAttackElement),
        playerLevel(PLevel),
        playerAttack(PAttack),

        currentEnemyName(EName),
        currentEnemyHealth(ECurrentHealth),
        currentEnemyAttackType(EAttackType),
        currentEnemyAttackElement(EAttackElement),
        currentEnemyDefense(EDefense),  

        elementalModifier(PAttackElement,EAttackElement,PElementalMod,_),
        typeModifier(PAttackType,EAttackType, PTypeMod,_),
        
        BasicAttackPower is (10),
        TotalPMod is (PElementalMod*PTypeMod),
        totalDamage(PLevel,BasicAttackPower,PAttack,EDefense,TotalPMod,TotalPlayerDamage),
        EHealthNow is (ECurrentHealth - TotalPlayerDamage),
        retractall(currentEnemyHealth(_)),
        asserta(currentEnemyHealth(EHealthNow)),

        format('You used Attack!\nYou dealt ~w damage to ~w!\n',[TotalPlayerDamage,EName]),

        endTurn(Turn),!
    ;write('You\'re not currently in a battle. Can\'t attack.\n'),!
    ).

specialAttack :- \+ gameState('Battle'), !, write('You\'re not currently in a battle.\nSpecial Attack can only be used in battle!'), fail.
specialAttack :-
    playerSpecialAttackCharge(CurrentSPCharge),

    (CurrentSPCharge >= 3 ->
        Turn is 1,

        retractall(playerSpecialAttackCharge(_)),
        SPChargeNow is (CurrentSPCharge-3),
        asserta(playerSpecialAttackCharge(SPChargeNow)),

        playerJob(PlayerJob),
        specialAttackName(PlayerJob,SpecialAttackName),
        specialAttackDamage(Job,SpecialAttackDamage),

        playerAttackElement(PAttackElement),
        currentEnemyAttackElement(EAttackElement),
        elementalModifier(PAttackElement,EAttackElement,PElementalMod,_),

        playerAttackType(PAttackType),
        currentEnemyAttackType(EAttackType),
        typeModifier(PAttackType,EAttackType, PTypeMod,_),

        TotalPMod is (PElementalMod*PTypeMod),
        
        playerJob(PlayerJob),
        specialAttackName(PlayerJob,SpecialAttackName),
        specialAttackDamage(Job,SpecialAttackDamage),

        playerLevel(PLevel),
        playerAttack(PAttack),
        currentEnemyDefense(EDefense),

        totalDamage(PLevel,SpecialAttackDamage,PAttack,EDefense,TotalPMod,TotalPlayerDamage),

        currentEnemyHealth(ECurrentHealth),
        EHealthNow is (ECurrentHealth - TotalPlayerDamage),
        retractall(currentEnemyHealth(_)),
        asserta(currentEnemyHealth(EHealthNow)),

        currentEnemyName(EName),
        format('You used Special Attack: ~w!\n~w took ~w damage!\n',[SpecialAttackName,EName, TotalPlayerDamage]),

        endTurn(Turn),!
    ;write('You don\'t have enough Special Attack Charge!\n'),!,fail
    ).

healPlayer(Heal) :-
    playerCurrentHealth(PCurrentHealth),
    playerMaxHealth(PMaxHealth),
    retractall(playerCurrentHealth(_)),

    PHealthNow is (PCurrentHealth+Heal),

    format('You regained ~w Health',[Heal]),

    (PHealthNow >= PMaxHealth ->
        asserta(playerCurrentHealth(PMaxHealth)),!
    ;asserta(playerCurrentHealth(PHealthNow)),!
    ).


usePotion(Potion) :-
    currentInventory(Inventory),
    \+ member(Potion,Inventory),!, format('You don\'t have ~w',[Potion]), fail.
usePotion(Potion) :- 
    \+ gameState('Battle'),
    useItemFromInventory(Potion),
    potion(Potion, Heal),
    healPlayer(Heal),
    !.

usePotion(Potion) :-
    Turn is 1,
    useItemFromInventory(Potion),
    potion(Potion, Heal),
    healPlayer(Heal),

    playerSpecialAttackCharge(CurrentSPCharge),
    retractall(playerSpecialAttackCharge(_)),
    SPChargeNow is (CurrentSPCharge+1),
    asserta(playerSpecialAttackCharge(SPChargeNow)),
    
    endTurn(Turn),
    !.

run :-
    \+ gameState('Battle'), !, write('You\'re not in a battle. You can\'t do that!'), fail.
run :-
    \+ currentEnemyRank('Normal'), !, write('This is a very important fight. Running is not an option!'), fail.
run :-
    playerRunAttempt(RunAttempt),
    random(1,11,Run),

    (RunAttempt = 0 ->
        write('You can\'t run anymore!\n It\'s kill or be killed... good luck!\n'), !, fail
    ;Run =< 5 ->
        write('You failed to run!'),
        retractall(playerRunAttempt(_)),
        RunAttemptNow is (RunAttempt - 1),
        asserta(playerRunAttempt(RunAttemptNow)), !
    ;retractall(gameState(_)),
    asserta(gameState('Roam')),
    write('You got away safely. Resuming adventure\n'),!
    ). /*Masih belum ditambahin buat ngedelete current enemy (Mungkin g didelete juga gpp) */


/*ENEMY'S TURN*/
enemyTurn :-
    Turn is 0,
    
    playerCurrentHealth(PCurrentHealth),
    playerAttackType(PAttackType),
    playerAttackElement(PAttackElement),
    playerDefense(PDefense),

    currentEnemyName(EName),
    currentEnemyAttackType(EAttackType),
    currentEnemyAttackElement(EAttackElement),
    currentEnemyLevel(ELevel),
    currentEnemyAttack(EAttack),

    elementalModifier(PAttackElement,EAttackElement,_,EElementalMod),
    typeModifier(PAttackType,EAttackType,_, ETypeMod),

    EAttackPower is (EAttack*2),
    TotalEMod is (EElementalMod*ETypeMod),
    totalDamage(ELevel,EAttackPower,EAttack,PDefense,TotalEMod,TotalEnemyDamage),
    PHealthNow is (PCurrentHealth - TotalEnemyDamage),
    retractall(playerCurrentHealth(_)),
    asserta(playerCurrentHealth(PHealthNow)),

    format('~w attacks!It dealt ~w damage!\n',[EName,TotalEnemyDamage]),

    endTurn(Turn),
    !.


/*Check Current Enemy Status*/
enemyStatus :- \+ gameState('Battle'), !, write('You\'re not currently in a battle. There\'s no enemy to check!'), fail.
enemyStatus :- 
    currentEnemyName(Name),
    currentEnemyRank(Rank),
    currentEnemyAttackType(AttackType),
    currentEnemyAttackElement(AttackElement),
    currentEnemyLevel(Level),
    currentEnemyMaxHealth(MaxHealth),
    currentEnemyHealth(CurrentHealth),
    currentEnemyAttack(Attack),
    currentEnemyDefense(Defense),

    format('Name: ~w\n', [Name]),
    format('Rank: ~w\n', [Rank]),
    format('Attack Type: ~w\n', [AttackType]),
    format('Element: ~w\n', [AttackElement]),
    format('Level: ~w\n',[Level]),
    format('Health: ~w/~w\n',[CurrentHealth, MaxHealth]),
    format('Attack: ~w\n',[Attack]),
    format('Defense: ~w\n',[Defense]),
    !.

