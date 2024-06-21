this.cp_build_webknecht_camp_action <- this.inherit("scripts/factions/actions/cp_build_beast_camp_action", {
	m = {},
	function create()
	{
		this.m.ID = "cp_build_webknecht_camp_action";
		this.cp_build_beast_camp_action.create();

		this.m.DefenderSpawnlistId = "Spiders";
		this.m.CampLimitDefault = 2;
	}

// New Overrides
	function findTileToSpawn()
	{
		local minDistToSettlements = 10;
		local maxDistToSettlements = 1000;
		local minDistToEnemyLocations = 5;
		local minDistToAlliedLocations = 10;
		local minY = 0.2;	// Neither in the desert
		local maxY = 0.8;	// Nor in the snow

		local disallowedTerrain = [];
		for (local i = 0; i < ::Const.World.TerrainType.COUNT; ++i )
		{
			// Webknechts only live in forests.
			if (i == ::Const.World.TerrainType.Forest || i == ::Const.World.TerrainType.LeaveForest || i == ::Const.World.TerrainType.AutumnForest)
			{
				continue;
			}

			disallowedTerrain.push(i);
		}

		local tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, disallowedTerrain, minDistToSettlements, maxDistToSettlements, 1000, minDistToEnemyLocations, minDistToAlliedLocations, null, minY, maxY);

		return tile;
	}
});

