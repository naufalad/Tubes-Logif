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
:- dynamic(time/1).
:- dynamic(kiriatas/2).
:- dynamic(kananatas/2).
:- dynamic(kiribawah/2).
:- dynamic(kananbawah/2).
:- dynamic(terrain/3).

/*status pemain awal*/
init :-
    /*pengaturan awal pemain*/
    /*game_started belom kepake, kedepannya bakal kepake buat validasi game udh mulai apa belom*/
	/*10X10*/
	asserta(time(0)),
	asserta(game_started),!,
    random(1,10,X),
    random(1,10,Y), 
    asserta(coordinate(X,Y)),!,
    asserta(playersHealth(100)),!,
    asserta(playersWeapon(hand)),!,
    asserta(playersArmor(0)),!,
    asserta(playersAmmo(0)),!,
    asserta(playersMaxInventory(3)),!,
    asserta(playersItem([])),!,

    /*status enemy*/
    asserta(enemysHealth(50)),!,
    asserta(enemysWeapon(pistolG2Combat)),!,
    /*weapon*/
    asserta(weapon(1,hand, 5)),!,
    asserta(weapon(2,bambuRuncing,50)),!,
    asserta(weapon(3,senapanSSX, 30)),!,
    asserta(weapon(4, pistolG2Combat, 20)),!,

    /*armor*/
    asserta(armor(1,helmet, 20)),!,
    asserta(armor(2,kevlar, 50)),!,
    asserta(armor(3,caping, 15)),!,
    asserta(armor(4,batik, 25)),!,

    /*medicine*/
    asserta(medicine(1,jamu, 20)),!,
    asserta(medicine(2,minuman, 30)),!,
    asserta(medicine(3,airAmerta, 100)),!,
    asserta(medicine(4,airPutih, 10)),!,

    /*item*/
    asserta(item(1,bandage)),!,
    asserta(item(2,sportDrink)),!,
    asserta(item(3,bomb)),!,
	asserta(item(4,scope)),!,
	asserta(item(5,smallBag)),!,
	asserta(item(6,mediumBag)),!,
	asserta(item(7,bigBag)),!,


    /*init player*/
    init_player,
    init_enemy(10),
    asserta(remainingEnemy(10)),!,
    init_every_item, init_terrain, init_zone.
	
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

get_remainingEnemy(Enemy) :-
	remainingEnemy(Enemy).

get_time(N) :- time(N).

init_zone:-
	asserta(kiriatas(1,1)),!,
	asserta(kiribawah(1,10)),!,
	asserta(kananatas(10,1)),!,
	asserta(kananbawah(10,10)),!,
	forall(between(1,10,J), (
		forall(between(1,10,I), (
			asserta(location(I,J,safezone)),!
		)),
		nl
	)),
!.

start :- 
	init,nl, write('Welcome to...'),nl,
	write('#########################################################################################################'),nl,
	write('#        ##       ######  #####       ###    ##        ##    ####    ####  #######  #####  #####  #######'),nl,
	write('####  #####  ####  ####    ####  ####  ###  ######  ######  ####  ##  ###   ######  ####    ####  #######'),nl,
	write('####  #####  ####  ###  ##  ###  ####  ###  ######  ######  ###  ####  ##    #####  ###  ##  ###  #######'),nl,
	write('####  #####  ###   ##  ####  ##  ####  ###  ######  ######  ###  ####  ##  ##  ###  ##  ####  ##  #######'),nl,
	write('####  #####      ####  ####  ##  ####  ###  ######  ######  ###  ####  ##  ###  ##  ##  ####  ##  #######'),nl,
	write('####  #####  ####  ##        ##  ####  ###  ######  ######  ###  ####  ##  ####  #  ##        ##  #######'),nl,
	write('####  #####  ####  ##  ####  ##  ####  ###  ######  ######  ###  ####  ##  #####    ##  ####  ##  #######'),nl,
	write('####  #####  ####  ##  ####  ##  ####  ###  ######  ######  ####  ##  ###  ######   ##  ####  ##  #######'),nl,
	write('####  #####  ####  ##  ####  ##       ###    #####  #####    ####    ####  #######  ##  ####  ##        #'),nl,
	write('#########################################################################################################'),nl,
	write('########################################'),nl,
   	write('#       ###  ####  ##      #####      ##'),nl,
	write('#  ####  ##  ####  ##  ###  ###   ##   #'),nl,
	write('#  ####  ##  ####  ##  ####  ##  ####  #'),nl,
	write('#  ####  ##  ####  ##  ###  ###  #######'),nl,
	write('#       ###  ####  ##      ####  #######'),nl,
	write('#  ########  ####  ##  ###  ###  ###   #'),nl,
	write('#  ########  ####  ##  ####  ##  ####  #'),nl,
	write('#  ########   ##   ##  ###  ###   ##   #'),nl,
	write('#  #########      ###      #####      ##'),nl,
	write('########################################'),nl,nl,
		write('Made by :'),nl,nl,
		write('Kelompok : Dah, Itu aja.'),nl,
		write('Naufal Aditya Dirgandhavi/13517064'),nl,
		write('Mahanti Indah Rahajeng/13517085'),nl,
		write('Anissa Putri Dinanti/13517121'),nl,
		write('Syaiful Anwar/13517139'),nl,nl,
		 write('Welcome to the battlefield!'), nl,
		 write('You have been chosen as one of the lucky contestants.'),nl,
		 write('Be the last man standing and you will be remembered as one of the victors.'), nl,
		 nl, help.
         
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
		write('# = inaccessible'), nl,
		write('X = dead zone').
        
quit :- 
	retractall(location(_,_,_)),retractall(player(_,_,_,_,_,_,_,_)),
    retractall(playersHealth(_)), retractall(playersWeapon(_)), retractall(playersAmmo(_)),
    retractall(playersArmor(_)), retractall(playersMaxInventory(_,_)),
    retractall(playersItem(_)), retractall(enemy(_,_,_,_,_)),
    retractall(remaininingEnemy(_)), retractall(coordinate(_,_)),
    retractall(enemysHealth(_)), retractall(enemysWeapon(_)),
    retractall(weapon(_,_,_)), retractall(armor(_,_,_)), retractall(medicine(_,_,_)),
    retractall(item(_,_)), retractall(ammo(_,_,_)), retractall(time(_)),
    write('You have left the battlefield.'),nl,
    write('Thank you for playing!'),nl,nl,
	retract(game_started),
    halt.

status :- 
		  get_health(Health), write('Health: '), write(Health), nl,
		  get_armor(Armor), write('Armor: '), write(Armor), nl,
          get_weapon(Weapon), write('Weapon: '), write(Weapon), nl,
		  get_ammo(Ammo), write('Ammo: '), write(Ammo), nl,
		  get_maxinventory(A), write('Max Inventory : '), write(A),nl,
		  get_itemlist(ItemList), write('Item list: '), write(ItemList), nl,
		  get_coordinates(X,Y), write('Location : '), write(X), write(','), write(Y),nl,
		  remainingEnemy(Z), write('Remaining Enemy: '), write(Z),nl,
		  time(N), write('Time played:'), write(N	),nl.


init_enemy(0) :- !.
init_enemy(N) :- generate_enemy(N), M is N-1, init_enemy(M).

generate_enemy(EnemyID) :-
	random(1, 10, X), random(1, 10, Y),
	enemysHealth(Health), enemysWeapon(Weapon),
	asserta(enemy(EnemyID, X, Y, Health, Weapon)),
	asserta(location(X,Y,EnemyID)).

take(Object):-
	get_itemlist(ItemList), get_maxinventory(MaxInventory), count(ItemList,N),
	N < MaxInventory,!,
	take_item(Object), nl,
	format('Success! ~w added.',[Object]),nl,!.
take(Object):-
	nl,
	player(X,Y,_,_,_,_,_,_),
	\+location(X,Y,Object),
	format('There\'s no ~w here.',[Object]),nl, fail.
take(_):-
	get_itemlist(ItemList), get_maxinventory(MaxInventory), count(ItemList,N),
	N =:= MaxInventory,!,
	write('Your bag is full, you can use or drop some to add.').

count([],0).
count([_|Tail], N) :- count(Tail, N1), N is N1 + 1.
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
	asserta(player(X,Y,Health,Weapon,Ammo,NewItemList,MaxInventory,Armor)),!.
init_every_item :-
	init_all_weapon, init_all_medicine, init_all_armor, init_all_item, init_all_ammo,!.

/* Initialize map with weapons */
init_all_weapon :-
	init_weapon(10).

init_weapon(0) :- !.
init_weapon(N) :-
    random_weapon,
	M is N -1,
	init_weapon(M).
random_weapon :-
	random(2, 4, N), weapon(N, A, _),
	random(1, 10, X), random(1, 10, Y),
	asserta(location(X, Y, A)),!.

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
	asserta(location(X, Y, A)),!.

init_all_armor :-
	init_armor(5).

init_armor(0) :- !.
init_armor(N) :-
    random_armor,
	M is N -1,
	init_armor(M).
random_armor :-
	random(1, 4, N), armor(N, A, _),
	random(1, 10, X), random(1, 10, Y),
	asserta(location(X, Y, A)),!.

init_all_item :-
	init_item(12).

init_item(0) :- !.
init_item(N) :-
    random_item,
	M is N -1,
	init_item(M).
random_item :-
	random(1, 7, N), asserta(item(N, A)),!,
	random(1, 10, X), random(1, 10, Y),
	asserta(location(X, Y, A)),!.

init_all_ammo :-
	init_ammo(5).

init_ammo(0) :- !.
init_ammo(N) :-
    random_ammo,
	M is N -1,
	init_ammo(M).
random_ammo :-
	random(10, 50, N), 
	random(1, 10, X), random(1, 10, Y), asserta(ammo(X,Y,N)),
	asserta(location(X, Y, ammo)),!.
	/* masih ga yakin*/

drop(Object) :-
	get_coordinates(X,Y),
	get_itemlist(ItemList),
	member(Object,ItemList),!,
	del_item(Object),
	asserta(location(X,Y,Object)),!,
	nl ,format('Success! ~w dropped.',[Object]),nl,!.

drop(Object) :-
	nl ,format('You don\'t have any ~w.',[Object]),nl.
	
del_item(Item):-
    retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
    delete_one(Item,ItemList,NewItemList),
	asserta(player(X,Y,Health,Weapon,Ammo,NewItemList,MaxInventory, Armor)),!.

delete_one(_, [], []).
delete_one(Term, [Term|Tail], Tail) :- !.
delete_one(Term, [Head|Tail], [Head|Result]) :-
delete_one(Term, Tail, Result).



use(Object) :-
	get_itemlist(ItemList),
	member(Object,ItemList),!,
	del_item(Object),
	use_objecttype(Object),
	nl ,format('Success! ~w equipped.',[Object]),nl,!.
use(Object) :-
	nl ,format('You don\'t have any ~w.',[Object]),nl.
/*weapon*/
use_objecttype(Object) :-
	weapon(_,Object,_),!,
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	/*add_item(Weapon),*/
	asserta(player(X,Y,Health,Object,Ammo,ItemList,MaxInventory, Armor)),!.
/*armor*/
use_objecttype(Object) :-
	armor(_,Object,Z),!,
	X1 is Armor + Z,
	X1 > 50,!, X1 is 50,
	retract(playersArmor(Armor)),
	asserta(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, X1)),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	asserta(playersArmor(X1)),!.
use_objecttype(Object) :-
	armor(_,Object,Z),!,
	X1 is Armor + Z,
	retract(playersArmor(Armor)),
	asserta(playersArmor(X1)),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	asserta(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, X1)),!.

/*medicine*/
use_objecttype(Object) :-
	medicine(_,Object,Z),
	get_health(Health),
	X1 is Health + Z,
	X1>100, X1 is 100,
	retract(playersHealth(Health)),
	asserta(playersHealth(X1)),!,
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	asserta(player(X,Y,X1,Weapon,Ammo,ItemList,MaxInventory, Armor)),!.

use_objecttype(Object) :-
	medicine(_,Object,Z),
	get_health(Health),
	X1 is Health + Z,
	retract(playersHealth(Health)),
	asserta(playersHealth(X1)),!,
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	asserta(player(X,Y,X1,Weapon,Ammo,ItemList,MaxInventory, Armor)),!.

/*ammo*/	
use_objecttype(ammo) :-
	ammo(_,_,Z),
	retract(playersAmmo(Ammo)),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	X1 is Z + Ammo,
	asserta(player(X,Y,Health,Weapon,X1,ItemList,MaxInventory, Armor)),!,
	asserta(playersAmmo(X1)),!.
/*item*/
use_objecttype(bandage) :-
	Z is 25,
	retract(playersHealth(Health)),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	X1 is Health + Z,
	X1>100, X1 is 100,
	asserta(player(X,Y,X1,Weapon,Ammo,ItemList,MaxInventory, Armor)),!,
	asserta(playersHealth(X1)),!.
use_objecttype(bandage) :-
	Z is 25,
	retract(playersHealth(Health)),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	X1 is Z + Health,
	asserta(player(X,Y,X1,Weapon,Ammo,ItemList,MaxInventory, Armor)),!,
	asserta(playersHealth(X1)),!.

use_objecttype(sportDrink) :-
	Z is 10,
	retract(playersHealth(Health)),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	X1 is Z + Health,
	X1>100, X1 is 100,
	asserta(player(X,Y,X1,Weapon,Ammo,ItemList,MaxInventory, Armor)),!,
	asserta(playersHealth(X1)),!.
use_objecttype(sportDrink) :-
	Z is 10,
	retract(playersHealth(Health)),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	X1 is Z + Health,
	asserta(player(X,Y,X1,Weapon,Ammo,ItemList,MaxInventory, Armor)),!,
	asserta(playersHealth(X1)),!.
/*bomb, ntar bakalan attack 50
use_objecttype(bomb) :-
	item(_,Object),
	Object == 'bomb',
	Y is 25,
	playersHealth(X),
	X1 is X + Y,
	X1>100, X1 is 100,
	asserta(playersHealth(X1)).
*/
use_objecttype(scope) :-
	retract(weapon(No, Weapon, Damage)),
	Y is 10,
	X1 is Damage + Y,
	asserta(weapon(No, Weapon, X1)),!.

use_objecttype(smallBag) :-
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	Z is 5,
	X1 is MaxInventory + Z,
	asserta(player(X,Y,Health,Weapon,Ammo,ItemList,X1, Armor)),!.
use_objecttype(mediumBag) :-
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	Z is 10,
	X1 is MaxInventory + Z,
	asserta(player(X,Y,Health,Weapon,Ammo,ItemList,X1, Armor)),!.
use_objecttype(bigBag) :-
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	Z is 12,
	X1 is MaxInventory + Z,
	asserta(player(X,Y,Health,Weapon,Ammo,ItemList,X1, Armor)),!.
/*jangan lupa ngecek tiap kali sekalian ngupdate*/
/* kondisi menang*/
win_con :- get_remainingEnemy(N), N =:= 0,!, write('Congratulations! You have win the game'), quit.
/* kondisi kalah */
lose_con :- get_health(Health), Health=:=0,!, write('Oh no! You have don\'t have any life, your name will always be remembered, comrades.'), quit.
w :-
	get_coordinates(_,Y),
	Y-1 < 1, write('You\'re already at the corner, nothing happened.'),!.
w :-
	get_coordinates(X,Y),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	retract(location(X,Y,player)), retract(time(N)),
	Y1 is Y-1, N1 is N+1,
	asserta(player(X,Y1,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),!,
	asserta(location(X,Y1,player)),!,asserta(time(N1)),!,
	updateMap,deadZoneEffect(X,Y1),!.
a :-
	get_coordinates(X,_),
	X-1 < 1, write('You\'re already at the corner, nothing happened.'),!.
a :-
	get_coordinates(X,Y),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	retract(location(X,Y,player)),retract(time(N)),
	X1 is X-1,N1 is N+1,
	asserta(player(X1,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),!,
	asserta(location(X1,Y,player)),!, asserta(time(N1)),!,
	updateMap,deadZoneEffect(X1,Y),!.
s :-
	get_coordinates(_,Y),
	Y+1 > 10, write('You\'re already at the corner, nothing happened.'),!.
s :-
	get_coordinates(X,Y),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	retract(location(X,Y,player)),retract(time(N)),
	Y1 is Y+1,N1 is N+1,
	asserta(player(X,Y1,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),!,
	asserta(location(X,Y1,player)),!, asserta(time(N1)),!,
	updateMap,deadZoneEffect(X,Y1),!.
d :-
	get_coordinates(X,_),
	X+1 > 10, write('You\'re already at the corner, nothing happened.'),!.
d :-
	get_coordinates(X,Y),
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	retract(location(X,Y,player)),retract(time(N)),
	X1 is X+1,N1 is N+1,
	asserta(player(X1,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),!,
	asserta(location(X1,Y,player)),!, asserta(time(N1)),!,
	updateMap,deadZoneEffect(X1,Y),!.

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
!, printItem(X,Y).

printObject(X,_) :-
	X<1, write('#').
printObject(X,_) :-
	X>10, write('#').
printObject(_,Y) :-
	Y<1, write('#').
printObject(_,Y) :-
	Y>10, write('#').
printObject(X,Y) :-
	location(X,Y,Object),
	Object == deadZone, write('X'),!.
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
	ammo(X,Y,_),!,
	write('O').
printObject(X,Y):-
	location(X,Y,Object),
	item(_,Object),
	Object\=player,Object\=safezone,Object\=deadZone, \+enemy(Object,_,_,_,_),!,
	write('I').
printObject(X,Y) :-
	player(X,Y,_,_,_,_,_,_),!,
	write('P').
printObject(_,_) :- write('-').

printItem(X,Y) :-
	location(X,Y,N), N == deadZone,!,
	write('You\'re at the dead zone, your health is decreased by 7. Get outta from there!'),nl,fail.
printItem(X,Y) :-
	location(X,Y,N),
	medicine(_,N,_),!,
	format('At the place where you stood, there\'s a ~w.',[N]),nl,fail.
printItem(X,Y) :-
	location(X,Y,N),
	weapon(_,N,_),!,
	format('At the place where you stood, there\'s a ~w.',[N]),nl,fail.
printItem(X,Y) :-
	location(X,Y,N),
	armor(_,N,_),!,
	format('At the place where you stood, there\'s a ~w.',[N]),nl,fail.
printItem(X,Y) :-
	location(X,Y,N),
	enemy(N,_,_,_,_),!,
	format('You see there\'s an enemy with code ~w, kill him before he could touch you!',[N]),nl,fail.
printItem(X,Y) :-	
	location(X,Y,N),
	N == 'ammo',!,
	format('At the place where you stood, there\'s a ~w.',[N]),nl,fail.
printItem(X,Y) :-
	location(X,Y,N),
	item(_,N),N\=player, \+enemy(N,_,_,_,_),N\=safezone,N\=deadZone,!,
	format('At the place where you stood, there\'s a ~w.',[N]),nl,fail.
printItem(_,_) :- !.
deadZoneEffect(X,Y) :- 
	location(X,Y,deadZone), retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	X1 is Health - 7, asserta(player(X,Y,X1,Weapon,Ammo,ItemList,MaxInventory, Armor)).
updateMap :-
	time(N), N mod 7 =:= 0,!,
	retract(kiriatas(A,B)), retract(kananbawah(G,H)), retract(kiribawah(C,D)), retract(kananatas(E,F)),
	A1 is A+1, B1 is B+1, C1 is C+1, D1 is D-1, E1 is E-1, F1 is F+1, G1 is G-1, H1 is H-1,
	/*retractall(location(A,_,_)),retractall(location(G,_,_)),retractall(location(_,B,_)), retractall(location(_,H,_)),*/
	asserta(location(A,_,deadZone)),!,asserta(location(G,_,deadZone)),asserta(location(_,B,deadZone)),!, asserta(location(_,H,deadZone)),!,
	asserta(kiriatas(A1,B1)),!, asserta(kananbawah(G1,H1)),!, asserta(kiribawah(C1,D1)),!, asserta(kananatas(E1,F1)),!.
/* map */
map :- print_map(0,0), nl, !.
print_map(12,11):- !.
print_map(12,Y):-
    Y2 is Y+1, nl, print_map(0,Y2),!.
print_map(X,Y):-
    Y= 0, X2 is X+1 ,print_format(X,Y),!,
    print_map(X2,Y).
print_map(X,Y):-
    Y=11,X2 is X+1, print_format(X,Y),!,
    print_map(X2,Y).
print_map(X,Y):-
    X= 0,X2 is X+1, print_format(X,Y),!,
    print_map(X2,Y).
print_map(X,Y):-
    X=11,X2 is X+1, print_format(X,Y),!,
    print_map(X2,Y).
print_map(X,Y):-
    X2 is X+1, print_format(X,Y),!,
    print_map(X2,Y).
print_format(X,Y):-
    player(X,Y,_,_,_,_,_,_),
    print_player.
print_format(X,_):-
    X < 1, print_border2.
print_format(X,_):-
    X > 10, print_border2.
print_format(_,Y):-
    Y < 1, print_border1.
print_format(_,Y):-
    Y > 10, print_border1.
print_format(X,Y):-
	location(X,Y,Loc), Loc==deadZone, !, print_inaccessible.
print_format(_,_):-print_accessible.

/* Print map elements*/
print_border1:- write('###').
print_border2:- write('#').
print_player:- write(' P ').
print_accessible:- write(' - ').
print_inaccessible:- write('XXX').

/* save */
save(Filename) :- 
	telling(Old), tell(Filename), 
	listing(location/3), listing(player/8), 
	listing(coordinate/2), listing(playersHealth/1), 
	listing(playersWeapon/1), listing(playersArmor/1), 
	listing(playersAmmo), listing(playersMaxInventory), 
	listing(playersItem), listing(remainingEnemy/1), 
	listing(enemy/5), listing(enemysHealth/1),
	listing(enemysWeapon/1), listing(weapon/3), 
	listing(armor/3), listing(medicine/3), 
	listing(item/2), listing(ammo/3),
	listing(game_started/0), listing(time/1),
	told, tell(Old).

/* loadGame */
loadGame(Filename) :-
	quit,
	seeing(Old),
	see(Filename),
	repeat,
	read(Data),
	process(Data),
	seen,
	print('Your previous game session : ('), print(Filename), print(') succesfully loaded!'),
	see(Old),
	!.

/*WOY JANGAN DIHAPUS*/
process(end_of_file) :- !.
process(Data) :- asserta(Data), fail.


	
/*updateEnemy*/

attack :- player(X,Y,_,_,_,_,_,_), \+enemy(_,X,Y,_,_),
	write('Oops, no enemy in this place'), fail, !.

attack :- player(X,Y,_,hand,_,_,_,_), enemy(EnemyID,X,Y,Health,Power),
	weapon(_,hand,Damage), H1 is Health-Damage, H1>0, 
	retract(enemy(EnemyID, X, Y, Health, Power)), asserta(enemy(EnemyID, X, Y, H1, Power)),
	write('Ketembak'), enemy_attack(Power), !.

attack :- player(X,Y,_,hand,_,_,_,_), enemy(EnemyID,X,Y,Health,Power),
	weapon(_,hand,Damage), H1 is Health-Damage, H1 =< 0, 
	retract(enemy(EnemyID, X, Y, Health, Power)), retract(location(X,Y, EnemyID)),
	write('Mati'), remainingEnemy(N), N1 is N-1, retract(remainingEnemy(N)),
	asserta(remainingEnemy(N1)), !.

attack :- player(X,Y,_,bambuRuncing,_,_,_,_), enemy(EnemyID,X,Y,Health,Power),
	weapon(_,bambuRuncing,Damage), H1 is Health-Damage, H1 =< 0, 
	retract(enemy(EnemyID, X, Y, Health, Power)), retract(location(X,Y, EnemyID)),
	write('Mati'), remainingEnemy(N), N1 is N-1, retract(remainingEnemy(N)),
	asserta(remainingEnemy(N1)), !.

attack :- player(X,Y,_,_,Ammo,_,_,_), enemy(_,X,Y,_,_), \+get_weapon(hand),\+get_weapon(bambuRuncing), Ammo=<0,
	write('Your weapon doesnt have ammo'), !.

attack :- player(X,Y,_,Weapon,Ammo,_,_,_), enemy(EnemyID,X,Y,Health,Power),
	weapon(_,Weapon,Damage), Ammo>0, \+get_weapon(hand), \+get_weapon(bambuRuncing),
	H1 is Health-Damage, H1 =< 0, retract(enemy(EnemyID, X, Y, Health, Power)), 
	retract(location(X,Y, EnemyID)), write('Mati'), remainingEnemy(N), N1 is N-1, retract(remainingEnemy(N)),
	asserta(remainingEnemy(N1)), !.

attack :- player(X,Y,_,Weapon,Ammo,_,_,_), enemy(EnemyID,X,Y,Health,Power),
	weapon(_,Weapon,Damage),!, \+get_weapon(hand), \+get_weapon(bambuRuncing), Ammo>0, H1 is Health-Damage, H1>0, 
	retract(enemy(EnemyID, X, Y, Health, Power)), asserta(enemy(EnemyID, X, Y, H1, Power)),
	write('Ketembak'), enemy_attack(Power).

enemy_attack(Power) :- player(_,_,_,_,_,_,_,Armor), armor(_,Armor,ArmPow),
	weapon(_,Power, Damage), A1 is ArmPow-Damage, ArmPow > 0, 
	retract(armor(ID,Armor,ArmPow)), asserta(armor(ID, Armor, A1)).

enemy_attack(Power) :- player(_,_,Health,_,_,_,_,Armor), armor(ID,Armor,ArmPow),
	weapon(_,Power, Damage), A1 is ArmPow-Damage, A1 =< 0, 
	retract(armor(ID,Armor,ArmPow)), H1 is Health + ArmPow,
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	asserta(player(X,Y,H1,Weapon,Ammo,ItemList,MaxInventory, Armor)), lose_con.

enemy_attack(Power) :- get_health(Health), weapon(_,Power,Damage),H1 is Health-Damage, 
	retract(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)),
	asserta(player(X,Y,H1,Weapon,Ammo,ItemList,MaxInventory, Armor)), lose_con.
  
	
/* terrain */
init_terrain :-
	forall(between(1,4,J), (
		forall(between(1,5,I), (
			asserta(terrain(I,J,dingDong))
			)),
		nl
	)), !,
	forall(between(7,10,J), (
		forall(between(1,5,I), (
			asserta(terrain(I,J,r7602))
			)),
		nl
	)), !,
	forall(between(7,10,J), (
		forall(between(6,10,I), (
			asserta(terrain(I,J,labIF4))
			)),
		nl
	)), !,
	forall(between(5,6,J), (
		forall(between(1,10,I), (
			asserta(terrain(I,J,sekre1))
			)),
		nl
	)), !,
	forall(between(1,4,J), (
		forall(between(6,10,I), (
			asserta(terrain(I,J,ccBarat))
			)),
		nl
	)), !.
	  
    