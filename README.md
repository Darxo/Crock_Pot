# Description

This submod is a collection of content for Reforged.

# Overview
- 3 new southern medium settlements (requires new game)
- 23 new Beast Cave Locations with a unique combat biome
- 10 new items (1 weapon, 3 birds, 4 ammuo items, 2 craftable consumables)
- 2 new Settlement Situations
- 8 new human NPCs/Enemies

# List of all Changes

## Additions

### Southern Villages

- At the start of each new playthrough 3 new southern medium sized villages will spawn in the desert
- Similar to northern villages, these will belong to the nearest city state, so making them angry will also, to a lesser degree, make their owners angry
- Each Village will contain two additional buildings:
	- Either a Weaponsmith or an Armorsmith
	- Either a Temple or a Barber
- Southern Villages offer a mix of southern city state contracts and northern village contracts

### Beast Caves

- Add Beasts Cave locations for most beasts with 150 Base Resources and a Visibility Multiplier of 0.6 (they are hard to naturally find)
- Cave Fights use a new "cave biome" tactical map
- Caves always drop a random treasure and either drop a second treasure or some tools. They also may rarely contain named items, as per vanilla rule
- Every Cave will spawn a roaming party every 2 day. These parties will roam the around the cave for 1,5 day and then return to it
- The following Caves will appear from day 1:
  - Direwolves Caves (Up to 3) spawn only in forests. Their roaming parties have a Visibility Multiplier of 0.5
  - Hyena Caves (Up to 3) spawn only in desert. Their roaming parties have a Visibility Multiplier of 0.5
  - Ghoul Caves (Up to 3) spawn only in swamps. Their roaming parties have a Visibility Multiplier of 0.5
  - Webknecht Caves (Up to 3) spawn only in non-snowy forests. Their roaming parties have a Visibility Multiplier of 0.5
- The following Caves will only start appearing at day 10+:
  - Serpent Caves (Up to 2) spawn only in the desert
  - Lindwurm Caves (Up to 2) spawn only in the desert or steppe. Their caves have 225 Base Resources
  - Unhold Caves (Up to 2) spawn only in the mountains or hills
  - Frost Unhold Caves (Up to 2) spawn only in the snow
  - Bog Unhold Caves (Up to 1) spawn only in the swamp
  - Hexen "Caves" (Up to 2) spawn only in the swamp or forest. Their "cave" takes the appearance of the legendary witch hut location and has 225 Base Resources
- Caves might be mentioned in tavern rumors but they will never be the target of contracts

### New Entities

- Add new **Citizen** unit as the Tier 2 upgrade over **Peasant**. They cost 12 resources. They have the same perks and slightly better stats and gear than their Tier 1 version
	- Rename the existing southern **Citizen** to **Peasant**
- Add new southern **Caravan Hand**. They have the same cost and stats as their northern counterpart and similar gear. They will now appear in southern caravans
- Add new **Personal Guard** unit. They cost 25 resources. They have similar stats and skills to the caravaran guard. Their behavior is similar to that of the **Heralds Bodyguard** in that they try to stay close to their protected targets
- Add new **Councilman** unit. They cost 12 resources. They have slightly worse gear than a citizen but slightly better stats. They will always spawn together with **Personal Guards**. They have a 10% chance to appear in regular caravans and are guaranteed to spawn in the rare heavily armed mercenary caravan variant
- Add new **Sellsword** unit as the Tier 2 upgrade over melee **Mercenaries**. They cost 55 resources. They have better stats, better quality gear and gain the **Poise** perk in addition to all the other perks from the **Mercenary**
- Add new **Crowntaker** unit as the TIer 2 upgrade over melee **Bounty Hunter**. They cost 50 resources. They use higher quality helmets, weapons and reinforced nets. They have **Anticipation**, **Executioner**, **Small Target**, **Angler** and **Throwing Mastery** in addition to all the perks from regular **Bounty Hunter**
- **Hooded Man** is a new tier 1 necromancer. He has the same cost of 30 and very similar stats to the old Necromancer. He has the same skills as the old Necromancer but no perks
  - The **Necromancer** is now tier 2. He costs 50 resources (up from 30), has 90 Hitpoints (up from 50), 200 Stamina (up from 80), 60 Melee Skill (up from 50), 10 Melee Defense (up from 5) and grants 500 XP (up from 350). He no longer spawns with a hat and wields either a rondel dagger or a scramasax

### New Situations

- **Physicians Gathering** can randomly occur in any settlement with size 2 or 3. It increases amount of available medicine, reduces medicine price and makes Anatomists and Monks more common during hiring
- **Grand Travelling Show** can randomly occur in any civilian settlement with size 2 or 3 or in city states. It increases food price, increases available recruits and it makes Juggler, Houndmaster and Wildmen more common during hiring

### Items

- **Forgetfulness Potion** is a consumable, that increases your Perk Tier by 1 when used outside of battle
- **Ayahuasca** is a consumable, that refunds two random perk points when used outside of battle
- **Hawk** grants +15 Iniative and can be released to hinder an enemy movement for 1 turn. They are sold in T3 Towns, Military Settlements, or any town with a Hunters Cabin location
- **Owl** grants +10 Ranged Defense and can be released to cause a negative morale check on an enemy. They are sold T3 Towns, Military Settlements, or any town with a Trapper location. Also regularly sold by Alchemists
- **Vulture** grants +10 Threat (similar effect as direwolf pelts) and can be released to remove a single consumable corpse. They are sold T3 Towns, Military Settlements, or any town with a Pig Farm location. Also regularly sold by Alchemists
- **Bag of compressed Nets** (stores 2 uses) and **Large Bag of compressed Nets** (stores 3 uses) are a new firearm ammo item. When you reload your weapon, its next shot will deal 80% less damage and put every enemy in a net, that was hit. The small bag variant is regularly sold by **Alchemists**
- **Bag of incendiary Bullets** (stores 5 uses) and **Large Bag of incendiary Bullets** (stores 7 uses) are new firearm ammo items. When you reload your weapon its next shot will convert all damage to Fire Damage and light the respective tiles on fire for 2 turns on a hit. The small bag variant is sometimes sold by **Alchemists**
- **Reinforced Wooden Staff** weapon is a lower tier version of the **Polemace**. It has the same weapon type, range and attack patterns. It has 35-55 Damage, 120% Armor Damage, 40% Armor Penetration, 6 Reach and a Weight of 10. It is sometimes sold in southern marketplaces and has a 10% chance to spawn on **Nomad Cutthroats**

### Crafting Recipes

### Craftable Items

- **Forgetfulness Potion**: Geist Tear, Shimmering Ashes, 500 Crowns
- **Ayahuasca**: Mysterious Herbs, 2x **Poison Gland, 350 Crowns
- **Bag of compressed Nets**: Powder Bag, Throwing Net, Serpent Skin, 150 Crowns
- **Large Bag of compressed Nets**: Bag of compressed Nets, Throwing Net, Serpent Skin, 300 Crowns
- **Large Bag of compressed Nets**: Large Powder Bag, 2x Throwing Net, 300 Crowns
- **Bag of incendiary Bullets**: Powder Bag, Sulfurous Rocks, Serpent Skin, 150 Crowns
- **Large Bag of incendiary Bullets**: Bag of incendiary Bullets, Serpent Skin, 300 Crowns
- **Large Bag of incendiary Bullets**: Large Powder Bag, Sulfurous Rocks, 300 Crowns

### Unleashable Birds

- Add 3 new unleashable birds, which are equipped in the Accessory slot, just like the Falcon

### Additional Artwork

- Add a new helmet variant for Witchhunter Hat, Undertaker's Hat and Dark Cowl
- Adjust Artwork for Duelist Hats to make them more distinct from Zweihander Helmets and Duelist Helmets

## Balance & Polishing

- **Falcon** no longer provides Initiative to your party when released. It now grants +15 Initiative while equipped
- All unleashable Birds (including Falcon) are now automatically released without effect when their owner takes any damage
- The Falcon now uses actual falcon noises when equipping or releasing, instead of using hawk noises
- Orc Caves now hide their defender, use the same name pool as the beast caves and also use the new cave biome tactical map

## Fixes

- Increase the amount of supported factions in the combat manager to 64 (up from 32)
- Change witchhunter helmet icon to align with sprite

## For Modder

- Add new `CP_getApplicableRandomSituations()` function to `settlement.nut` that returns a WeightedContainer with all applicable random situations for this settlement
- Modularize (overwrite) `onUpdate` of `add_random_situation_action.nut` using new `CP_getApplicableRandomSituations`
  - Add `MaximumSituations = 2` member, for configuring, what the situation threshold is, at which point no random situation can spawn
  - Add `MinDistanceToPlayer = 11` member, that defines how far away the player must be from the settlement, for it to consider spawning random situations

# Requirements

- Reforged

# Known Issues

- Crafting Recipes that require a certain Powder Bag variant will accept any Powder Bag of any size/variant. This is a vanilla bug and fixed in the overhaul mod **Hardened**
- Geist Tear is not marked as a crafting ingredient even though it's now used in a recipe
- Peasants and Caravans spawned by City States appear at their Villages instead
- Southern Villages can sometimes spawn with additional northern buildings. That can happens if too few of those buildings were spawned

# Compatibility

- Can be added to any savegame (although the new southern villages will not appear then)
- Can **NOT** be removed from your playthrough
