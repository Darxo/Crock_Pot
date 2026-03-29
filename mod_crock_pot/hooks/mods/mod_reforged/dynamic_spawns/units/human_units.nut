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
		ID = "Unit.CP.Councilman",
		Troop = "CP_Councilman",
		Figure = ["figure_player_09"],		// Trader Origin Figure
	},
	{
		ID = "Unit.CP.CP_CaravanHandSouthern",
		Troop = "CP_CaravanHandSouthern",
	},
	{
		ID = "Unit.CP.CP_PersonalGuard",
		Troop = "CP_PersonalGuard",
	},
	{
		ID = "Unit.CP.CP_Crowntaker",
		Troop = "CP_Crowntaker",
	},
	{
		ID = "Unit.CP.CP_Sellsword",
		Troop = "CP_Sellsword",
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
	{
		ID = "Unit.CP.CP_CouncilmanBodyguards",
		Troop = "CP_Councilman",
		Figure = ["figure_player_09"],		// Trader Origin Figure
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.CP.CP_PersonalGuard" },
				{ BaseID = "Unit.CP.CP_PersonalGuard" },
			],
		},
	},
];

foreach (unitDef in units)
{
	::Reforged.Spawns.Units[unitDef.ID] <- unitDef;
}
