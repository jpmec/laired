LAIRED
======

An open-source dungeon crawler.


The Hero
========

All players play as a Hero.

A Hero has:

* An avitar for a face

* May have a hat
* Shirt
* Pants
* May have shoes
* May have gloves
* May have a belt

* Each wearable may have special powers that can be enabled

* A belt allows the hero to store a number of items from their bag where they are easy to swap out.

* A Hero can only enable at most two items, one for each hand.  Some items may require both hands.

* All Heros have a bag to store stuff.  Bags only store a finite quantity of stuff.  Bigger bags store more stuff.  A Hero must be stronger to carry more stuff.  The more stuff a Hero has, the slower the Hero will move.

* It is dark underground, a Hero may have a light they carry in their hand, or a Miner's Hat which has a light attached.  There are different levels of lights and Miner's Hats which put out more light or illuminate certain objects.

* The Hero may collect resources from the environment.

* The Hero must eat and sleep periodically, or they will become weak.

* A Hero has Health.  Once a Hero's Health reaches zero, the Hero dies.

* A Hero can use Skill to turn Items into other Items.  Skills must be learned from Books or from other NPC.

* A Hero can have one or more other Heros as a Friend.  A Hero can chat with Friends during the game.  No matter where the other Friends are in the World.

* The Chat is also used to interact with NPC, and for the Guardian to narrate and give hints about the World.


The Hero's Lair
===============

* All Hero's have a Lair.
* A Lair is protected by a spell cast by the Guardian Spirit, so that only the Hero may enter their Lair.
* The location of a Hero's Lair is not seen on the world map by another Hero.
* A Lair can store items.  All items are stored in trunks, or out in the open.
* A trunk will hold a finite amount of items.  Bigger trunks will hold more items.
* A Lair is underground, and has a light.
* A Lair starts as a small room, and can be expanded by the Hero by digging or mining.
* A Hero can carry dirt in the Bag.  Dirt must go somewhere, either in the Lair, or in the World.  Dirt dumped on the Ground disappears.
* A Hero can dig dirt with their hands (slow) or with tools (faster).
* A Lair has an exit to the World.  The Lair may also exit to an 'unexplored' Ground where only the Hero and NPC's are located.  This allows the Hero to have their own playground that won't be disturbed by other players in the World.


The Hero's Guardian Spirit
==========================

* The Hero's Guardian Spirit (a.k.a) is with the Hero throughout the game.
* The Guardian cannot interact with the world directly.
* The Guardian can tell the Hero things throughout the game (i.e. tutor and narrator).
* If the Hero dies, the Guardian will return the Hero's spirit back to the Hero's Lair where the Hero will be reincarnated.
* If the Hero dies, everything the Hero had will be dropped in the spot in the world.  The Hero can either go back to collect it, or another player can find it.


The Worlds
==========

* When a Hero exits their Lair, they appear in a World.

* The World has the Ground, which is a 2D horizontal plane.
* The World is modelled as a graph, where the Hero is in a node, and may go to connected nodes.  The Ground is not topologically accurate with respect to distance, this is intended.  Each node is called a Location.

* A Location has an X, Y, Z coordinate.  The coordinates are graph coordinates.  When on the Ground, the coordinates may increment in X and Y depending on which edge of the Location the Hero enters/exits.  When Underground, the X and Z coordinates change depending on the edge of the Location the Hero enters/exits.  Multiple Locations may have the same coordinates.

* The Location coordinates help determine how any new Locations are generated.  After any Location coordinate grows too large, the Hero will encounter either the sea or magma.  The Hero will die when encountering magma for too long.  The Hero will go out to sea, but after going out to sea where only sea is shown, the Hero will not continue out any farther.

* As the Location Y changes, the environment will change between temperate, desert and artic.  Location Y = 0 is desert.  At the +/- extremes is artic.  Between artic and desert is temperate.

* The Hero cannot swim and must cross water in a vessel.  The Hero may be carrying a raft in the Bag.  The Hero may be carrying a paddle in the Bag.

* The World has Holes, which can be entered by the Hero.
* Inside a Hole is Underground.  Underground is dark, a Hero must have a light to see.  Light is visible from the Ground.
* Inside a Hole, the World is a vertical-ish 2D plane.
* A Hole may have more than one entrance from the Ground.
* Inside a Hole, the Hero may dig for resources.  A Hero cannot add entrances to the Ground, those are fixed.


* The World has daytime and nighttime.  Different NPCs and items will appear during daytime and nighttime.

* Each 'game-day' in the World is 1 real-life hour.  There are 365 game-days in a game-year.

* The World has items that the Hero can collect.

* Hero's can trade items with each other.
* A Hero cannot attack other Heros, their Guardian won't let them.
* A Hero can attack an Enemy.

* A Hero's attack will be determined by what they are wearing and what is in their hands.

* The World contains buildings that can be entered for special tasks.

* If a Hero reveals a new item in the World, then it is available only to the Hero for a few seconds.  Then it is revealed and available to all players.  This stops other Heros from stealing items from a working Hero.

* There are certain areas of the World that can be opened up by Hero to make new World nodes.

* There are Transporters that will transport a Hero to the location of other Transporters.  A Transporter may always transport to the same other Transporter, or a Transporter may be random.  Two Transporters may be mirrors, so that A->B and B->A, or they operate like A->B, B->C.



Stuff and Things
================

There are two main categories of static entities:
* Stuff
* Things

Stuff can be picked up by the Hero, and 'stuffed' in the HeroBag.
Things can not be picked up by the Hero.
Things may be turned into Stuff by the Hero.


Resources
=========

A Location can have static resources
* Minerals
* Gems
* Metals


Plants
======
Plants are essential NPCs that do not move.
Plants can be planted from seed.
Plants will grow over time.
Plants can be picked (and not killed).
Plants can be killed and harvested.



Enemy NPC
=========
Enemy NPC will spawn in Locations.
Enemy NPC can be killed and harvested.
A Hero can collect some enemy NPC and transport them in the Bag.



Friendly NPC
============
Friendly NPC exist in Locations.
A Hero's Guardian will not let them kill a friendly NPC.
A Hero can collect some friendly NPC and transport them in the Bag.


Traps
=====
A Hero can set, trip, disarm and collect traps.
A Hero's sensing ability, or hat can allow him to see enemy traps.

