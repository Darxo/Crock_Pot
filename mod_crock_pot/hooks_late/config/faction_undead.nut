// We adjust this during hooks_late, so that we can reference Hardened adjustments here
{	// Necromancer
	::Reforged.Entities.addEntity(	// Lower Tier Necromancer
		"CP_HoodedMan",
		"Hooded Man",
		"Hooded Men",
		"human_01_orientation",		// We re-use the orientatio of regular necromancers
		::Const.FactionType.Zombies,
		{
			Variant = 0,
			Strength = ::Const.World.Spawn.Troops.Necromancer.Strength * 0.75,		// Vanilla: 35; Hardened: 45
			Cost = ::Const.World.Spawn.Troops.Necromancer.Cost * 0.75,				// Vanilla: 30; Hardened: 45
			Row = ::Const.World.Spawn.Troops.Necromancer.Row,
			Script = "scripts/entity/tactical/enemies/cp_hooded_man"
		},
		{
			// The following stats are compared with the Vanilla Necromancer stats
			XP = ::Const.Tactical.Actor.Necromancer.XP * 0.75,		// Vanilla: 400; Hardened: 450 * UndeadMult
			ActionPoints = 7,
			Hitpoints = 60,			// Vanilla: 50
			Bravery = 90,
			Stamina = 80,			// Vanilla: 90
			MeleeSkill = 50,
			RangedSkill = 0,
			MeleeDefense = 0,		// Vanilla: 5
			RangedDefense = 10,
			Initiative = 90,
			Armor = [0,	0],			// Vanilla: 20, 0
		}
	);

	// We adjust the existing Necromancer values upwards to make room for the new lower tier variant of it
	::Reforged.Entities.editEntity("Necromancer",
		{
			Strength = ::Const.World.Spawn.Troops.Necromancer.Strength * 1.2,		// Vanilla: 35; Hardened: 45
			Cost = ::Const.World.Spawn.Troops.Necromancer.Cost * 1.2,				// Vanilla: 30; Hardened: 45
		},
		{
			XP = ::Const.Tactical.Actor.Necromancer.XP * 1.2,		// Vanilla: 400; Hardened: 450 * UndeadMult
			Hitpoints = 90,		// Vanilla: 50
			Stamina = 200,		// Vanilla: 90
			MeleeSkill = 60,	// Vanilla: 50
			MeleeDefense = 15,	// Vanilla: 5
			RangedDefense = 15,	// Vanilla: 10
		}
	);
}
