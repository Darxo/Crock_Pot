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
	local caravanParty = ::Reforged.Spawns.Parties["Caravan"];
	caravanParty.Variants.filter(function(_item, _weight) {
		if (_item.ID == "Caravan_0")
		{
			_item.DynamicDefs.UnitBlocks.push({ BaseID = "UnitBlock.CP.CP_Councilman", ExclusionChance = 90, StartingResourceMin = 200, RatioMax = 0.15, DeterminesFigure = false });
		}
		else if (_item.ID == "Caravan_1")
		{
			_item.DynamicDefs.UnitBlocks.push({ BaseID = "UnitBlock.CP.CP_Councilman", HardMin = 1, RatioMax = 0.15, DeterminesFigure = false });
		}
	});
}
