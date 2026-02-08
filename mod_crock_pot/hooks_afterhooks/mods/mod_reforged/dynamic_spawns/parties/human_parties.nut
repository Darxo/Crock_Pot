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
	local caravanParty = ::DynamicSpawns.Public.getParty("Caravan");
	caravanParty.filter(function(_item, _weight) {
		if (_item.ID == "Caravan_0")
		{
			_item.DynamicDefs.UnitBlocks.push({ BaseID = "UnitBlock.CP.CP_Councilman", ExclusionChance = 0.9, StartingResourceMin = 200, RatioMax = 0.15, DeterminesFigure = false });
		}
		else if (_item.ID == "Caravan_1")
		{
			_item.DynamicDefs.UnitBlocks.push({ BaseID = "UnitBlock.CP.CP_Councilman", HardMin = 1, RatioMax = 0.15, DeterminesFigure = false });
		}
	});
}
