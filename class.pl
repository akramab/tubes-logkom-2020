:- dynamic(level/2).

/* daftar class dalam game */
class(swordsman).
class(archer).
class(sorcerer).

/* level awal tiap class */
level(swordsman, 1).
level(archer, 1).
level(sorcerer, 1).

/* stat attack default */
attack(swordsman,10).
attack(archer,15).
attack(sorcerer, 15).

/*stat defense default */
defense(swordsman,15).
defense(archer,15).
defense(sorcerer,15).