{	// New Units
	local units = [
		{
			ID = "Unit.CP.CP_GoblinTaskmaster",
			Troop = "CP_GoblinTaskmaster",
			Figure = ["figure_goblin_04"],		// Same Figure as Goblin Overseer
		},
		{
			ID = "Unit.CP.CP_GoblinShaman",
			Troop = "CP_GoblinShaman",
			Figure = ["figure_goblin_03"],		// Same Figure as Goblin Shaman
		},
	];

	foreach (unitDef in units)
	{
		::Reforged.Spawns.Units[unitDef.ID] <- unitDef;
	}
}
