local removeBlock = function( _party, _unitBlockID )
{
	foreach (index, entry in _party.DynamicDefs.UnitBlocks)
	{
		if (entry.BaseID == _unitBlockID)
		{
			_party.DynamicDefs.UnitBlocks.remove(index);
			break;
		}
	}
}

// Hooking
{
	local caravanSouthernParty = ::DynamicSpawns.Public.getParty("CaravanSouthern");
	removeBlock(caravanSouthernParty, "UnitBlock.RF.SouthernFrontline");	// Replaced by UnitBlock.CP.CaravanGuardSouthern
	removeBlock(caravanSouthernParty, "UnitBlock.RF.Officer");	// Replaced by UnitBlock.CP.CaravanGuardSouthern
	caravanSouthernParty.DynamicDefs.UnitBlocks.push({ BaseID = "UnitBlock.CP.CaravanHandSouthern", RatioMin = 0.1, RatioMax = 0.2, DeterminesFigure = false });
	caravanSouthernParty.DynamicDefs.UnitBlocks.push({ BaseID = "UnitBlock.CP.CaravanGuardSouthern", RatioMin = 0.20, DeterminesFigure = false });
}
