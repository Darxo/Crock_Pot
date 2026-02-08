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
}

{	// UnitBlock.RF.SouthernPeasant
	local unitBlock = ::DynamicSpawns.Public.getUnitBlock("UnitBlock.RF.SouthernPeasant");
	unitBlock.DynamicDefs.Units.push({ BaseID = "Unit.CP.CP_CitizenSouth" });
}

