local removeUnit = function( _unitBlock, _unitID )
{
	foreach (index, entry in _unitBlock.DynamicDefs.Units)
	{
		if (entry.BaseID == _unitID)
		{
			_unitBlock.DynamicDefs.Units.remove(index);
			break;
		}
	}
}

{	// UnitBlock.RF.Peasant
	local unitBlock = ::DynamicSpawns.Public.getUnitBlock("UnitBlock.RF.Peasant");
	unitBlock.DynamicDefs.Units.push({ BaseID = "Unit.CP.CP_CitizenNorth" });
	unitBlock.DynamicDefs.Units.push({ BaseID = "Unit.CP.CP_CitizenNorthBodyguards", HardMax = 2 });
	unitBlock.DynamicDefs.Units.push({ BaseID = "Unit.CP.CP_CouncilmanBodyguards", HardMax = 1 });

	unitBlock.TierWidth <- 3;		// Hardened Fix: In Hardened this is defaulted to 2. We need to increase it to allow the last 3 units to be present;
}

{	// UnitBlock.RF.SouthernPeasant
	local unitBlock = ::DynamicSpawns.Public.getUnitBlock("UnitBlock.RF.SouthernPeasant");
	unitBlock.DynamicDefs.Units.push({ BaseID = "Unit.CP.CP_CitizenSouth" });
}

{	// UnitBlock.RF.MercenaryFrontline
	local unitBlock = ::DynamicSpawns.Public.getUnitBlock("UnitBlock.RF.MercenaryFrontline");
	unitBlock.DynamicDefs.Units.push({ BaseID = "Unit.CP.CP_Sellsword" });
}

{	// New Blocks
	local unitBlocks = [
		{
			ID = "UnitBlock.CP.CP_Councilman",
			DynamicDefs = {
				Units = [
					{ BaseID = "Unit.CP.CP_CouncilmanBodyguards" },
				],
			},
		},
	];

	foreach (blockDef in unitBlocks)
	{
		::DynamicSpawns.Public.registerUnitBlock(blockDef);
	}
}
