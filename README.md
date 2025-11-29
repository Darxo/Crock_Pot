# Description

This submod is a collection of content for Reforged.

# Overview
- 3 new southern medium settlements (requires new game)
- 23 new Beast Caves for most types of beasts. Those beasts now only spawn from their caves instead of randomly appearing in the world
- 2 new craftable items
- 3 new unleashable birds
- 2 new Settlement Situations
- 1 new Enemy Type

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
- Caves always drop a random treasure and either drop a second treasure or some tools
- Caves may rarely contain named items (They follow the same Vanilla rule as all other camps for this)
- Every Cave will spawn a roaming party every 2 day. These parties will roam the around the cave for 1,5 day and then return to it
- The following Caves will appear from day 1:
  - Direwolves Caves (Up to 3) spawn only in forests. Their roaming parties have a Visibility Multiplier of 0.5
  - Hyena Caves (Up to 3) spawn only in desert. Their roaming parties have a Visibility Multiplier of 0.5
  - Ghoul Caves (Up to 3) spawn only in swamps. Their roaming parties have a Visibility Multiplier of 0.5
  - Webknecht Caves (Up to 3) spawn only in non-snowy forests. Their roaming parties have a Visibility Multiplier of 0.5
- The following Caves will only start appearing at day 10+:
  - Serpent Caves (Up to 2) spawn only in the desert
  - Lindwurm Caves (Up to 2) spawn only in the desert or steppe. Their caves have 210 Base Resources
  - Unhold Caves (Up to 2) spawn only in the mountains or hills
  - Frost Unhold Caves (Up to 2) spawn only in the snow
  - Bog Unhold Caves (Up to 1) spawn only in the swamp
  - Hexen "Caves" (Up to 2) spawn only in the swamp or forest. Their "cave" takes the appearance of the legendary witch hut location and has 210 Base Resources
- Caves might be mentioned in tavern rumors but they will never be the target of contracts

### New Entities

- **Hooded Man** is a new tier 1 necromancer. He has the same cost of 30 and very similar stats to the old Necromancer. He has the same skills as the old Necromancer but no perks
  - The **Necromancer** is now tier 2. He costs 50 resources (up from 30), has 90 Hitpoints (up from 50), 200 Stamina (up from 80), 60 Melee Skill (up from 50), 10 Melee Defense (up from 5) and grants 500 XP (up from 350). He no longer spawns with a hat and wields either a rondel dagger or a scramasax

### New Situations

- **Physicians Gathering** can randomly occur in any settlement with size 2 or 3. It increases amount of available medicine, reduces medicine price and makes Anatomists and Monks more common during hiring
- **Grand Travelling Show** can randomly occur in any civilian settlement with size 2 or 3 or in city states. It increases food price, increases available recruits and it makes Juggler, Houndmaster and Wildmen more common during hiring

### Craftable Items

- Forgetfulness Potion
  - Requires: Geist Tear, Shimmering Ashes
  - Consumable: Refund two random perk points
- Ayahuasca
  - Requires: Mysterious Herbs, 2x Poison Gland
  - Consumable: Increase your Perk Tier by 1

### Unleashable Birds

- Add 3 new unleashable birds, which are equipped in the Accessory slot, just like the Falcon
  - **Hawk** grants +15 Iniative and can be released to hinder an enemy movement for 1 turn. They are sold in T3 Towns, Military Settlements, or any town with a Hunters Cabin location
  - **Owl** grants +10 Ranged Defense and can be released to cause a negative morale check on an enemy. They are sold T3 Towns, Military Settlements, or any town with a Trapper location. Also regularly sold by Alchemists
  - **Vulture** grants +10 Threat (similar effect as direwolf pelts) and can be released to remove a single consumable corpse. They are sold T3 Towns, Military Settlements, or any town with a Pig Farm location. Also regularly sold by Alchemists

### Additional Artwork

- Add a new helmet variant for Witchhunter Hat, Undertaker's Hat and Dark Cowl
- Adjust Artwork for Duelist Hats to make them more distinct from Zweihander Helmets and Duelist Helmets

## Balance & Polishing

- **Falcon** no longer provides Initiative to your party when released. It now grants +15 Initiative while equipped
- All unleashable Birds (including Falcon) are now automatically released without effect when their owner takes any damage
- The Falcon now uses actual falcon noises when equipping or releasing, instead of using hawk noises

## Fixes

- Change witchhunter helmet icon to align with sprite

## For Modder

- Add new `CP_getApplicableRandomSituations()` function to `settlement.nut` that returns a WeightedContainer with all applicable random situations for this settlement
- Modularize (overwrite) `onUpdate` of `add_random_situation_action.nut` using new `CP_getApplicableRandomSituations`
  - Add `MaximumSituations = 2` member, for configuring, what the situation threshold is, at which point no random situation can spawn
  - Add `MinDistanceToPlayer = 11` member, that defines how far away the player must be from the settlement, for it to consider spawning random situations

# Requirements

- Reforged

# Known Issues

- Geist Tear is not marked as a crafting ingredient even though it's now used in a recipe
- Peasants and Caravans spawned by City States appear at their Villages instead
- Southern Villages can sometimes spawn with additional northern buildings. That can happens if too few of those buildings were spawned

# Compatibility

- Can be added to any savegame (although the new southern villages will not appear then)
- Can **NOT** be removed from your playthrough
