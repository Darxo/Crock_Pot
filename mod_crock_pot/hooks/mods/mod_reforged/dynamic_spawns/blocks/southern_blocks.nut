
{	// New Blocks
	local unitBlocks = [
		{
			ID = "UnitBlock.CP.CaravanGuardSouthern",
			DynamicDefs = {
				Units = [
					{ BaseID = "Unit.CP.CP_CaravanHandSouthern" },
					{ BaseID = "Unit.RF.Conscript" },
					{ BaseID = "Unit.RF.Officer", HardMax = 1, PartySizeMin = 12, ExclusionChance = 50 },
				],
			},
		},
		{
			ID = "UnitBlock.CP.CaravanHandSouthern",
			DynamicDefs = {
				Units = [{ BaseID = "Unit.CP.CP_CaravanHandSouthern" }],
			},
		},
	];

	foreach (blockDef in unitBlocks)
	{
		::Reforged.Spawns.UnitBlocks[blockDef.ID] <- blockDef;
	}
}
