# Pokémon Crystal 2 [![Build Status][travis-badge]][travis]

This is the disassembly of my own hack of Pokémon Crystal called PokeCrystal2.

pokecrystal2.gbc 

To build the game, see [INSTALL.md](INSTALL.md).

List of major changes
* **Pokemon that evolve by trading now can be evolved using a Link Cable.**
* **Pokemon that evolve by trading while holding a specific item now can evolve using that item.**
* **All Pokemon will now be able to be obtained without trading.** Legendary Pokemon listed below can only be found after beating Red for the first time. Bolded items are completed
  * **All Pokemon normally unavailable in Crystal are found at routes that they are found on in other Gen 2 games.**
  * **All starter Pokemon are found at the Safari Zone.**
  * **Articuno is found at the Seafoam Islands. Requires Surf.**
  * **Zapdos is found outside of the Kanto Power Plant.**
  * **Moltres is found in a new section of Mt. Silver Cave. Requires Surf and Waterfall.**
  * **Mewtwo is found in Cerulean Cave.**
  * **Mew is found at Faraway Island. You will need to get the Faraway Map before you are able to go there.**
  * **Celebi will be found through the event that was only released in Japan.** Able to start after beating Red.
* **The Odd Egg Pokemon list has been reworked.** All Pokemon have an equal chance of being shiny and a roughly equal chance at hatching. The DVs for each non-shiny Pokemon are maxed out, while the shiny versions are the max available, not including Tyrogue which has the same Attack and Defense DVs.
* **Your Mom will get many more different items when she goes shopping.** You will be able to get all of the decorations including the trophies. Something special is available to those who are super savers.
* **Unown now has a new way of getting it's letter.** Now every Unown can be shiny. - PokeSeer cannot read caught data for Unown due to this.
* **6 new Unowns.** 2 of them are the exclamation point and the question mark. The other 4 are period, comma, hyphen, and interrobang (!?). - Current unavailable due to a bug.
* **There is now a dark type boost after beating Karen for the first time.** This means you can lose after Karen and still receive the bonus, you just have to beat her once. - This has not been extensively tested yet.
* **Add rematches for all Pokemon Gym Leaders.** Johto leaders are located at the Olivine Cafe. Kanto leaders are located at the Celadon Cafe. - This has not been extensively tested yet.
* Add a Move Relearner. - This has not been extensively tested yet.

List of minor changes
* Moves are updated to the latest Gen stats with a couple changing type. No fairy type.... Yet. Maybe some new types.
* Ghost-type is now Special, while Dark-type is now Physical.
* Many bugs left from Gen 2 are fixed. Even some that weren't widely known about.
* Each Johto badge increases the level that traded Pokemon obey. Kanto badges are not taken into account.
* Some moves have been given the correct name based on limits from Gen 2.
* Steel is no longer resistant to Dark and Ghost.
* Poison is now super-effective to Bug as in Gen 1.
* Bug now resists Psychic. A balancing decision.
* The phone list size is increased to 20. 
* The number at which Pokemon evolve by happiness is decreased to 200.
* Some Pokemon have a second type.
* Some trainers' Pokemon have been given different DVs. Special trainers now carry shiny Pokemon.
* The password to reset the clock has been removed. Now it will reset when you hit Yes. 
* You will get $5000 when starting the game.
* All instances where the game checks which version of Crystal are removed. There is and will only be one version to make.
* Poison knocking out a Pokemon will reduce its friendship by less than normal.
* You will be able to find Link Cables for sale at both Department stores.
* All evolutionary items are for sale at the Celadon Department store.
* You will get 10 Poke Balls to start with.
* Sonic Boom will now show its Japanese animation in battle. Cause why would they change it in the first place...?
* Magnet Bomb has been added to the available moves. Only Magnemite and Magneton learn it so far.
* Sweet Honey has been added into the game. It now is a hold item that can be used to increase the chance of catching a Pokemon. Equivalent to the boost from Poison/Paralyze/Burn.
* The main pocket of the bag is increased to 50. Now you won't always have to run back to the PC to deposit items you don't need.
* 10 TMs will be given out if they are picked up by the player or given to the player from an NPC.
* Updated Pokemons' stats to the latest Gen.
* Pokemon Trainers which have been given shiny Pokemon have edited parties.
* The chances to have a wild Pokemon with a held item has been increased to 24% and 6%.
* The Unown that you can catch from each puzzle have been changed
* The Light Ball will increase Special Attack for Pichu, Pikachu, and Raichu.

List of minor things left to do
* Add more Egg moves.
* Add more Level Up moves.
* Add more TM moves.
* Add a Soothe Bell item. The code has been extensively tested and ready for implementation. 

List of major things left to do
* Update all trainers' Pokemon with newly acquired moves.

List of things I want to do but might not be able to
* Add a password checker to create in-game Pokemon events.

List of current bugs
* The check Unown caught code does not seem to work with this new system.

**If you find a bug with a change that I've added or something that isn't known about, please open an issue and provide as much information as possible.**

[travis]: https://travis-ci.org/i0brendan0/pokecrystal2
[travis-badge]: https://travis-ci.org/i0brendan0/pokecrystal2.svg?branch=master
