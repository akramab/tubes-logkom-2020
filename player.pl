:- dynamic(playerJob/1).
:- dynamic(playerBaseJob/1).
:- dynamic(playerJobRank/1).
:- dynamic(playerAttackType/1).
:- dynamic(playerAttackElement/1).
:- dynamic(playerSpecialAttack/1).
:- dynamic(playerLevel/1).
:- dynamic(playerMaxHealth/1).
:- dynamic(playerCurrentHealth/1).
:- dynamic(playerAttack/1).
:- dynamic(playerDefense/1).
:- dynamic(playerMaxExp/1).
:- dynamic(playerCurrentExp/1).
:- dynamic(playerGold/1).
:- dynamic(playerHelmetInfo/4).
:- dynamic(playerChestplateInfo/4).
:- dynamic(playerLeggingsInfo/4).
:- dynamic(playerBootsInfo/4).

:- dynamic(playerEquipmentWear/4).

initClass :-
    write('Choose your class:'), nl,
    write('Format: <class>.'), nl,
    write('1. swordsman'), nl,
    write('2. archer'), nl,
    write('3. sorcerer'), nl,
    repeat,
    write(' > '),
    read(Class),
    ((Class == swordsman -> Job = 'Swordsman'); (Class == archer -> Job = 'Archer'); (Class == sorcerer -> Job = 'Sorcerer')),
    initPlayer(Job).

/* PLAYER'S STATUS */
playerJob('Otherworlder').
playerBaseJob('????').
playerJobRank('????').
playerAttackType('????').
playerAttackElement('????').
playerSpecialAttack('????').
playerLevel('????').
playerMaxHealth('????').
playerCurrentHealth('????').
playerAttack('????').
playerDefense('????').
playerMaxExp('????').
playerCurrentExp('????').
playerGold('????').
playerHelmetInfo('????','????','????','????').
playerChestplateInfo('????','????','????','????').
playerLeggingsInfo('????','????','????','????').
playerBootsInfo('????','????','????','????').
/* PLAYER'S EQUIPMENT */


initPlayer(Job) :-
    retractall(playerJob(_)),
    retractall(playerBaseJob(_)),
    retractall(playerJobRank(_)),
    retractall(playerAttackType(_)),
    retractall(playerAttackElement(_)),
    retractall(playerSpecialAttack(_)),
    retractall(playerLevel(_)),
    retractall(playerMaxHealth(_)),
    retractall(playerCurrentHealth(_)),
    retractall(playerAttack(_)),
    retractall(playerDefense(_)),    
    retractall(playerMaxExp(_)),
    retractall(playerCurrentExp(_)),
    retractall(playerGold(_)),

    asserta(playerEquipmentWear(0,0,0,0)),
    addItem('Basic Potion',5),

    asserta(playerJob(Job)),
    baseJob(Job, BaseJob), asserta(playerBaseJob(BaseJob)),
    job(JobRank, Job), asserta(playerJobRank(JobRank)),
    attackType(Job, AttackType), asserta(playerAttackType(AttackType)),
    attackElement(Job, AttackElement), asserta(playerAttackElement(AttackElement)),
    specialAttackName(Job, SpecialAttackName), asserta(playerSpecialAttack(SpecialAttackName)),
    baseLevel(Job, BaseLevel), asserta(playerLevel(BaseLevel)),
    baseHealth(Job, BaseHealth), asserta(playerMaxHealth(BaseHealth)), asserta(playerCurrentHealth(BaseHealth)),
    baseAttack(Job, BaseAttack), asserta(playerAttack(BaseAttack)),
    baseDefense(Job, BaseDefense), asserta(playerDefense(BaseDefense)),
    PlayerMaxExp is (BaseLevel*10), asserta(playerMaxExp(PlayerMaxExp)), asserta(playerCurrentExp(0)),
    asserta(playerGold(1000)),

    format('Initialization success. You are our last hope, ~w!\n', [Job]),
    !.

status :-
    playerJob(PlayerJob),
    playerJobRank(PlayerJobRank),
    playerAttackType(PlayerAttackType),
    playerAttackElement(PlayerAttackElement),
    playerSpecialAttack(PlayerSpecialAttack),
    playerLevel(PlayerLevel),
    playerMaxHealth(PlayerMaxHealth),
    playerCurrentHealth(PlayerCurrentHealth),
    playerAttack(PlayerAttack),
    playerDefense(PlayerDefense),
    playerMaxExp(PlayerMaxExp),
    playerCurrentExp(PlayerCurrentExp),
    playerGold(PlayerGold),

    format('Job: ~w\n', [PlayerJob]),
    format('Rank: ~w\n', [PlayerJobRank]),
    format('Attack Type: ~w\n', [PlayerAttackType]),
    format('Element: ~w\n', [PlayerAttackElement]),
    format('Special Attack: ~w\n', [PlayerSpecialAttack]),
    format('Level: ~w\n',[PlayerLevel]),
    format('Health: ~w/~w\n',[PlayerCurrentHealth,PlayerMaxHealth]),
    format('Attack: ~w\n',[PlayerAttack]),
    format('Defense: ~w\n',[PlayerDefense]),
    format('Exp: ~w/~w\n',[PlayerCurrentExp,PlayerMaxExp]),
    format('Gold: ~w\n',[PlayerGold]),

    gameState(GameState),
    (GameState = 'Battle' ->
        playerSpecialAttackCharge(CurrentSPCharge),
        format('Special Attack Charge: ~w\n', [CurrentSPCharge]),!
    ;!
    ).

showEq :-
    showEquippedHelmet,
    showEquippedChestplate,
    showEquippedLeggings,
    showEquippedBoots,!.

showEquippedHelmet :-
    playerEquipmentWear(H,_,_,_),
    (H = 1,
        playerHelmetInfo(_,EqName,Attack,Defense),
        format('Helmet: ~w [Attack +~w Defense +~w]\n',[EqName,Attack,Defense]), !
    ;write('Helmet: (None)\n'), !
    ).
showEquippedChestplate :-
    playerEquipmentWear(_,C,_,_),
    (C = 1,
        playerChestplateInfo(_,EqName,Attack,Defense),
        format('Chestplate: ~w [Attack +~w Defense +~w]\n',[EqName,Attack,Defense]), !
    ;write('Chestplate: (None)\n'), !
    ).

showEquippedLeggings :-
    playerEquipmentWear(_,_,L,_),
    (L = 1,
        playerLeggingsInfo(_,EqName,Attack,Defense),
        format('Leggings: ~w [Attack +~w Defense +~w]\n',[EqName,Attack,Defense]), !
    ;write('Leggings: (None)\n'), !
    ).

showEquippedBoots :-
    playerEquipmentWear(_,_,_,B),
    (B = 1,
        playerBootsInfo(_,EqName,Attack,Defense),
        format('Boots: ~w [Attack +~w Defense +~w]\n',[EqName,Attack,Defense]), !
    ;write('Boots: (None)\n'),!
    ).



playerLevelUp :-
    playerCurrentExp(PlayerCurrentExp),
    playerMaxExp(PlayerMaxExp),

    (PlayerCurrentExp >= PlayerMaxExp) ->
        playerLevel(PlayerLevel),
        playerMaxHealth(PlayerMaxHealth),
        playerCurrentHealth(PlayerCurrentHealth),
        playerAttack(PlayerAttack),
        playerDefense(PlayerDefense),
        playerMaxExp(PlayerMaxExp),
        playerCurrentExp(PlayerCurrentExp),

        NewPlayerLevel is (PlayerLevel + 1),
        NewPlayerMaxHealth is (PlayerMaxHealth + 10),
        NewPlayerCurrentHealth is (PlayerCurrentHealth + 10),
        NewPlayerAttack is (PlayerAttack+1),
        NewPlayerDefense is (PlayerDefense+1),
        NewPlayerMaxExp is (NewPlayerLevel*10),
        NewPlayerCurrentExp is (PlayerCurrentExp-PlayerMaxExp),

        retractall(playerLevel(_)),
        retractall(playerMaxHealth(_)),
        retractall(playerCurrentHealth(_)),
        retractall(playerAttack(_)),
        retractall(playerDefense(_)),
        retractall(playerMaxExp(_)),
        retractall(playerCurrentExp(_)),

        asserta(playerLevel(NewPlayerLevel)),
        asserta(playerMaxHealth(NewPlayerMaxHealth)),
        asserta(playerCurrentHealth(NewPlayerCurrentHealth)),
        asserta(playerAttack(NewPlayerAttack)),
        asserta(playerDefense(NewPlayerDefense)),
        asserta(playerMaxExp(NewPlayerMaxExp)),
        asserta(playerCurrentExp(NewPlayerCurrentExp)),

        write('You\'ve leveled up!\n'),
        nl,
        format('Level: ~w -> ~w\n', [PlayerLevel,NewPlayerLevel]),
        format('Health: ~w/~w -> ~w/~w\n', [PlayerCurrentHealth,PlayerMaxHealth,NewPlayerCurrentHealth,NewPlayerMaxHealth]),
        format('Attack: ~w -> ~w\n', [PlayerAttack, NewPlayerAttack]),
        format('Defense: ~w -> ~w\n', [PlayerDefense,NewPlayerDefense]), playerLevelUp
    ;%else
        !.
/*EQUIPMENT*/

equipEquipment(Type, EquipName,Attack, Defense) :- 
    currentInventory(Inventory),

    (\+ member(EquipName, Inventory),
        !, format('You don\'t have ~w in your inventory!',[EquipName]), fail
    ;Type = 'Helmet',
        playerEquipmentWear(HelmetUse,_,_,_),
        HelmetUse = 1, !, write('You\'ve already worn a helmet!'), fail
    ;Type = 'Chestplate',
        playerEquipmentWear(_,ChestplateUse,_,_),
        ChestplateUse = 1, !, write('You\'ve already worn a chestplate!'), fail
    ;Type = 'Leggings',
        playerEquipmentWear(_,_,LeggingsUse,_),
        LeggingsUse = 1, !, write('You\'ve already worn a leggings!'), fail
    ;Type = 'Boots',
        playerEquipmentWear(_,_,_,BootsUse),
        BootsUse = 1, !, write('You\'ve already worn a boots!'), fail
    ;equipJobRestriction(Type,EquipName,Attack,Defense),!
    ).

equipJobRestriction(Type,EquipName,Attack,Defense) :-
    playerBaseJob(BaseJob),
    equipment(JobRestriction,_,EquipName,_,_),

    (BaseJob = JobRestriction,
        equipEquipmentStats(Type,EquipName,Attack,Defense),!
    ;!,format('You can only wear ~w based equipments!',[BaseJob]),fail
    ).


equipEquipmentStats(Type,EquipName,Attack,Defense) :-
    playerAttack(CurrentAttack),
    playerDefense(CurrentDefense),

    NewAttack is (CurrentAttack+Attack),
    NewDefense is (CurrentDefense+Defense),

    retractall(playerAttack(_)),
    retractall(playerDefense(_)),

    asserta(playerAttack(NewAttack)),
    asserta(playerDefense(NewDefense)),

    playerEquipmentWear(CurHelm,CurChest,CurLeg,CurBoots),

    useItemFromInventory(EquipName),
    format('Your stats have increased!\nAttack: ~w -> ~w\nDefense: ~w -> ~w\n',[CurrentAttack,NewAttack,CurrentDefense,NewDefense]),

    (Type = 'Helmet' ->
        retractall(playerEquipmentWear(_,_,_,_)),
        retractall(playerHelmetInfo(_,_,_,_)),

        asserta(playerEquipmentWear(1,CurChest,CurLeg,CurBoots)),
        asserta(playerHelmetInfo(Type,EquipName,Attack,Defense)),

        write('Helmet is equipped\n'),!
    ;Type = 'Chestplate' ->
        retractall(playerEquipmentWear(_,_,_,_)),
        retractall(playerChestplateInfo(_,_,_,_)),

        asserta(playerEquipmentWear(CurHelm,1,CurLeg,CurBoots)),
        asserta(playerChestplateInfo(Type,EquipName,Attack,Defense)),

        write('Chestplate is equipped\n'),!
    ;Type = 'Leggings' ->
        retractall(playerEquipmentWear(_,_,_,_)),
        retractall(playerLeggingsInfo(_,_,_,_)),

        asserta(playerLeggingsInfo(Type,EquipName,Attack,Defense)),
        asserta(playerEquipmentWear(CurHelm,CurChest,1,CurBoots)),
        write('Leggings is equipped\n'),!
    ;Type = 'Boots' ->
        retractall(playerEquipmentWear(_,_,_,_)),
        retractall(playerBootsInfo(_,_,_,_)),

        asserta(playerBootsInfo(Type,EquipName,Attack,Defense)),
        asserta(playerEquipmentWear(CurHelm,CurChest,CurLeg,1)),
        write('Boots is equipped\n'),!
    ).

/*UNEQUIP*/
unequipEquipment(Type) :-
    playerEquipmentWear(CurHelm,CurChest,CurLeg,CurBoots),
    (Type = 'Helmet',
        CurHelm = 0, !, write('You haven\'t equipped any helmet yet!'), fail
    ;Type = 'Chestplate',
        CurChest = 0, !, write('You haven\'t equipped any chestplate yet!'), fail
    ;Type = 'Leggings',
        CurLeg = 0, !, write('You haven\'t equipped any leggings yet!'), fail
    ;Type = 'Boots',
        CurBoots = 0, !, write('You haven\'t equipped any boots yet'), fail
    ;unequipEquipmentStats(Type),!
    ).
unequipEquipmentStats(Type) :-
    playerAttack(CurrentAttack),
    playerDefense(CurrentDefense),

    playerEquipmentWear(CurHelm,CurChest,CurLeg,CurBoots),


    (Type = 'Helmet' ->
        playerHelmetInfo(_,EquipName,EqAttack,EqDefense),
        retractall(playerEquipmentWear(_,_,_,_)),
        retractall(playerHelmetInfo(_,_,_,_)),

        addItem(EquipName),
        asserta(playerEquipmentWear(0,CurChest,CurLeg,CurBoots)),

        NewAttack is (CurrentAttack-EqAttack),
        NewDefense is (CurrentDefense-EqDefense),

        retractall(playerAttack(_)),
        retractall(playerDefense(_)),

        asserta(playerAttack(NewAttack)),
        asserta(playerDefense(NewDefense)),

        write('Helmet is unequipped\n'),
        format('Your stats\nAttack: ~w -> ~w\nDefense: ~w -> ~w\n',[CurrentAttack,NewAttack,CurrentDefense,NewDefense]),!
    ;Type = 'Chestplate' ->
        playerChestplateInfo(_,EquipName,EqAttack,EqDefense),
        retractall(playerEquipmentWear(_,_,_,_)),
        retractall(playerChestplateInfo(_,_,_,_)),

        addItem(EquipName),
        asserta(playerEquipmentWear(CurHelm,0,CurLeg,CurBoots)),

        NewAttack is (CurrentAttack-EqAttack),
        NewDefense is (CurrentDefense-EqDefense),

        retractall(playerAttack(_)),
        retractall(playerDefense(_)),

        asserta(playerAttack(NewAttack)),
        asserta(playerDefense(NewDefense)),

        write('Chestplate is unequipped\n'),
        format('Your stats\nAttack: ~w -> ~w\nDefense: ~w -> ~w\n',[CurrentAttack,NewAttack,CurrentDefense,NewDefense]),!
    ;Type = 'Leggings' ->
        playerLeggingsInfo(_,EquipName,EqAttack,EqDefense),
        retractall(playerEquipmentWear(_,_,_,_)),
        retractall(playerLeggingstInfo(_,_,_,_)),

        addItem(EquipName),
        asserta(playerEquipmentWear(CurHelm,CurChest,0,CurBoots)),

        NewAttack is (CurrentAttack-EqAttack),
        NewDefense is (CurrentDefense-EqDefense),

        retractall(playerAttack(_)),
        retractall(playerDefense(_)),

        asserta(playerAttack(NewAttack)),
        asserta(playerDefense(NewDefense)),

        write('Leggings is unequipped\n'),
        format('Your stats\nAttack: ~w -> ~w\nDefense: ~w -> ~w\n',[CurrentAttack,NewAttack,CurrentDefense,NewDefense]),!
    ;Type = 'Boots' ->
        playerBootsInfo(_,EquipName,EqAttack,EqDefense),
        retractall(playerEquipmentWear(_,_,_,_)),
        retractall(playerBootsInfo(_,_,_,_)),

        addItem(EquipName),
        asserta(playerEquipmentWear(CurHelm,CurChest,CurLeg,0)),

        NewAttack is (CurrentAttack-EqAttack),
        NewDefense is (CurrentDefense-EqDefense),

        retractall(playerAttack(_)),
        retractall(playerDefense(_)),

        asserta(playerAttack(NewAttack)),
        asserta(playerDefense(NewDefense)),

        write('Boots is unequipped\n'),
        format('Your stats\nAttack: ~w -> ~w\nDefense: ~w -> ~w\n',[CurrentAttack,NewAttack,CurrentDefense,NewDefense]),!
    ).