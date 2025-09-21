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
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.ZombieYeomanBodyguard" },
			],
		},
	},
	{
		ID = "Unit.CP.CP_HoodedManYY",
		Troop = "CP_HoodedMan",
		Figure = ["figure_necromancer_01"],
		StartingResourceMin = 150, // In Vanilla they appear in a group of 320 cost
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.ZombieYeomanBodyguard" },
				{ BaseID = "Unit.RF.ZombieYeomanBodyguard" },
			],
		},
	},

// Necromancer with Nomad Bodyguards
	{
		ID = "Unit.CP.CP_HoodedManN",
		Troop = "CP_HoodedMan",
		Figure = ["figure_necromancer_01"],
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.ZombieNomadBodyguard" },
			],
		},
	},
	{
		ID = "Unit.CP.CP_HoodedManNN",
		Troop = "CP_HoodedMan",
		Figure = ["figure_necromancer_01"],
		StartingResourceMin = 150,
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.ZombieNomadBodyguard" },
				{ BaseID = "Unit.RF.ZombieNomadBodyguard" },
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
