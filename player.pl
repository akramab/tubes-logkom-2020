:- dynamic(inventory/1). 

/* Kode program masih akan diubah dan dikembangkan. Ini masih tahap mencoba. Sumber 1 : https://github.com/littlemight/TubesLogkom-Tokemon */
/* Sumber 2 : https://github.com/stanleyyoga123/Tubes-Logif */


initPlayer :-
    height(H),
    width(W),
    random(1, H, YPlayer),
    random(1, W, XPlayer),
    asserta(posPlayer(XPlayer, YPlayer)),
   
maxInventory(100).

cekPanjang(Length) :-
    findall(Name, inventory(_,Name,_,_,_,_,_,_,_,_), List),
    length(List,Length).    

isFull :-
    cekPanjang(Length),
    Length == 100.

addItems(_) :-
    cekPanjang(Length),
    maxInventory(Max),
    Length >= Max,
    write('Your Inventory is full.'),
    !,fail.
