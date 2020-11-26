:- dynamic(inventory/7).
:- dynamic(item/6).

maxInventory(100).

cekInventory(SumMany) :-
    findall(Name, inventory(_,Name,_,_,_,_,_), List),
    length(List,SumMany).    

isFull :-
    cekInventory(SumMany),
    SumMany == 100.

addItem(_) :-
    cekInventory(SumMany),
    maxInventory(Max),
    SumMany >= Max,
    write('Inventory kamu Penuh.'),!,fail.

addItem(ID) :-
    inventory(ID, Name, Type, Level, Damage, Effect, Many),
    TempMany is (Many+1),
    retract(inventory(ID,_,_,_,_,_,Many)),
    asserta(inventory(ID, Name, Type, Level, Damage, Effect, TempMany)),!.

addItem(ID) :-
    item(ID, Name, Type, Level, Damage, Effect), Many is 1,
    asserta(inventory(ID, Name, Type, Level, Damage, Effect, Many)),!.

delItem(ID) :-
    \+inventory(ID,_,_,_,_,_,_),
    write('Tidak ada Item tersebut di inventory kamu.'),!,fail.

delItem(ID) :-
    inventory(ID, Name, Type, Level, Damage, Effect, Many),
    Many >= 2,
    TempMany is (Many-1),
    retract(inventory(ID,_,_,_,_,_,Many)),
    asserta(inventory(ID, Name, Type, Level, Damage, Effect, TempMany)),!.

delItem(ID) :-
    retract(inventory(ID,_,_,_,_,_)),!.

makeListItem(ListName,ListType,ListLevel,ListDamage,ListEffect, ListMany) :-
    findall(Name, inventory(_,Name,_,_,_,_,_), ListName),
    findall(Type, inventory(_,_,Type,_,_,_,_), ListType),
    findall(Level, inventory(_,_,_,Level,_,_,_), ListLevel),
    findall(Damage, inventory(_,_,_,_,Damage,_,_), ListDamage),
    findall(Effect, inventory(_,_,_,_,_,Effect,_), ListEffect),
    findall(Many, inventory(_,_,_,_,_,_,Many), ListMany).

stt([],[],[],[],[],[]).
stt([A|U],[B|V],[C|W],[D|X],[E|Y],[F|Z]) :-
    write(A),nl,
    write('Type: '),
    write(B),nl,
    write('Level: '),
    write(C),nl,
    write('Damage: '),
    write(D),nl,
    write('Effect: '),
    write(E),nl,
    write('Available: '),
    write(F),nl,nl,
    stt(U,V,W,X,Y,Z).

inventory :-
    init(_),
    player(Username), nl,
    write('Your name is '), write(Username), write('.'), nl, nl,
    makeListItem(ListName,ListType,ListLevel,ListDamage,ListEffect,ListMany),
    write('Your Item:'),nl,nl,
    stt(ListName,ListType,ListLevel,ListDamage,ListEffect,ListMany).
