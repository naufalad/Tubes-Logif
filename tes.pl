/*PUBG*/
/* nama anda :/*
/* #listcommand */
/* pilih map : */
/* pemain muncul random */



/* Pengaturan predikat dinamik */
/*:- dynamic(at/3).
:- dynamic(position/2).
:- dynamic(health/1).
:- dynamic(hunger/1).
:- dynamic(thirst/1).
:- dynamic(used_weapon/1).
:- dynamic(weapon/2).
:- dynamic(inventory/1).
:- dynamic(enemy/3).
:- dynamic(enemy_num/1).
:- dynamic(medicine/1).
:- dynamic(food/1).
:- dynamic(drink/1).*/

/*status pemain awal*/
init :-
    /*pengaturan awal pemain*/
    /*janlup random position*/
    asserta(playershealth(100)).
    asserta(playersweapon(hand)).
    asserta(playersammo(0)).
    asserta(playersmaxinventory(0)).

    /*status enemy*/
    asserta(enemyshealth(50)).
    asserta(enemysweapon(pistolG2Combat)).

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

    /*objek dipeta*/

start :-
    

