{	// New Units
	local units = [
	// Zombies
		{
			ID = "Unit.CP.CP_HoodedMan",
			Troop = "CP_HoodedMan",
			Figure = ["figure_necromancer_01"],		// Necromancer with a hood
		},

	// Necromancer with Bodyguards
		{
			ID = "Unit.CP.CP_HoodedManWithBodyguards",
			Troop = "CP_HoodedMan",
			Figure = ["figure_necromancer_01"],
			StartingResourceMin = 100, 		// Same as regular Necromancers in Reforged
			StaticDefs = {
				Parties = [
					{
						BaseID = "NecromancerBodyguards",
						function getDefaultResources() {
							return base.getDefaultResources() * 0.7;
						},
					},
				],
			},
		},
		{
			ID = "Unit.CP.CP_HoodedManWithBodyguardsNomad",
			Troop = "CP_HoodedMan",
			Figure = ["figure_necromancer_01"],
			StartingResourceMin = 100, 		// Same as regular Necromancers in Reforged
			StaticDefs = {
				Parties = [
					{
						BaseID = "NecromancerBodyguardsNomad",
						function getDefaultResources() {
							return base.getDefaultResources() * 0.7;
						},
					},
				],
			},
		},
	];

	foreach (unitDef in units)
	{
		::Reforged.Spawns.Units[unitDef.ID] <- unitDef;
	}
}

{	// Hooks
	::Reforged.Spawns.Units["Unit.RF.Necromancer"].StartingResourceMin <- 200;						// Reforged: unrestricted
	::Reforged.Spawns.Units["Unit.RF.NecromancerWithBodyguards"].StartingResourceMin = 250;			// Reforged: 100
	::Reforged.Spawns.Units["Unit.RF.NecromancerWithBodyguardsNomad"].StartingResourceMin = 250;	// Reforged: 100
}
