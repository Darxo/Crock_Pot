local units = [
// Civilians
	{
		ID = "Unit.CP.CP_CitizenNorth",
		Troop = "CP_CitizenNorth",
		Figure = ["figure_civilian_05"],	// Figure of a Peasant in noble-like tunic
	},
	{
		ID = "Unit.CP.CP_CitizenSouth",
		Troop = "CP_CitizenSouth",
		Figure = ["figure_player_13"],		// Southern Quickstart Figure
	},
	{
		ID = "Unit.CP.CP_CaravanHandSouthern",
		Troop = "CP_CaravanHandSouthern",
	},
	{
		ID = "Unit.CP.CP_PersonalGuard",
		Troop = "CP_PersonalGuard",
	},

// ... with Bodyguards
	{
		ID = "Unit.CP.CP_CitizenNorthBodyguards",
		Troop = "CP_CitizenNorth",
		Figure = ["figure_civilian_05"],	// Figure of a Peasant in noble-like tunic
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.CP.CP_PersonalGuard" },
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
