/* Bismillah */

/*PUBG*/
/* nama anda :/*
/* #listcommand */
/* pilih map : */
/* pemain muncul random */

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
:- dynamic(enemysHealth/1).
:- dynamic(enemysWeapon/1).
:- dynamic(weapon/2).
:- dynamic(armor/2).
:- dynamic(item/1).

/*status pemain awal*/
init :-
    /*pengaturan awal pemain*/
    /*janlup random position*/
    asserta(playersHealth(100)).
    asserta(playersWeapon(hand)).
    asserta(playersArmor(0)).
    asserta(playersAmmo(0)).
    asserta(playersMaxInventory(0)).
    asserta(playersItem(X)):- X is [].

    /*status enemy*/
    asserta(enemysHealth(50)).
    asserta(enemysWeapon(pistolG2Combat)).

    /*weapon*/
    asserta(weapon(hand, 5)).
    asserta(weapon(bambuRuncing,50)).
    asserta(weapon(senapanSSX, 30)).
    asserta(weapon(pistolG2Combat, 20)).

    /*armor*/
    asserta(armor(helmet, 20)).
    asserta(armor(kevlar, 50)).
    asserta(armor(caping, 15)).
    asserta(armor(batik, 25)).

    /*item*/
    asserta(item(medicine)).
    asserta(item(bandage)).
    asserta(item(sportdrink)).
    asserta(item(bomb)).
    asserta(item(scope)).

    /*init player*/
    init_player.
	
init_player:-
    playersHealth(Health),
    playersWeapon(Weapon),
    playersItem(ItemList),
    playersAmmo(Ammo),
    playersMaxInventory(MaxInventory),
    random_location(X,Y),
	playersArmor(Armor),
	asserta(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)), !.

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
		write('E = enemy'), nl,
		write('- = accessible'), nl,
		write('X = inaccessible'), nl.
        
quit :- halt.
look :- 
	get_coordinates(X,Y),
	print_player_loc(X,Y),
	print_items_loc(X,Y),
	/* The calculation for the map */
	NW_X is X-1, NW_Y is Y-1,
	N_X is X, N_Y is Y-1,
	NE_X is X+1, NE_Y is Y-1,
	W_X is X-1, W_Y is Y,
	C_X is X, C_Y is Y,
	E_X is X+1, E_Y is Y,
	SW_X is X-1, SW_Y is Y+1,
	S_X is X, S_Y is Y+1,
	SE_X is X+1, SE_Y is Y+1,nl,
	/* print nearby location */
	print_north(N_X,N_Y), print_south(S_X,S_Y),
	print_east(E_X,E_Y), print_west(W_X,W_Y), nl,
	print_format(NW_X,NW_Y),!,
	print_format(N_X,N_Y),!,
	print_format(NE_X,NE_Y),!,nl,
	print_format(W_X,W_Y),!,
	print_format(C_X,C_Y),!,
	print_format(E_X,E_Y),!, nl,
	print_format(SW_X,SW_Y),!,
	print_format(S_X,S_Y),!,
	print_format(SE_X,SE_Y),!,nl.
    
map.
w. a. s. d.
take(Object):-
	has_started, take_item(Object), nl,
	format('You have picked ~w !',[Object]),nl,!.
take(_):-
	has_started, nl,
	write('Gaada brok'),nl, fail.
drop(Object).
use(Object).
attack.
  
status :- get_health(Health), write('Health: '), write(Health), nl,
		  get_armor(Armor), write('Armor: '), write(Armor), nl,
          get_weapon(Weapon), write('Weapon: '), write(Weapon), 
          get_ammo(Ammo), write('Ammo: '), write(Ammo), nl
          get_itemlist(ItemList), write('Item list: '), write(ItemList), nl.
          
save(Filename) :- !.
load(Filename) :- !.

/* INI MAUNYA BAGIAN USE TAPI BINGUNG BANYAK RULE YANG DIBUTUHIN */
in_inventory(X) :- playersItem(L), member(X,L).
/* kira-kira dia ngecek itu weapon, medicine, armor, apa ammo */
          
/*buat dipake di look*/          
check_enemy_nearby :-
	player(X,Y,_,_,_,_,_,_),
	is_enemy_nearby(X,Y).

is_enemy_nearby(X, Y) :-
	A is X, B is Y,
	enemy(_, A, B, _, _), !.
is_enemy_nearby(X, Y) :-
	A is X-1, B is Y-1,
	enemy(_, A, B, _, _), !.
is_enemy_nearby(X, Y) :-
	A is X, B is Y-1,
	enemy(_, A, B, _, _), !.
is_enemy_nearby(X, Y) :-
	A is X+1, B is Y-1,
	enemy(_, A, B, _, _), !.
is_enemy_nearby(X, Y) :-
	A is X-1, B is Y,
	enemy(_, A, B, _, _), !.
is_enemy_nearby(X, Y) :-
	A is X+1, B is Y,
	enemy(_, A, B, _, _), !.
is_enemy_nearby(X, Y) :-
	A is X-1, B is Y+1,
	enemy(_, A, B, _, _), !.
is_enemy_nearby(X, Y) :-
	A is X, B is Y+1,
	enemy(_, A, B, _, _), !.
is_enemy_nearby(X, Y) :-
	A is X+1, B is Y+1,
	enemy(_, A, B, _, _), !.
print_player_loc(X,Y) :-
    check_enemy_nearby,
    grid(X, Y, Loc), nl,
    print_loc(Loc), write('You also sense that there\'s enemy nearby..'), nl, !.
/* If not */
print_player_loc(X,Y) :-
    grid(X,Y,Loc), !.

init_enemy(0) :- !.
init_enemy(N) :- generate_enemy(N), M is N-1, init_enemy(M).

generate_enemy(EnemyID) :-
	repeat,
	random(1, 11, X), random(1, 21, Y),
	enemysHealth(Health), enemysWeapon(Weapon),
	grid(X, Y, Loc),
	Loc \== blank,
	asserta(enemy(EnemyID, X, Y, Health, Weapon)).



/*print format*/
0..take(Object).print_format(X,Y):-
    player(X,Y,_,_,_,_,_),
    print_player.
print_format(X,Y):-
    enemy(_,X,Y,_,_),
    print_enemy.
print_format(X,Y):-
    location(X,Y,Item),
    type_item(special,Item),
    print_radar.
print_format(X,Y):-
    location(X,Y,Item),
    weapon_id(_,Item),
    print_weapon.
print_format(X,Y):-
    location(X,Y,Item),
    type_item(medicine,Item),
    print_medicine.
print_format(X,Y):-
    location(X,Y,Item),
    type_item(food,Item),
    print_food.
print_format(X,Y):-
    location(X,Y,Item),
    type_item(drink,Item),
    print_water.
print_format(X,_):-
    X < 0,
    print_border.
print_format(X,_):-
    X > 9,
    print_border.
print_format(_,Y):-
    Y < 0,
    print_border.
print_format(_,Y):-
    Y > 19,
    print_border.
print_format(X,Y):-
  grid(X,Y,Z),
  Z = blank,
  print_inaccessible.
print_format(_,_):-print_accessible.

take(Object):-
	has_started, take_item(Object), nl,
	format('You have picked ~w !',[Object]),nl,!.
take(_):-
	has_started, nl,
	write('Gaada brok'),nl, fail.
/* player take the item to ItemList */
take_item(Object):-
	has_started,
	player(X,Y,_,_,_,_,_,_),
	location(X,Y,Object),
	add_item(Object),
	retract(location(X,Y,Object)),!.
add_item(Item):-
    retract(player(_,_,_,_,_,_,,ItemList)),
    append([Item],ItemList,NewItemList),
	asserta(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)).
    
drop(Object) :-
	get_position(X,Y),
	get_itemlist(ItemList),
	member(Object,ItemList),
	del_item(Object),
	asserta(location(X,Y,Object)),
	nl ,format('You dropped ~w!',[Object]),nl,!.

drop(Object) :-
	nl ,format('You don\'t have ~w!',[Object]),nl.
	
del_item(Item):-
    retract(player(X,Y,Health,Hunger,Thirst,Weapon,ItemList)),
    delete_one(Item,ItemList,NewItemList),
	asserta(player(X,Y,Health,Weapon,Ammo,ItemList,MaxInventory, Armor)).


/* Command for delete one item */
delete_one(_, [], []).
delete_one(Term, [Term|Tail], Tail) :- !.
delete_one(Term, [Head|Tail], [Head|Result]) :-
delete_one(Term, Tail, Result).
