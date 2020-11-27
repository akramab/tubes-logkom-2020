:- dynamic(currentItemsInInventory/1).
:- dynamic(currentInventory/1).

maxInventory(100).
currentInventory([]).

isFull :-
    cekInventory(Limit),
    Limit == 100.

addItem(_) :-
    cekInventory(Limit),
    maxInventory(Max),
    Limit == Max,
    write('Inventory kamu Penuh.'),!,fail.

addItem(NewItem) :-
    currentInventory(CurrentInventory),
    append(CurrentInventory,[NewItem],Inventory),
    retractall(currentInventory(_)),
    asserta(currentInventory(Inventory)),!.

addItem(_,0) :- !.
addItem(NewItem,Amount) :-
    addItem(NewItem),
    AmountNow is (Amount + 1),
    addItem(NewItem,AmountNow).

delItem(Item) :-
    currentInventory(CurrentInventory),
    append(CurrentInventory,[Item],Inventory),
    retractall(currentInventory(_)),
    asserta(currentInventory(Inventory)),!.

delItem(_) :- !.
delItem(Item,Amount) :-
    delItem(Item),
    AmountNow is (Amount - 1),
    delItem(Item,AmountNow).

countItem(_,[],0).
countItem(H,[H|T],N) :- countItem(H,T,N1), N is 1 + N1, !.
countItem(H,[_|T],N) :- countItem(H,T,N1), N is N1, !.

countInventoryItem([],0).
countInventoryItem([_|T],NumberOfItems) :-
    countInventoryItem(T,Temp),
    NumberOfItems is (1+Temp),!.

numberOfItemsInventory(NumberOfItems) :-
    currentInventory(Inventory),
    countInventoryItem(Inventory,NumberOfItems),!.

keyItemInventory(Inventory) :-
    sort(Inventory).

printInventory([]) :- !.
printInventory([H|T]) :-
    currentInventory(Inventory),
    countItem(H,Inventory,ItemQty),
    format('~w ~wx\n',[H,ItemQty]),
    printInventory(T),!.

showInventory :-
    currentInventory(Inventory),
    (Inventory = [],
    write('Your inventory is empty\n'),!
    ;keyItemInventory(Inventory),
    printInventory(Inventory), 
    maxInventory(MaxInventory),
    numberOfItemsInventory(CurrentNumberOfItems),
    format('Inventory Capacity: ~w/~w\n',[CurrentNumberOfItems,MaxInventory]),!
    ).

useItemFromInventory(ItemName) :- 
    currentInventory(Inventory),
    \+ member(ItemName,Inventory), !, format('You don\'t have ~w in your inventory!', [ItemName]), fail. 
useItemFromInventory(ItemName) :-
    currentInventory(Inventory),
    retractall(currentInventory(_)),

    select(ItemName,Inventory,InventoryNow),
    asserta(currentInventory(InventoryNow)),!.
