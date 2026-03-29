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
			Strength = ::Const.World.Spawn.Troops.BountyHunter.Cost * 1.6,		// Vanilla: 25; Hardened: 30
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
			Strength = ::Const.World.Spawn.Troops.Mercenary.Cost * 1.6,		// Vanilla: 25; Hardened: 30
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
