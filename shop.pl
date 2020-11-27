/* ITEM PRICE */
shopItem('Gacha', 100).
shopItem('Health Potion', 10).
shopItem('Basic Potion', 10).
shopItem('Super Potion', 20).
shopItem('Ultra Potion', 30).
shopItem('Max Potion', 50).

/*BUY*/
buy(Item) :-
    shopItem(Item, Price),
    playerGold(CurrentGold),
    GoldNow is (CurrentGold-Price),

    (GoldNow < 0,
        !, format('You don\'t have enough Gold to buy ~w!\n',[Item]), fail
    ;Item = 'Gacha',
        retractall(playerGold(_)),
        asserta(playerGold(GoldNow)),
        gacha,!
    ;addItem(Item),
    retractall(playerGold(_)),
    asserta(playerGold(GoldNow)),
    format('Purchase success! ~w has been added to your inventory!\n',[Item]),!
    ).

/*GACHA*/

rarity(1,'Normal').
rarity(2,'Rare').
rarity(3,'Epic').

jobRestriction(1, 'Swordsman').
jobRestriction(2, 'Archer').
jobRestriction(3, 'Sorcerer').

equipmentType(1,'Helmet').
equipmentType(2,'Chestplate').
equipmentType(3,'Leggings').
equipmentType(4,'Boots').


equipmentRarity(Rarity) :-
    random(1,101,Luck),

    (Luck > 90,
        rarity(3,Rarity),!
    ;Luck > 70,
        rarity(2,Rarity),!
    ;rarity(1,Rarity),!
    ).
equipmentJobRestriction(JobRestriction) :-
    random(1,101,TotallyRandom),

    (TotallyRandom > 67,
        jobRestriction(1,JobRestriction),!
    ;TotallyRandom > 33,
        jobRestriction(2,JobRestriction),!
    ;jobRestriction(3,JobRestriction),!
    ).
getEquipmentType(EquipmentType) :-
    random(1,101,RandomType),

    (RandomType > 75,
        equipmentType(1,EquipmentType),!
    ;RandomType > 50,
        equipmentType(2,EquipmentType),!
    ;RandomType > 25,
        equipmentType(3,EquipmentType),!
    ;equipmentType(4, EquipmentType),!
    ).


gacha :- 
    equipmentRarity(Rarity),
    equipmentJobRestriction(JobRestriction),
    getEquipmentType(EquipmentType),
    random(1,3,Tier),
    equipment(JobRestriction,EquipmentType,EquipmentName,Rarity,Tier),

    addItem(EquipmentName),
    format('Purchase success! ~w has been added to your inventory!\n',[EquipmentName]),
    !.



