:- dynamic(player/7).
:- dynamic(currentEnemy/5).
:- dynamic(gameState/1).
:- dynamic(specialAttCharge/1).
:- dynamic(playerCurrHP/1).
:- dynamic(potion/2).
:- dynamic(playerCurrExp/1).
:- dynamic(playerGold/1).
/* Player */

player(reincarnatedPerson, noAttribute, noSkill, 1, 1, 1, 1).
playerCurrHP(1).
playerCurrExp(0).
playerGold(1000).

initPlayer(Job) :-
    playerCurrHP(TempHP),
    player(CurrentJob, CurrentAttribute, CurrentSkill, CurrentLevel, CurrentAttack, CurrentDefense, CurrentHP),
    attributeAttack(Job, BaseAttribute),
    skill(Job, Skill, _),
    statusLevel(Job,BaseLvl),
    statusAttack(Job, BaseAtt),
    statusDefense(Job, BaseDef),
    statusHP(Job, BaseHP),
    retract(player(CurrentJob,CurrentAttribute,CurrentSkill,CurrentLevel,CurrentAttack,CurrentDefense,CurrentHP)),
    asserta(player(Job, BaseAttribute, Skill, BaseLvl, BaseAtt, BaseDef,BaseHP)),
    retract(playerCurrHP(TempHP)),
    asserta(playerCurrHP(BaseHP)).

status :-
    playerCurrHP(CurrentHP),
    playerCurrExp(CurrEXP),
    playerGold(CurrGold),
    player(CurrentJob, CurrentAttribute, CurrentSkill, CurrentLevel, CurrentAttack, CurrentDefense, MaxHP),
    ExpTilLvlUp is (CurrentLevel*10),
    write('Job: '), write(CurrentJob), nl,
    write('Attribute Attack: '), write(CurrentAttribute), nl,
    write('Special Skill: '), write(CurrentSkill), nl,
    write('Level: '), write(CurrentLevel), nl,
    write('Health: '), write(CurrentHP), write('/'), write(MaxHP), nl,
    write('Attack: '), write(CurrentAttack), nl,
    write('Defense: '), write(CurrentDefense), nl,
    write('Exp: '), write(CurrEXP), write('/'), write(ExpTilLvlUp), nl,
    write('Gold: '), write(CurrGold), nl.

playerLvlUp :-
    playerCurrExp(CurrEXP),
    getPlayerLvl(PCurrLvl),

    (CurrEXP >= (PCurrLvl*10)) ->
        player(CurrentJob, CurrentAttribute, CurrentSkill, CurrentLevel, CurrentAttack, CurrentDefense, MaxHP),
        NewAtt is (CurrentAttack+1),
        NewLvl is (CurrentLevel+1),
        NewDef is (CurrentDefense+1),
        NewMaxHP is (MaxHP + 10),
        write('You have leveled up!'),nl,
        write('Level: '), write(CurrentLevel), write(' -> '), write(NewLvl), nl,
        write('Max HP: '), write(MaxHP), write(' -> '), write(NewMaxHP), nl,
        write('Attack: '), write(CurrentAttack), write(' -> '), write(NewAtt), nl,
        write('Defense: '), write(CurrentDefense), write(' -> '), write(NewDef), nl,
        retract(player(CurrentJob, CurrentAttribute, CurrentSkill, CurrentLevel, CurrentAttack, CurrentDefense, MaxHP)),
        asserta(player(CurrentJob,CurrentAttribute,CurrentSkill,NewLvl,NewAtt,NewDef,NewMaxHP)),
        EXPNow is (CurrEXP - (PCurrLvl*10)),
        retract(playerCurrExp(CurrEXP)),
        asserta(playerCurrExp(EXPNow))
    ;%else
        !.


/* Selektor */
getPlayerMaxHP(PMaxHP) :-
    player(_,_,_,_,_,_,PMaxHP).
getPlayerLvl(PLvl) :-
    player(_,_,_,PLvl,_,_,_).
getCurrentEnemyAttack(CEAttack) :-
    currentEnemy(_,CEAttack,_,_,_).
getCurrentEnemyHP(CEHP) :-
    currentEnemy(_,_,_,CEHP,_).
getCurrentEnemyName(CEName) :-
    currentEnemy(CEName,_,_,_,_).
getCurrentEnemyLvl(CELvl) :-
    currentEnemy(_,_,_,_,CELvl).

    
/* Potion */
potion(basic, 30).
potion(super, 60).
potion(ultra, 100).
potion(max, FullHP) :-
    getPlayerMaxHP(FullHP).


/*Basic Job*/
basicJob(swordsman).
basicJob(archer).
basicJob(sorcerer).

/*Specialized Job */
specializedJob(swordsMaster).
specializedJob(mercenary).
specializedJob(bowMaster).
specializedJob(acrobat).
specializedJob(elementalLord).
specializedJob(forceUser).

/*Ultimate Job*/
ultimateJob(gladiator).
ultimateJob(lunarKnight).
ultimateJob(barbarian).
ultimateJob(destroyer).
ultimateJob(artillery).
ultimateJob(sniper).
ultimateJob(windWalker).
ultimateJob(tempest).
ultimateJob(saleana).
ultimateJob(elestra).
ultimateJob(majesty).
ultimateJob(smasher).

/*Secret Job*/
secretJob(legendaryHero).

/* Job Advancement */

/* Basic to Specialized */
jobAdvancement(swordsman, swordsMaster).
jobAdvancement(swordsman, mercenary).
jobAdvancement(archer, bowMaster).
jobAdvancement(archer, acrobat).
jobAdvancement(sorcerer, elementalLord).
jobAdvancement(sorcerer, forceUser).

/* Specialized to Ultimate */
jobAdvancement(swordsMaster, gladiator).
jobAdvancement(swordsMaster, lunarKnight).
jobAdvancement(mercenary, barbarian).
jobAdvancement(mercenary, destroyer).
jobAdvancement(bowMaster, artillery).
jobAdvancement(bowMaster, sniper).
jobAdvancement(acrobat, windWalker).
jobAdvancement(acrobat, tempest).
jobAdvancement(elementalLord, saleana).
jobAdvancement(elementalLord, elestra).
jobAdvancement(forceUser, majesty).
jobAdvancement(forceUser, smasher).


/* Status Job */
attributeAttack(swordsman, slash).
attributeAttack(archer, pierce).
attributeAttack(sorcerer, magic).

statusLevel(swordsman, 5).
statusLevel(archer, 5).
statusLevel(sorcerer, 5).

statusHP(swordsman,120).
statusHP(archer, 80).
statusHP(sorcerer, 100).

statusAttack(swordsman, 8).
statusAttack(archer,12).
statusAttack(sorcerer, 10).

statusDefense(swordsman, 12).
statusDefense(archer, 8).
statusDefense(sorcerer,10).

statusAdvJob(swordsMaster, Attack, Defense, HP) :- 
    statusAttack(swordsman, BaseAtt),
    statusDefense(swordsman, BaseDef),
    statusHP(swordsman, BaseHP),
    Attack is (BaseAtt*2),
    Defense is (BaseDef*1.2),
    HP is (BaseHP*1.2).
statusAdvJob(mercenary, Attack, Defense, HP) :- 
    statusAttack(swordsman, BaseAtt),
    statusDefense(swordsman, BaseDef),
    statusHP(swordsman, BaseHP),
    Attack is (BaseAtt*1.5),
    Defense is (BaseDef*1.7),
    HP is (BaseHP*1.7).
statusAdvJob(bowMaster, Attack, Defense, HP) :- 
    statusAttack(archer, BaseAtt),
    statusDefense(archer, BaseDef),
    statusHP(archer, BaseHP),
    Attack is (BaseAtt*2),
    Defense is (BaseDef*1.2),
    HP is (BaseHP*1.2).
statusAdvJob(acrobat, Attack, Defense, HP) :- 
    statusAttack(archer, BaseAtt),
    statusDefense(archer, BaseDef),
    statusHP(archer, BaseHP),
    Attack is (BaseAtt*2),
    Defense is (BaseDef*1.2),
    HP is (BaseHP*1.2).
statusAdvJob(forceUser, Attack, Defense, HP) :- 
    statusAttack(sorcerer, BaseAtt),
    statusDefense(sorcerer, BaseDef),
    statusHP(sorcerer, BaseHP),
    Attack is (BaseAtt*2),
    Defense is (BaseDef*1.2),
    HP is (BaseHP*1.2).
statusAdvJob(elementalLord, Attack, Defense, HP) :- 
    statusAttack(sorcerer, BaseAtt),
    statusDefense(sorcerer, BaseDef),
    statusHP(sorcerer, BaseHP),
    Attack is (BaseAtt*2),
    Defense is (BaseDef*1.2),
    HP is (BaseHP*1.2).

/*statusUltJob(,Attack, Defense, HP) :-
    statusAdvJob(swordsMaster, BaseAtt, BaseDef, BaseHP),
    Attack is (BaseAtt*2),
    Defense is (BaseDef*2)*/
/* Special Skill */
skill(swordsman, heavySlash, 20).
skill(archer, twinShot, 20).
skill(sorcerer, voidExplosion, 20).

skill(swordsMaster, lineDrive, 40).
skill(swordsMaster, halfMoonSlash, 40).
skill(mercenary, whirlwind, 40).
skill(mercenary, rollingAttack, 40).
skill(bowMaster, trackingArrows, 40).
skill(bowMaster, arrowShower, 40).
skill(acrobat, cycloneKick, 40).
skill(acrobat, spiralVortex, 40).
skill(elementalLord, flameRoad, 40).
skill(elementalLord, chillingMist, 40).
skill(forceUser, gravityAscension, 40).
skill(forceUser, spectrumShower, 40).

skill(gladiator, hyperDrive, 60).
skill(lunarKnight, smashX, 60).
skill(barbarian, overtaker, 60).
skill(destroyer, assaultCrash, 60).
skill(artillery, cannonade, 60).
skill(sniper,slidingShot, 60).
skill(windWalker, flashKick, 60).
skill(tempest, hurricaneUppercut, 60).
skill(saleana,flameBurst, 60).
skill(elestra, iceCyclone, 60).
skill(majesty, gravityRush, 60).
skill(smasher, laserRay, 60).

/* MOBS */
enemy(goblin).
enemy(troll).
enemy(harpy).
enemy(lizardman).

/* Mid Boss */
midBoss(hobgoblin).
midBoss(trollElder).
midBoss(redHarpy).
midBoss(mutatedLizardman).

/* Final Boss (Naga) */
finalBoss(alduin).

/* Enemies's Stats */
enemyLevel(goblin, 5).
enemyLevel(troll, 8).
enemyLevel(harpy, 10).
enemyLevel(lizardman, 13).
enemyLevel(hobgoblin, 8).
enemyLevel(trollElder, 10).
enemyLevel(redHarpy, 13).
enemyLevel(mutatedLizardman, 15).
enemyLevel(alduin, 20).

enemyAttack(goblin, 3).
enemyAttack(troll, 5).
enemyAttack(harpy, 7).
enemyAttack(lizardman, 9).
enemyAttack(hobgoblin, 10).
enemyAttack(trollElder, 13).
enemyAttack(redHarpy, 17).
enemyAttack(mutatedLizardman, 20).
enemyAttack(alduin, 30).

enemyDefense(goblin, 3).
enemyDefense(troll, 5).
enemyDefense(harpy, 7).
enemyDefense(lizardman, 9).
enemyDefense(hobgoblin, 10).
enemyDefense(trollElder, 13).
enemyDefense(redHarpy, 17).
enemyDefense(mutatedLizardman, 20).
enemyDefense(alduin, 30).

enemyHP(goblin, 30).
enemyHP(troll, 50).
enemyHP(harpy, 70).
enemyHP(lizardman, 90).
enemyHP(hobgoblin, 100).
enemyHP(trollElder, 130).
enemyHP(redHarpy, 170).
enemyHP(mutatedLizardman, 200).
enemyHP(alduin, 300).

/* Encounter */
/*Penanda state permainan*/
gameState(nothing).
/* lain-lain */ 
currentEnemy(namaEnemy, attack, defense, hp, level).
encounter(Enemy) :-
    gameState(CurrState),
    asserta(gameState(battle)),
    retract(gameState(CurrState)),
    currentEnemy(CurrEnemy, CurrAtt, CurrDef, CurrHP, CurrLvl),
    enemyAttack(Enemy, EnemyAtt),
    enemyDefense(Enemy, EnemyDeff),
    enemyHP(Enemy, EnemyHP),
    enemyLevel(Enemy, EnemyLvl),
    asserta(currentEnemy(Enemy, EnemyAtt, EnemyDeff, EnemyHP, EnemyLvl)),
    retract(currentEnemy(CurrEnemy,CurrAtt,CurrDef,CurrHP,CurrLvl)).

/*Belum ditambahin kode buat reset special charge jadi 0 */
endTurn(EnemCurrHP, PCurrHP, Turn) :-
    (EnemCurrHP =< 0) ->
        retract(gameState(CurrState)),
        asserta(gameState(nothing)),
        %Tidak ada inisiasi current enemy karena variabel yang digunakan diambil dari predicate yang memanggil endTurn.
        retract(currentEnemy(EnemName,EnemAtt, EnemDeff,EnemCurrHP, EnemLvl)),
        asserta(currentEnemy(namaEnemy, attack, defense, hp, level)),

        %Perhitungan EXP
        playerCurrExp(ExpBefore),
        ExpGain is (EnemLvl*10),
        ExpAfter is (ExpBefore + ExpGain),
        retract(playerCurrExp(ExpBefore)),
        asserta(playerCurrExp(ExpAfter)),
        nl, write('You have succesfuly slain '), write(EnemName), nl,
        write('You gained '), write(ExpGain), write(' experience points'),nl,
        playerLvlUp
    ;(PCurrHP =< 0) ->
        retract(gameState(CurrState)),
        asserta(gameState(lose)),
        retract(currentEnemy(EnemName,EnemAtt, EnemDeff,EnemCurrHP, EnemLvl)),
        asserta(currentEnemy(namaEnemy, attack, defense, hp, level)),
        nl, write('You have been killed.')
    ;(Turn = 1) -> %1 artinya turn player, 0 untuk turn enemy.
        enemyTurnAttack 
    %Masih perlu ditambah turn = enemy (nanti mungkin isinya nampilin menu pilihan aksi yg bisa dilakukan player)
    ;%else
    !.

attack :-
    gameState(CurrState),
    
    CurrState = battle ->
        playerCurrHP(PCurrHP),
        Turn is 1,
        specialAttCharge(CurrCharge),
        NewCurrCharge is (CurrCharge + 1),
        asserta(specialAttCharge(NewCurrCharge)),
        retract(specialAttCharge(CurrCharge)),
        player(_,_,_,_,PlayerAtt,_,_),
        currentEnemy(EnemName,EnemAtt, EnemDeff,EnemHP, EnemLvl),
        write('You deal '), write(PlayerAtt), write(' damage to '), write(EnemName),
        EnemCurrHP is (EnemHP-PlayerAtt),
        asserta(currentEnemy(EnemName,EnemAtt, EnemDeff,EnemCurrHP, EnemLvl)),
        retract(currentEnemy(EnemName,EnemAtt, EnemDeff,EnemHP, EnemLvl)),
        endTurn(EnemCurrHP, PCurrHP, Turn)
    ;%else
    write('You are not currently in a battle!').


/*Special Attack Mechanics*/
specialAttCharge(0).

specialAttack :-
    gameState(CurrState),
    CurrState \= battle,
    !,
    write('You are not currently in a battle!').
specialAttack :-
    specialAttCharge(CurrCharge),
    (CurrCharge >= 3) ->
        Turn is 1,
        playerCurrHP(PCurrHP),
        asserta(specialAttCharge(0)),
        retract(specialAttCharge(CurrCharge)),
        player(CurrentJob,_,_,_,PlayerAtt,_,_),
        skill(CurrentJob,SkillName,SkillBaseAtt),
        TotalSpecialAtt is (SkillBaseAtt + PlayerAtt),
        currentEnemy(EnemName,EnemAtt, EnemDeff,EnemHP, EnemLvl),
        write('You used Special Attack: '), write(SkillName), nl,
        write('You deal '), write(TotalSpecialAtt), write(' damage to '), write(EnemName),
        EnemCurrHP is (EnemHP-TotalSpecialAtt),
        asserta(currentEnemy(EnemName,EnemAtt, EnemDeff,EnemCurrHP, EnemLvl)),
        retract(currentEnemy(EnemName,EnemAtt, EnemDeff,EnemHP, EnemLvl)),
        endTurn(EnemCurrHP, PCurrHP, Turn)
    ;%not enough special attack charge
    write('You do not have enough special attack charge!').
usePotion(JenisPotion) :-
    playerCurrHP(PCurrHP),
    potion(JenisPotion, Heal),
    getPlayerMaxHP(MaxHP),
    write('You have recovered '), write(Heal), write(' Health'),
    retract(playerCurrHP(PCurrHP)),

    PHPNow is (PCurrHP + Heal),
    (PHPNow >= MaxHP) ->
        asserta(playerCurrHP(MaxHP))
    ;%else
        asserta(playerCurrHP(PHPNow)).
    


/* Enemy's Turn */
enemyTurnAttack :- 
    getCurrentEnemyName(CEName),
    getCurrentEnemyAttack(CEAttack),
    playerCurrHP(PCurrHP),
    PlayerHPNow is (PCurrHP - CEAttack),
    nl, write(CEName), write(' attacks! You received '), write(CEAttack), write(' damage!'), nl,
    retract(playerCurrHP(PCurrHP)),
    asserta(playerCurrHP(PlayerHPNow)),
    getCurrentEnemyHP(EnemCurrHP),
    Turn is 0,
    endTurn(EnemCurrHP, PCurrHP, Turn).

/* DUMMY */
test:-
    initPlayer(swordsman),
    encounter(goblin).