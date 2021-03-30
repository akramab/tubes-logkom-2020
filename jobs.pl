/* JOB */
/* Basic Job */
job('Basic', 'Swordsman').
job('Basic', 'Archer').

/* Specialized Job */
job('Specialized', 'Swordmaster').
job('Specialized', 'Mercenary').
job('Specialized', 'Bowmaster').
job('Specialized', 'Acrobat').
job('Specialized', 'Elemental Lord').
job('Specialized', 'Force User').

/* Ultimate Job */
job('Ultimate', 'Gladiator').
job('Ultimate', 'Lunar Knight').
job('Ultimate', 'Barbarian').
job('Ultimate', 'Destroyer').
job('Ultimate', 'Artillery').
job('Ultimate', 'Sniper').
job('Ultimate', 'Windwalker').
job('Ultimate', 'Tempest').
job('Ultimate', 'Saleana').
job('Ultimate', 'Elestra').
job('Ultimate', 'Chaos Mage').
job('Ultimate', 'War Mage').


/* Legendary Job */
job('Legendary', 'Hero').

/* JOB ADVANCEMENT */

/* Basic to Specialized */
jobAdvancement('Swordsman', 'Swordmaster').
jobAdvancement('Swordsman', 'Mercenary').
jobAdvancement('Archer', 'Bowmaster').
jobAdvancement('Archer', 'Acrobat').
jobAdvancement('Sorcerer', 'Elemental Lord').
jobAdvancement('Sorcerer', 'Force User').

/* Specialized to Ultimate */
jobAdvancement('Swordmaster', 'Gladiator').
jobAdvancement('Swordmaster', 'Lunar Knight').
jobAdvancement('Mercenary', 'Barbarian').
jobAdvancement('Mercenary', 'Destroyer').
jobAdvancement('Bowmaster', 'Artillery').
jobAdvancement('Bowmaster', 'Sniper').
jobAdvancement('Acrobat', 'Windwalker').
jobAdvancement('Acrobat', 'Tempest').
jobAdvancement('Elemental Lord', 'Saleana').
jobAdvancement('Elemental Lord', 'Elestra').
jobAdvancement('Force User', 'Majesty').
jobAdvancement('Force User', 'Smasher').

/* BASE JOB */
/* Base Job merupakan Job paling dasar dari tiap job (ex: Gladiator memiliki base job Swordsman, etc.)*/

baseJob('Swordsman', 'Swordsman').
baseJob('Archer', 'Archer').
baseJob('Sorcerer', 'Sorcerer').
/* Untuk basic job, maka pencarian base jobnya menggunakan metode rekursif */
baseJob(CurrentJob, BaseJob) :- 
    jobAdvancement(PrevJob, CurrentJob),
    baseJob(PrevJob, BaseJob),
    !.



/* JOB STATUS */
/* Attack Type merupakan tipe serangan yang dimiliki masing-masing job. Tiap tipe serangan memiliki kelemahan dan keunggulan terhadap jenis armor tertentu dan atau musuh-musuh tertentu */
attackType('Swordsman', 'Slash').
attackType('Archer', 'Pierce').
attackType('Sorcerer', 'Magic').

attackType('Mercenary', 'Strike').
attackType('Acrobat', 'Strike').

attackType(CurrentJob, AttackType) :-
    jobAdvancement(PrevJob, CurrentJob),
    attackType(PrevJob, AttackType),
    !.
/* Dalam game ini juga ada elemental attack. By default semua base job tidak memiliki elemen. Tapi elemen bisa didapatkan dengan menggunakan item atau dengan advancement ke job tertentu*/
/* Job tingkat lanjut yang sudah memiliki elemen bawaan, tidak bisa mengubah elemen serangannya dengan menggunakan item. */
/* Tipe elemen terbagi menjadi 5: Fire, Water, Light, Dark, dan None (tidak berelemen;netral) */
attackElement('Swordsman', 'None').
attackElement('Archer', 'None').
attackElement('Sorcerer', 'None').

attackElement('Chaos Mage', 'Dark').
attackElement('War Mage', 'Light').
attackElement('Saleana', 'Fire').
attackElement('Elestra', 'Water').

attackElement(CurrentJob, AttackElement) :-
    jobAdvancement(PrevJob, CurrentJob),
    attackElement(PrevJob, AttackElement),
    !.


baseLevel('Swordsman', 5).
baseLevel('Archer', 5).
baseLevel('Sorcerer', 5).

baseHealth('Swordsman',120).
baseHealth('Archer', 80).
baseHealth('Sorcerer', 100).

baseAttack('Swordsman', 8).
baseAttack('Archer',12).
baseAttack('Sorcerer', 10).

baseDefense('Swordsman', 12).
baseDefense('Archer', 8).
baseDefense('Sorcerer',10).


/* SPECIAL ATTACK */
/* Setiap job memiliki nama dan damage special attack yang berbeda-beda */
specialAttackName('Swordsman', 'Heavy Slash').
specialAttackName('Archer', 'Twin Shot').
specialAttackName('Sorcerer', 'Void Explosion').

specialAttackName('Swordmaster', 'Infinity Edge').
specialAttackName('Mercenary', 'Gigantic Bomb').
specialAttackName('Bowmaster', 'Arrow Barrage').
specialAttackName('Acrobat', 'Spiral Edge').
specialAttackName('Elemental Lord', 'Fiery Vortex').
specialAttackName('Force User', 'Meteor Storm').

specialAttackName('Gladiator', 'Hyper Drive').
specialAttackName('Lunar Knight', 'Moon Blader').
specialAttackName('Barbarian', 'Overtaker').
specialAttackName('Destroyer', 'Assault Crash').
specialAttackName('Artillery', 'Cannonade').
specialAttackName('Sniper', 'Sliding Shot').
specialAttackName('Windwalker', 'Flash Kick').
specialAttackName('Tempest', 'Hurricane Uppercut').
specialAttackName('Saleana', 'Flame Burst').
specialAttackName('Elestra', 'Ice Cyclone').
specialAttackName('Chaos Mage', 'Gravity Rush').
specialAttackName('War Mage', 'Laser Ray').

/*Special Attack Damage*/
specialAttackDamage('Swordsman', 20).
specialAttackDamage('Archer', 20).
specialAttackDamage('Sorcerer', 20).

specialAttackDamage(CurrentJob, SpecialAttDmg) :-
    jobAdvancement(PrevJob, CurrentJob),
    specialAttackDamage(PrevJob, TempSpclAttDmg),
    SpecialAttDmg is (2*TempSpclAttDmg),
    !.



/* KALAU SEMPAT, IMPLEMENTASIIN JOB ADVANCEMENT DAN KENAIKAN STATNYA */

/*statusAdvJob(swordsMaster, Attack, Defense, HP) :- 
    baseAttack(swordsman, BaseAtt),
    baseDefense(swordsman, BaseDef),
    baseHealth(swordsman, BaseHP),
    Attack is (BaseAtt*2),
    Defense is (BaseDef*1.2),
    HP is (BaseHP*1.2).
statusAdvJob(mercenary, Attack, Defense, HP) :- 
    baseAttack(swordsman, BaseAtt),
    baseDefense(swordsman, BaseDef),
    baseHealth(swordsman, BaseHP),
    Attack is (BaseAtt*1.5),
    Defense is (BaseDef*1.7),
    HP is (BaseHP*1.7).
statusAdvJob(bowMaster, Attack, Defense, HP) :- 
    baseAttack(archer, BaseAtt),
    baseDefense(archer, BaseDef),
    baseHealth(archer, BaseHP),
    Attack is (BaseAtt*2),
    Defense is (BaseDef*1.2),
    HP is (BaseHP*1.2).
statusAdvJob(acrobat, Attack, Defense, HP) :- 
    baseAttack(archer, BaseAtt),
    baseDefense(archer, BaseDef),
    baseHealth(archer, BaseHP),
    Attack is (BaseAtt*2),
    Defense is (BaseDef*1.2),
    HP is (BaseHP*1.2).
statusAdvJob(forceUser, Attack, Defense, HP) :- 
    baseAttack(sorcerer, BaseAtt),
    baseDefense(sorcerer, BaseDef),
    baseHealth(sorcerer, BaseHP),
    Attack is (BaseAtt*2),
    Defense is (BaseDef*1.2),
    HP is (BaseHP*1.2).
statusAdvJob(elementalLord, Attack, Defense, HP) :- 
    baseAttack(sorcerer, BaseAtt),
    baseDefense(sorcerer, BaseDef),
    baseHealth(sorcerer, BaseHP),
    Attack is (BaseAtt*2),
    Defense is (BaseDef*1.2),
    HP is (BaseHP*1.2). */