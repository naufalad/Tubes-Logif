/* Bismillah */



/* Pengaturan predikat dinamik */
:- dynamic(location/3).
:- dynamic(player/8).
:- dynamic(coordinate/2).
:- dynamic(playersHealth/1).
:- dynamic(playersWeapon/1).
:- dynamic(playersArmor/1).
:- dynamic(playersAmmo/1).
:- dynamic(playersMaxInventory/1).
:- dynamic(playersItem/1).
:- dynamic(remainingEnemy/1).
:- dynamic(enemy/5).
:- dynamic(enemysHealth/1).
:- dynamic(enemysWeapon/1).
:- dynamic(weapon/3).
:- dynamic(armor/3).
:- dynamic(medicine/3).
:- dynamic(item/2).
:- dynamic(ammo/3).
:- dynamic(game_started/0).

/*status pemain awal*/
init :-
    /*pengaturan awal pemain*/
    /*janlup random position*/
    /*10X10*/
	asserta(game_started),
    random(1,10,X),
    random(1,10,Y), 
    asserta(coordinate(X,Y)),
    asserta(playersHealth(100)),
    asserta(playersWeapon(hand)),
    asserta(playersArmor(0)),
    asserta(playersAmmo(0)),
    asserta(playersMaxInventory(0)),
    asserta(playersItem([])),

    /*status enemy*/
    asserta(enemysHealth(50)),
    asserta(enemysWeapon(pistolG2Combat)),
    /*weapon*/
    asserta(weapon(1,hand, 5)),
    asserta(weapon(2,bambuRuncing,50)),
    asserta(weapon(3,senapanSSX, 30)),
    asserta(weapon(4, pistolG2Combat, 20)),

    /*armor*/
    asserta(armor(1,helmet, 20)),
    asserta(armor(2,kevlar, 50)),
    asserta(armor(3,caping, 15)),
    asserta(armor(4,batik, 25)),

    /*medicine*/
    asserta(medicine(1,jamu, 20)),
    asserta(medicine(2,minuman, 30)),
    asserta(medicine(3,airAmerta, 100)),
    asserta(medicine(4,airPutih, 10)),

    /*item*/
    asserta(item(1,bandage)),
    asserta(item(2,sportDrink)),
    asserta(item(3,bomb)),
    asserta(item(4,scope)),


    /*init player*/
    init_player,
    init_enemy(10),
    asserta(remainingEnemy(10)),
    init_every_item.
	
init_player:-
    playersHealth(Health),
    playersWeapon(Weapon),
    playersItem(ItemList),
    playersAmmo(Ammo),
    playersMaxInventory(MaxInventory),
	coordinate(X,Y),
	playersArmor(Armor),
	asserta(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)), !,
	asserta(location(X,Y,player)).

get_coordinates(X,Y):-
	player(X,Y,_,_,_,_,_,_).
		
get_health(Health):-
	player(_,_,Health,_,_,_,_,_).
	
get_weapon(Weapon):-
	player(_,_,_,Weapon,_,_,_,_).
	
get_ammo(Ammo):-
	player(_,_,_,_,Ammo,_,_,_).

get_itemlist(ItemList):-
	player(_,_,_,_,_,ItemList,_,_).

get_maxinventory(MaxInventory):-
	player(_,_,_,_,_,_,MaxInventory,_).
  
get_armor(Armor):-
	player(_,_,_,_,_,_,_,Armor).
	
	
start :- write('Welcome to the battlefield!'), nl,
		 write('You have been chosen as one of the lucky contestants.'),nl,
		 write('Be the last man standing and you will be remembered as one of the victors.'), nl,
		 nl, help,
        init.
         
help :- write('Available commands : '), nl,
		tab(4), write('start. -- start the game!'), nl,
		tab(4), write('help. -- show available commands'), nl,
		tab(4), write('quit. -- quit the game'), nl,
		tab(4), write('look. -- look around you'), nl,
		tab(4), write('w. a. s. d. -- move'), nl,
		tab(4), write('map. -- look at the map and detect enemies'), nl,
		tab(4), write('take(Object). -- pick up an object'), nl,
		tab(4), write('drop(Object). -- drop an object'), nl,
		tab(4), write('use(Object). -- use an object'), nl,
		tab(4), write('attack. -- attack enemy that crosses your path'), nl,
		tab(4), write('status. -- show your status'), nl,
		tab(4), write('save(Filename). -- save your game'), nl,
		tab(4), write('loadGame(Filename). -- load previously saved game'), nl,
		nl,
		write('Legends : '), nl,
		write('W = weapon'), nl,
		write('A = armor'), nl,
		write('M = medicine'), nl,
		write('O = ammo'), nl,
		write('I = item'), nl,
		write('E = enemy'), nl,
		write('- = accessible'), nl,
		write('X = inaccessible'), nl.
        
quit :- 
	retractall(location(_,_,_)), 
    retractall(playersHealth(_)), retractall(playersWeapon(_)), retractall(playersAmmo(_)),
    retractall(playersArmor(_)), retractall(playersMaxInventory(_,_)),
    retractall(playersItem(_)), retractall(enemy(_,_,_,_,_)),
    retractall(remaininingEnemy(_)),
    write('You have left the battlefield.'),nl,
    write('Thank you for playing!'),nl,nl,
    write('Credit(s) to :'),nl,
    write('Naufal Aditya Dirgandhavi/13517064'),nl,
    write('Mahanti Indah Rahajeng/13517085'),nl,
    write('Annisa Putri Dinanti/13517121'),nl,
    write('Syaiful Anwar/13517139'),nl,nl,
	retract(game_started),
    halt.

status :- 
		  get_health(Health), write('Health: '), write(Health), nl,
		  get_armor(Armor), write('Armor: '), write(Armor), nl,
          get_weapon(Weapon), write('Weapon: '), write(Weapon), nl,
          get_ammo(Ammo), write('Ammo: '), write(Ammo), nl,
          get_itemlist(ItemList), write('Item list: '), write(ItemList), nl,
          remainingEnemy(X), write('Remaining Enemy: '), write(X),nl.

init_enemy(0) :- !.
init_enemy(N) :- generate_enemy(N), M is N-1, init_enemy(M).

generate_enemy(EnemyID) :-
	random(1, 10, X), random(1, 10, Y),
	enemysHealth(Health), enemysWeapon(Weapon),
	asserta(enemy(EnemyID, X, Y, Health, Weapon)).

take(Object):-
	take_item(Object), nl,
	format('You have picked ~w !',[Object]),nl,!.
take(_):-
	nl,write('Gaada brok'),nl, fail.
/* player take the item to ItemList */
take_item(Object):-
	game_started,
	player(X,Y,_,_,_,_,_,_),
	location(X,Y,Object),
	add_item(Object),
	retract(location(X,Y,Object)),!.
add_item(Item):-
    retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
    append([Item],ItemList,NewItemList),
	asserta(player(X,Y,Health,Weapon,Ammo,NewItemList,MaxInventory,Armor)).
init_every_item :-
	init_all_weapon, init_all_medicine, init_all_armor, init_all_item, init_all_ammo,!.

/* Initialize map with weapons */
init_all_weapon :-
	init_weapon(15).

init_weapon(0) :- !.
init_weapon(N) :-
    random_weapon,
	M is N -1,
	init_weapon(M).
random_weapon :-
	random(2, 4, N), weapon(N, A, _),
	random(1, 10, X), random(1, 10, Y),
	asserta(location(X, Y, A)).

init_all_medicine :-
	init_medicine(10).

init_medicine(0) :- !.
init_medicine(N) :-
    random_medicine,
	M is N -1,
	init_medicine(M).
random_medicine :-
	random(1, 4, N), medicine(N, A, _),
	random(1, 10, X), random(1, 10, Y),
	asserta(location(X, Y, A)).

init_all_armor :-
	init_armor(10).

init_armor(0) :- !.
init_armor(N) :-
    random_armor,
	M is N -1,
	init_armor(M).
random_armor :-
	random(1, 4, N), armor(N, A, _),
	random(1, 10, X), random(1, 10, Y),
	asserta(location(X, Y, A)).

init_all_item :-
	init_item(10).

init_item(0) :- !.
init_item(N) :-
    random_item,
	M is N -1,
	init_item(M).
random_item :-
	random(1, 5, N), asserta(item(N, A)),
	random(1, 10, X), random(1, 10, Y),
	asserta(location(X, Y, A)).

init_all_ammo :-
	init_ammo(10).

init_ammo(0) :- !.
init_ammo(N) :-
    random_ammo,
	M is N -1,
	init_ammo(M).
random_ammo :-
	random(10, 50, N), 
	random(1, 10, X), random(1, 10, Y), asserta(ammo(X,Y,N)),
	asserta(location(X, Y, ammo)).
	/* masih ga yakin*/

drop(Object) :-
	get_coordinates(X,Y),
	get_itemlist(ItemList),
	member(Object,ItemList),
	del_item(Object),
	asserta(location(X,Y,Object)),
	nl ,format('berhasil menjatuhkan ~w!',[Object]),nl,!.

drop(Object) :-
	nl ,format('gapunya ~w brok!',[Object]),nl.
	
del_item(Item):-
    retract(player(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor))),
    delete_one(Item,ItemList,NewItemList),
	asserta(player(player(X,Y,Health,Weapon,Ammo,NewItemList,MaxInventory, Armor))).

delete_one(_, [], []).
delete_one(Term, [Term|Tail], Tail) :- !.
delete_one(Term, [Head|Tail], [Head|Result]) :-
delete_one(Term, Tail, Result).



use(Object) :-
	get_itemlist(ItemList),
	member(Object,ItemList),
	del_item(Object),
	use_objecttype(Object),
	nl ,format('berhasil memakai ~w!',[Object]),nl,!.
use(Object) :-
	nl ,format('gapunya ~w brok!',[Object]),nl.
/*weapon*/
use_objecttype(Object) :-
	weapon(_,Object,_),
	playersWeapon(Weapon),
	add_item(Weapon),
	asserta(playersWeapon(Object)).
/*armor*/
use_objecttype(Object) :-
	armor(_,Object,Y),
	playersArmor(X),
	X1 is X + Y,
	X1 > 50,!, X1 is 50,
	asserta(playersArmor(X1)).
use_objecttype(Object) :-
	armor(_,Object,Y),
	playersArmor(X),
	X1 is X + Y,
	asserta(playersArmor(X1)).
/*medicine*/
use_objecttype(Object) :-
	medicine(_,Object,Y),
	playersHealth(X),
	X1 is X + Y,
	X1>100, X1 is 100,
	asserta(playersHealth(X1)).
use_objecttype(Object) :-
	medicine(_,Object,Y),
	playersHealth(X),
	X1 is X + Y,
	asserta(playersHealth(X1)).
/*ammo*/	
use_objecttype(Object) :-
	Object == 'ammo',!,
	ammo(_,_,Y),
	playersAmmo(X),
	X1 is X + Y,
	asserta(playersAmmo(X1)).
/*item*/
use_objecttype(Object) :-
	item(_,Object),
	Object = bandage,!,
	Y is 25,
	playersHealth(X),
	X1 is X + Y,
	X1>100, X1 is 100,
	asserta(playersHealth(X1)).
use_objecttype(Object) :-
	item(_,Object),
	Object = bandage,!,
	Y is 25,
	playersHealth(X),
	X1 is X + Y,
	asserta(playersHealth(X1)).

use_objecttype(Object) :-
	item(_,Object),
	Object = sportDrink,!,
	Y is 10,
	playersHealth(X),
	X1 is X + Y,
	X1>100, X1 is 100,
	asserta(playersHealth(X1)).
use_objecttype(Object) :-
	item(_,Object),
	Object = sportDrink,!,
	Y is 10,
	playersHealth(X),
	X1 is X + Y,
	asserta(playersHealth(X1)).
/*bomb, ntar bakalan attack 50
use_objecttype(bomb) :-
	item(_,Object),
	Object is bandage,
	Y is 25,
	playersHealth(X),
	X1 is X + Y,
	X1>100, X1 is 100,
	asserta(playersHealth(X1)).
*/
use_objecttype(Object) :-
	item(_,Object),
	Object = scope,!,
	weapon(_,_,X),
	Y is 10,
	X1 is X + Y,
	asserta(weapon(_,_,X1)).
/* kondisi menang*/
/* kondisi kalah */

w :-
	get_coordinates(X,Y),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	Y1 is Y-1,
	asserta(player(X,Y1,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),!.
a :-
	get_coordinates(X,Y),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	X1 is X-1,
	asserta(player(X1,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),!.
s :-
	get_coordinates(X,Y),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	Y1 is Y+1,
	asserta(player(X,Y1,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),!.
d :-
	get_coordinates(X,Y),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	X1 is X+1,
	asserta(player(X1,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),!.

look :-
	get_coordinates(X,Y),
	XMin is X-1,
	XMax is X+1,
	YMin is Y-1,
	YMax is Y+1,
	forall(between(YMin,YMax,J), (
		forall(between(XMin,XMax,I), (
			printObject(I,J)
		)),
		nl
	)),
!.

printObject(X,_) :-
	X<1, write('#').
printObject(X,_) :-
	X>10, write('#').
printObject(_,Y) :-
	Y<1, write('#').
printObject(_,Y) :-
	Y>10, write('#').
printObject(X,Y):-
	enemy(_,X,Y,_,_),!,
	write('E').
printObject(X,Y):-
	location(X,Y,Object),
	medicine(_,Object,_),!,
	write('M').
printObject(X,Y):-
	location(X,Y,Object),
	weapon(_,Object,_),!,
	write('W').
printObject(X,Y):-
	location(X,Y,Object),
	armor(_,Object,_),!,
	write('A').
printObject(X,Y):-
	location(X,Y,Object),
	item(_,Object),!,
	write('I').
printObject(X,Y):-
	ammo(X,Y,_),!,
	write('O').
printObject(X,Y) :-
	player(X,Y,_,_,_,_,_,_),!,
	write('P').
printObject(_,_) :- write('-').