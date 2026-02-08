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
];

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
