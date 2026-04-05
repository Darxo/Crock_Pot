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
}
