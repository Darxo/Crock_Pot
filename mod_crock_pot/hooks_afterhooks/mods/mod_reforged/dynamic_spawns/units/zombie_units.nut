local units = [
// Zombies
	{
		ID = "Unit.CP.CP_HoodedMan",
		Troop = "CP_HoodedMan",
		Figure = ["figure_necromancer_01"],	// Necromancer with a hood
	},

// Necromancer with Bodyguards
	{
		ID = "Unit.CP.CP_HoodedManY",
		Troop = "CP_HoodedMan",
		Figure = ["figure_necromancer_01"],
		StartingResourceMin = 100, // In Vanilla they appear in a group of 100 cost
		StaticDefs = {
			Parties = [
				{ BaseID = "SubPartyYeoman", HardMin = 1, HardMax = 1 },
			],
		},
	},
	{
		ID = "Unit.CP.CP_HoodedManYY",
		Troop = "CP_HoodedMan",
		Figure = ["figure_necromancer_01"],
		StartingResourceMin = 150, // In Vanilla they appear in a group of 320 cost
		StaticDefs = {
			Parties = [
				{ BaseID = "SubPartyYeoman", HardMin = 2, HardMax = 2 },
			],
		},
	},

// Necromancer with Nomad Bodyguards
	{
		ID = "Unit.CP.CP_HoodedManN",
		Troop = "CP_HoodedMan",
		Figure = ["figure_necromancer_01"],
		StartingResourceMin = 110,
		StaticDefs = {
			Parties = [
				{ BaseID = "SubPartyNomad", HardMin = 1, HardMax = 1 },
			],
		},
	},
	{
		ID = "Unit.CP.CP_HoodedManNN",
		Troop = "CP_HoodedMan",
		Figure = ["figure_necromancer_01"],
		StartingResourceMin = 150,
		StaticDefs = {
			Parties = [
				{ BaseID = "SubPartyNomad", HardMin = 2, HardMax = 2 },
			],
		},
	},
];

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
