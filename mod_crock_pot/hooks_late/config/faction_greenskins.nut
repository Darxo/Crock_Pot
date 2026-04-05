// We adjust this during hooks_late, so that we can reference Hardened adjustments here
{	// Goblins
	::Reforged.Entities.addEntity(	// Lower Tier Goblin Overseer
		"CP_GoblinTaskmaster",
		"Goblin Taskmaster",
		"Goblin Taskmaster",
		"goblin_03_orientation",		// We re-use the orientation of Goblin Overseer
		::Const.FactionType.Goblins,
		{
			Variant = 0,
			Strength = ::Const.World.Spawn.Troops.GoblinOverseer.Strength * 0.6,		// Vanilla: 35; Hardened: 50
			Cost = ::Const.World.Spawn.Troops.GoblinOverseer.Cost * 0.6,				// Vanilla: 35; Hardened: 50
			Row = ::Const.World.Spawn.Troops.GoblinOverseer.Row,
			Script = "scripts/entity/tactical/enemies/cp_goblin_taskmaster"
		},
		{
			XP = ::Const.Tactical.Actor.GoblinLeader.XP * 0.6,		// Vanilla: 400; Hardened: 500 * GoblinMult
			ActionPoints = 9,
			Hitpoints = ::Const.Tactical.Actor.GoblinLeader.Hitpoints,
			Bravery = ::Const.Tactical.Actor.GoblinLeader.Bravery,
			Stamina = ::Const.Tactical.Actor.GoblinLeader.Stamina - 20,
			MeleeSkill = ::Const.Tactical.Actor.GoblinLeader.MeleeSkill + 5,
			RangedSkill = 0,
			MeleeDefense = ::Const.Tactical.Actor.GoblinLeader.MeleeDefense,
			RangedDefense = ::Const.Tactical.Actor.GoblinLeader.RangedDefense - 15,
			Initiative = ::Const.Tactical.Actor.GoblinLeader.Initiative - 10,
			Armor = [0,	0],			// Vanilla: 0, 0
		}
	);

	::Reforged.Entities.addEntity(	// Lower Tier Goblin Shaman
		"CP_GoblinShaman",
		"Goblin Shaman",
		"Goblin Shaman",
		"goblin_02_orientation",		// We re-use the orientation of Goblin Shaman
		::Const.FactionType.Goblins,
		{
			Variant = 0,
			Strength = ::Const.World.Spawn.Troops.GoblinShaman.Strength * 0.5,		// Vanilla: 35; Hardened: 80
			Cost = ::Const.World.Spawn.Troops.GoblinShaman.Cost * 0.5,				// Vanilla: 35; Hardened: 80
			Row = ::Const.World.Spawn.Troops.GoblinShaman.Row,
			Script = "scripts/entity/tactical/enemies/cp_goblin_shaman"
		},
		{
			XP = ::Const.Tactical.Actor.GoblinShaman.XP * 0.5,		// Vanilla: 400; Hardened: 500 * GoblinMult
			ActionPoints = 9,
			Hitpoints = ::Const.Tactical.Actor.GoblinShaman.Hitpoints - 10,
			Bravery = ::Const.Tactical.Actor.GoblinShaman.Bravery - 10,
			Stamina = ::Const.Tactical.Actor.GoblinShaman.Stamina - 30,
			MeleeSkill = ::Const.Tactical.Actor.GoblinShaman.MeleeSkill - 10,
			RangedSkill = 0,
			MeleeDefense = ::Const.Tactical.Actor.GoblinShaman.MeleeDefense,
			RangedDefense = ::Const.Tactical.Actor.GoblinShaman.RangedDefense - 10,
			Initiative = ::Const.Tactical.Actor.GoblinShaman.Initiative,
			Armor = [0,	0],			// Vanilla: 0, 0
		}
	);
}
