// We adjust this during hooks_late, so that we can reference Hardened adjustments here
{	// Townsfolk
	::Reforged.Entities.addEntity(	// Southern variant of Caravan Hands
		"CP_CaravanHandSouthern",
		"Caravan Hand",
		"Caravan Hands",
		"caravan_hand_orientation",
		::Const.FactionType.OrientalCityState,
		::MSU.Table.merge(clone ::Const.World.Spawn.Troops.CaravanHand, {
			Script = "scripts/entity/tactical/humans/cp_caravan_hand_southern",
		}),
		clone ::Const.Tactical.Actor.CaravanHand
	);

	// Changes Entities
	::Const.Strings.EntityName[::Const.EntityType.PeasantSouthern] = "Peasant";
	::Const.Strings.EntityNamePlural[::Const.EntityType.PeasantSouthern] = "Peasants";

	::Reforged.Entities.addEntity(	// T2 Upgrade over northern Peasants
		"CP_CitizenNorth",
		"Citizen",
		"Citizens",
		"militia_captain_orientation",
		::Const.FactionType.Settlement,
		{
			Variant = 0,
			Strength = 12,
			Cost = 12,
			Row = 1,
			Script = "scripts/entity/tactical/humans/cp_citizen_north",
		},
		{
			// This is used for both CP_CitizenNorth and CP_CitizenSouth
			XP = 120,
			ActionPoints = 9,
			Hitpoints = 65,
			Bravery = 50,
			Stamina = 100,
			MeleeSkill = 60,
			RangedSkill = 50,
			MeleeDefense = 10,
			RangedDefense = 10,
			Initiative = 100,
			Armor = [0, 0],
		}
	);

	::Reforged.Entities.addEntity(	// T2 Upgrade of southern Peasants
		"CP_CitizenSouth",
		"Citizen",
		"Citizens",
		"militia_captain_orientation",
		::Const.FactionType.OrientalCityState,
		{
			Variant = 0,
			Strength = 12,
			Cost = 12,
			Row = 1,
			Script = "scripts/entity/tactical/humans/cp_citizen_south",
		},
		clone ::Const.Tactical.Actor.CP_CitizenNorth
	);

	::Reforged.Entities.addEntity(	// T4 Upgrade over Peasants/Citizens
		"CP_Councilman",
		"Councilman",
		"Councilmen",
		"greatsword_orientation",
		::Const.FactionType.Settlement,
		{
			Variant = 0,
			Strength = 12,
			Cost = 12,
			Row = 3,
			Script = "scripts/entity/tactical/humans/councilman",
		},
		::MSU.Table.merge(clone ::Const.Tactical.Actor.Councilman, {
			XP = 120,
			Hitpoints = 70,			// Vanilla: 60
			Bravery = 50,			// Vanilla: 40
			MeleeSkill = 65,		// Vanilla: 50
			MeleeDefense = 10,		// Vanilla: 0
			RangedDefense = 10,		// Vanilla: 0
		})
	);
}

{	// Other Humands
	::Reforged.Entities.addEntity(	// T4 Upgrade over Peasants/Citizens
		"CP_PersonalGuard",
		"Personal Guard",
		"Personal Guards",
		"caravan_guard_orientation",
		::Const.FactionType.Settlement,
		{
			Variant = 0,
			Strength = 25,
			Cost = 25,
			Row = 2,
			Script = "scripts/entity/tactical/humans/cp_personal_guard",
		},
		{
			XP = 250,
			ActionPoints = 9,
			Hitpoints = 80,
			Bravery = 90,
			Stamina = 120,
			MeleeSkill = 65,
			RangedSkill = 0,
			MeleeDefense = 15,
			RangedDefense = 15,
			Initiative = 130,
			Armor = [0, 0],
		}
	);

	::Reforged.Entities.addEntity(	// Crowntaker
		"CP_Crowntaker",
		"Crowntaker",
		"Crowntaker",
		"bandit_raider_orientation",
		::Const.FactionType.Generic,
		{
			Variant = 0,
			Strength = ::Const.World.Spawn.Troops.BountyHunter.Strength * 1.6,		// Vanilla: 25; Hardened: 30
			Cost = ::Const.World.Spawn.Troops.BountyHunter.Cost * 1.6,			// Vanilla: 25; Hardened: 30
			Row = 1,
			Script = "scripts/entity/tactical/humans/cp_crowntaker",
		},
		::MSU.Table.merge(clone ::Const.Tactical.Actor.BountyHunter, {
			XP = ::Const.Tactical.Actor.BountyHunter.XP * 1.6,		// Vanilla: 300; Hardened: 300 * MercenaryMult
			Hitpoints = ::Const.Tactical.Actor.BountyHunter.Hitpoints + 20,
			Bravery = ::Const.Tactical.Actor.BountyHunter.Bravery + 10,
			Stamina = ::Const.Tactical.Actor.BountyHunter.Stamina + 20,
			MeleeSkill = ::Const.Tactical.Actor.BountyHunter.MeleeSkill + 10,
			RangedDefense = ::Const.Tactical.Actor.BountyHunter.RangedDefense + 20,
		})
	);

	::Reforged.Entities.addEntity(	// Sellsword
		"CP_Sellsword",
		"Sellsword",
		"Sellswords",
		"mercenary_orientation",
		::Const.FactionType.Generic,
		{
			Variant = 0,
			Strength = ::Const.World.Spawn.Troops.Mercenary.Strength * 1.6,		// Vanilla: 25; Hardened: 30
			Cost = ::Const.World.Spawn.Troops.Mercenary.Cost * 1.6,			// Vanilla: 25; Hardened: 30
			Row = 1,
			Script = "scripts/entity/tactical/humans/cp_sellsword",
		},
		::MSU.Table.merge(clone ::Const.Tactical.Actor.Mercenary, {
			XP = ::Const.Tactical.Actor.Mercenary.XP * 1.6,		// Vanilla: 350; Hardened: 350 * MercenaryMult
			Hitpoints = ::Const.Tactical.Actor.Mercenary.Hitpoints + 20,
			Bravery = ::Const.Tactical.Actor.Mercenary.Bravery + 10,
			Stamina = ::Const.Tactical.Actor.Mercenary.Stamina + 15,
			MeleeSkill = ::Const.Tactical.Actor.Mercenary.MeleeSkill + 5,
			RangedSkill = ::Const.Tactical.Actor.Mercenary.RangedSkill + 5,
			MeleeDefense = ::Const.Tactical.Actor.Mercenary.MeleeDefense + 10,
			RangedDefense = ::Const.Tactical.Actor.Mercenary.RangedDefense + 10,
			Initiative = ::Const.Tactical.Actor.Mercenary.Initiative + 10,
		})
	);
}

{	// Elites
	// Firebrands made their living from doing sabotage and causing ruckus.
	// They are pot-throwing backliner that use throwing weapons for attacking
	// Their gimmick is an NPC-Only accessory, called "Bottomless Bag", which generates and equips a random throwable pot into their offhand each turn
	// They are weak
	::Reforged.Entities.addEntity(
		"CP_Firebrand",
		"Firebrand",
		"Firebrands",
		"assassin_orientation",
		::Const.FactionType.Settlement,
		{
			Variant = ::Const.World.Spawn.Troops.HedgeKnight.Variant,
			Strength = ::Const.World.Spawn.Troops.HedgeKnight.Strength,
			Cost = ::Const.World.Spawn.Troops.HedgeKnight.Cost,
			Row = 2,
			Script = "scripts/entity/tactical/humans/cp_firebrand",
			NameList = ::Const.Strings.CP_FirebrandNames,
			TitleList = null,
		},
		{
			XP = ::Const.Tactical.Actor.HedgeKnight.XP,
			ActionPoints = 9,
			Hitpoints = 100,
			Bravery = 80,
			Stamina = 120,
			MeleeSkill = 70,
			RangedSkill = 90,
			MeleeDefense = 20,
			RangedDefense = 15,
			Initiative = 160,
			Armor = [0, 0],
		}
	);

	// Free Lancer represent knights that used to do jousting or fighting as cavalry and now ended up without a horse and without a faction they call home
	// They are accurate heavily armored backliner, using a Pike as a weapon
	// Their gimmick is being able to walk 4 tiles and still attack with their Pike, thanks to the combination of Fresh and Furious and Vigorous Assault
	// Their weakness is their reliance on dodge, which (together with their hitchance) quickly falls apart in a crowded environment
	::Reforged.Entities.addEntity(
		"CP_FreeLancer",
		"Free Lancer",
		"Free Lancer",
		"zombie_03_orientation",	// Fallen Hero icon
		::Const.FactionType.Settlement,
		{
			Variant = ::Const.World.Spawn.Troops.HedgeKnight.Variant,
			Strength = ::Const.World.Spawn.Troops.HedgeKnight.Strength,
			Cost = ::Const.World.Spawn.Troops.HedgeKnight.Cost,
			Row = 0,
			Script = "scripts/entity/tactical/humans/cp_free_lancer",
			NameList = ::Const.Strings.CP_FreeLancerNames,
			TitleList = null,
		},
		{
			XP = ::Const.Tactical.Actor.HedgeKnight.XP,
			ActionPoints = 9,
			Hitpoints = ::Const.Tactical.Actor.HedgeKnight.Hitpoints,
			Bravery = ::Const.Tactical.Actor.HedgeKnight.Bravery,
			Stamina = ::Const.Tactical.Actor.HedgeKnight.Stamina - 10,
			MeleeSkill = ::Const.Tactical.Actor.HedgeKnight.MeleeSkill + 10,
			RangedSkill = ::Const.Tactical.Actor.HedgeKnight.RangedSkill,
			MeleeDefense = ::Const.Tactical.Actor.HedgeKnight.MeleeDefense - 20,
			RangedDefense = ::Const.Tactical.Actor.HedgeKnight.RangedDefense,
			Initiative = ::Const.Tactical.Actor.HedgeKnight.Initiative + 40,
			Armor = [0, 0],
		}
	);

	// Ironguards represent knights are overfocussed on defense, using any combination of scounged-up gear they can find
	// They are heavily armored frontliner, using a 1H mace/hammer and an orc shield
	// Their gimmick is the use of Menacing and the Threat helmets (Hardened) causing a heavy resolve debuff
	// Line Breaker makes them cause similar chaos on the battle field, as Orc Warrior would do
	// Their weakness is their low accuracy and damage output due to missing damage perks and using a shield
	::Reforged.Entities.addEntity(
		"CP_Ironguard",
		"Ironguard",
		"Ironguards",
		"wildman_03_orientation",
		::Const.FactionType.Settlement,
		{
			Variant = ::Const.World.Spawn.Troops.HedgeKnight.Variant,
			Strength = ::Const.World.Spawn.Troops.HedgeKnight.Strength,
			Cost = ::Const.World.Spawn.Troops.HedgeKnight.Cost,
			Row = ::Const.World.Spawn.Troops.HedgeKnight.Row,
			Script = "scripts/entity/tactical/humans/cp_ironguard",
			NameList = ::Const.Strings.CP_IronguardNames,
			TitleList = null,
		},
		{
			XP = ::Const.Tactical.Actor.HedgeKnight.XP,
			ActionPoints = 9,
			Hitpoints = ::Const.Tactical.Actor.HedgeKnight.Hitpoints,
			Bravery = ::Const.Tactical.Actor.HedgeKnight.Bravery,
			Stamina = ::Const.Tactical.Actor.HedgeKnight.Stamina + 10,
			MeleeSkill = ::Const.Tactical.Actor.HedgeKnight.MeleeSkill - 20,
			RangedSkill = ::Const.Tactical.Actor.HedgeKnight.RangedSkill,
			MeleeDefense = ::Const.Tactical.Actor.HedgeKnight.MeleeDefense,
			RangedDefense = ::Const.Tactical.Actor.HedgeKnight.RangedDefense,
			Initiative = ::Const.Tactical.Actor.HedgeKnight.Initiative,
			Armor = [0, 0],
		}
	);
}
