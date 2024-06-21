this.cp_build_unhold_frost_camp_action <- this.inherit("scripts/factions/actions/cp_build_beast_camp_action", {
	m = {},
	function create()
	{
		this.m.ID = "cp_build_unhold_frost_camp_action";
		this.cp_build_beast_camp_action.create();

		this.m.DefenderSpawnlistId = "UnholdFrost";
		this.m.CampLimitDefault = 1;
	}

// New Overrides
	function findTileToSpawn()
	{
		local minDistToSettlements = 7;
		local maxDistToSettlements = 1000;
		local minDistToEnemyLocations = 5;
		local minDistToAlliedLocations = 5;
		local minY = 0.70;	// Only in the snow
		local maxY = 1.00;

		local disallowedTerrain = [];
		for (local i = 0; i < ::Const.World.TerrainType.COUNT; ++i )
		{
			// Frost Unholds only live in snowy tiles.
			if (i == ::Const.World.TerrainType.Snow || i == ::Const.World.TerrainType.SnowyForest || i == ::Const.World.TerrainType.Mountains)
			{
				continue;
			}

			disallowedTerrain.push(i);
		}

		local tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, disallowedTerrain, minDistToSettlements, maxDistToSettlements, 1000, minDistToEnemyLocations, minDistToAlliedLocations, null, minY, maxY);

		return tile;
	}
});

