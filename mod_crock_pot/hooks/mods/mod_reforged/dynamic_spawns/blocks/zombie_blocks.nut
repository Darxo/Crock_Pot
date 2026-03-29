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

{	// UnitBlock.RF.Necromancer
	local unitBlock = ::Reforged.Spawns.UnitBlocks["UnitBlock.RF.Necromancer"];
	unitBlock.DynamicDefs.Units.insert(0, { BaseID = "Unit.CP.CP_HoodedMan" });
}

{	// UnitBlock.RF.NecromancerWithBodyguards
	local unitBlock = ::Reforged.Spawns.UnitBlocks["UnitBlock.RF.NecromancerWithBodyguards"];
	unitBlock.DynamicDefs.Units.insert(0, { BaseID = "Unit.CP.CP_HoodedManWithBodyguards" });
}

{	// UnitBlock.RF.NecromancerWithNomads
	local unitBlock = ::Reforged.Spawns.UnitBlocks["UnitBlock.RF.NecromancerWithBodyguardsNomad"];
	unitBlock.DynamicDefs.Units.insert(0, { BaseID = "Unit.CP.CP_HoodedManWithBodyguardsNomad" });
}
