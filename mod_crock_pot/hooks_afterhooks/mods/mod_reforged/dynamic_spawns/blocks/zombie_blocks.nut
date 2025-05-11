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
	local unitBlock = ::DynamicSpawns.Public.getUnitBlock("UnitBlock.RF.Necromancer");
	unitBlock.DynamicDefs.Units.insert(0, { BaseID = "Unit.CP.CP_HoodedMan" });
}

{	// UnitBlock.RF.NecromancerWithBodyguards
	local unitBlock = ::DynamicSpawns.Public.getUnitBlock("UnitBlock.RF.NecromancerWithBodyguards");
	removeUnit(unitBlock, "Unit.RF.NecromancerY");
	removeUnit(unitBlock, "Unit.RF.NecromancerYK");
	unitBlock.DynamicDefs.Units.insert(0, { BaseID = "Unit.CP.CP_HoodedManY" });
	unitBlock.DynamicDefs.Units.insert(1, { BaseID = "Unit.CP.CP_HoodedManYY" });
}

{	// UnitBlock.RF.NecromancerWithNomads
	local unitBlock = ::DynamicSpawns.Public.getUnitBlock("UnitBlock.RF.NecromancerWithNomads");
	removeUnit(unitBlock, "Unit.RF.NecromancerN");
	unitBlock.DynamicDefs.Units.insert(0, { BaseID = "Unit.CP.CP_HoodedManN" });
	unitBlock.DynamicDefs.Units.insert(1, { BaseID = "Unit.CP.CP_HoodedManNN" });
}
