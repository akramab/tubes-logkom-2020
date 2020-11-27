/* POTION */
potion('Health Potion', 150).
potion('Basic Potion', 30).
potion('Super Potion', 60).
potion('Ultra Potion', 100).
potion('Max Potion', Heal) :-
    playerMaxHealth(Heal),
    !.


/* Equipment */

/*Swordsman*/
equipment('Swordsman','Helmet','Leather Helmet (Swordsman)','Normal',1).
equipment('Swordsman','Helmet','Chainmail Helmet (Swordsman)','Normal',2).
equipment('Swordsman','Helmet','Gold Helmet (Swordsman)','Rare',1).
equipment('Swordsman','Helmet','Iron Helmet (Swordsman)','Rare',2).
equipment('Swordsman','Helmet','Diamond Helmet (Swordsman)','Epic',1).
equipment('Swordsman','Helmet','Netherite Helmet (Swordsman)','Epic',2).


equipment('Swordsman','Chestplate','Leather Chestplate (Swordsman)','Normal',1).
equipment('Swordsman','Chestplate','Chainmail Chestplate (Swordsman)','Normal',2).
equipment('Swordsman','Chestplate','Gold Chestplate (Swordsman)','Rare',1).
equipment('Swordsman','Chestplate','Iron Chestplate (Swordsman)','Rare',2).
equipment('Swordsman','Chestplate','Diamond Chestplate (Swordsman)','Epic',1).
equipment('Swordsman','Chestplate','Netherite Chestplate (Swordsman)','Epic',2).

equipment('Swordsman','Leggings','Leather Leggings (Swordsman)','Normal',1).
equipment('Swordsman','Leggings','Chainmail Leggings (Swordsman)','Normal',2).
equipment('Swordsman','Leggings','Gold Leggings (Swordsman)','Rare',1).
equipment('Swordsman','Leggings','Iron Leggings (Swordsman)','Rare',2).
equipment('Swordsman','Leggings','Diamond Leggings (Swordsman)','Epic',1).
equipment('Swordsman','Leggings','Netherite Leggings (Swordsman)','Epic',2).

equipment('Swordsman','Boots','Leather Boots (Swordsman)','Normal',1).
equipment('Swordsman','Boots','Chainmail Boots (Swordsman)','Normal',2).
equipment('Swordsman','Boots','Gold Boots (Swordsman)','Rare',1).
equipment('Swordsman','Boots','Iron Boots (Swordsman)','Rare',2).
equipment('Swordsman','Boots','Diamond Boots (Swordsman)','Epic',1).
equipment('Swordsman','Boots','Netherite Boots (Swordsman)','Epic',2).

/*Archer*/
equipment('Archer','Helmet','Leather Helmet (Archer)','Normal',1).
equipment('Archer','Helmet','Chainmail Helmet (Archer)','Normal',2).
equipment('Archer','Helmet','Gold Helmet (Archer)','Rare',1).
equipment('Archer','Helmet','Iron Helmet (Archer)','Rare',2).
equipment('Archer','Helmet','Diamond Helmet (Archer)','Epic',1).
equipment('Archer','Helmet','Netherite Helmet (Archer)','Epic',2).


equipment('Archer','Chestplate','Leather Chestplate (Archer)','Normal',1).
equipment('Archer','Chestplate','Chainmail Chestplate (Archer)','Normal',2).
equipment('Archer','Chestplate','Gold Chestplate (Archer)','Rare',1).
equipment('Archer','Chestplate','Iron Chestplate (Archer)','Rare',2).
equipment('Archer','Chestplate','Diamond Chestplate (Archer)','Epic',1).
equipment('Archer','Chestplate','Netherite Chestplate (Archer)','Epic',2).

equipment('Archer','Leggings','Leather Leggings (Archer)','Normal',1).
equipment('Archer','Leggings','Chainmail Leggings (Archer)','Normal',2).
equipment('Archer','Leggings','Gold Leggings (Archer)','Rare',1).
equipment('Archer','Leggings','Iron Leggings (Archer)','Rare',2).
equipment('Archer','Leggings','Diamond Leggings (Archer)','Epic',1).
equipment('Archer','Leggings','Netherite Leggings (Archer)','Epic',2).

equipment('Archer','Boots','Leather Boots (Archer)','Normal',1).
equipment('Archer','Boots','Chainmail Boots (Archer)','Normal',2).
equipment('Archer','Boots','Gold Boots (Archer)','Rare',1).
equipment('Archer','Boots','Iron Boots (Archer)','Rare',2).
equipment('Archer','Boots','Diamond Boots (Archer)','Epic',1).
equipment('Archer','Boots','Netherite Boots (Archer)','Epic',2).

/*Sorcerer*/
equipment('Sorcerer','Helmet','Leather Helmet (Sorcerer)','Normal',1).
equipment('Sorcerer','Helmet','Chainmail Helmet (Sorcerer)','Normal',2).
equipment('Sorcerer','Helmet','Gold Helmet (Sorcerer)','Rare',1).
equipment('Sorcerer','Helmet','Iron Helmet (Sorcerer)','Rare',2).
equipment('Sorcerer','Helmet','Diamond Helmet (Sorcerer)','Epic',1).
equipment('Sorcerer','Helmet','Netherite Helmet (Sorcerer)','Epic',2).


equipment('Sorcerer','Chestplate','Leather Chestplate (Sorcerer)','Normal',1).
equipment('Sorcerer','Chestplate','Chainmail Chestplate (Sorcerer)','Normal',2).
equipment('Sorcerer','Chestplate','Gold Chestplate (Sorcerer)','Rare',1).
equipment('Sorcerer','Chestplate','Iron Chestplate (Sorcerer)','Rare',2).
equipment('Sorcerer','Chestplate','Diamond Chestplate (Sorcerer)','Epic',1).
equipment('Sorcerer','Chestplate','Netherite Chestplate (Sorcerer)','Epic',2).

equipment('Sorcerer','Leggings','Leather Leggings (Sorcerer)','Normal',1).
equipment('Sorcerer','Leggings','Chainmail Leggings (Sorcerer)','Normal',2).
equipment('Sorcerer','Leggings','Gold Leggings (Sorcerer)','Rare',1).
equipment('Sorcerer','Leggings','Iron Leggings (Sorcerer)','Rare',2).
equipment('Sorcerer','Leggings','Diamond Leggings (Sorcerer)','Epic',1).
equipment('Sorcerer','Leggings','Netherite Leggings (Sorcerer)','Epic',2).

equipment('Sorcerer','Boots','Leather Boots (Sorcerer)','Normal',1).
equipment('Sorcerer','Boots','Chainmail Boots (Sorcerer)','Normal',2).
equipment('Sorcerer','Boots','Gold Boots (Sorcerer)','Rare',1).
equipment('Sorcerer','Boots','Iron Boots (Sorcerer)','Rare',2).
equipment('Sorcerer','Boots','Diamond Boots (Sorcerer)','Epic',1).
equipment('Sorcerer','Boots','Netherite Boots (Sorcerer)','Epic',2).


/*RARITY RELATIONS*/
betterEquipment('Normal','Rare') :- !.
betterEquipment('Rare','Epic') :- !.

/*EQUIPMENT STATS*/

/*Swordsman*/
equipmentStats('Helmet','Normal',2,3) :- !.
equipmentStats('Chestplate','Normal',3,5) :- !.
equipmentStats('Leggings','Normal',3,4) :- !.
equipmentStats('Boots','Normal',1,2) :- !.
/*Archer
equipmentStats('Helmet (Archer)','Normal',2,3) :- !.
equipmentStats('Chestplate (Archer)','Normal',3,5) :- !.
equipmentStats('Leggings (Archer)','Normal',3,4) :- !.
equipmentStats('Boots (Archer)','Normal',1,2) :- !.
Sorcerer
equipmentStats('Helmet (Sorcerer)','Normal',2,3) :- !.
equipmentStats('Chestplate (Sorcerer)','Normal',3,5) :- !.
equipmentStats('Leggings (Sorcerer)','Normal',3,4) :- !.
equipmentStats('Boots (Sorcerer)','Normal',1,2) :- !.*/


/*Above Normal Rarity*/
equipmentStats(Type,Rarity,Attack,Defense) :-
    betterEquipment(BelowRarity,Rarity),
    equipmentStats(Type,BelowRarity,TempAttack,TempDefense),
    Attack is (2*TempAttack), Defense is (2*TempDefense),
    !.