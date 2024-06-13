this.cp_build_unhold_camp_action <- this.inherit("scripts/factions/actions/cp_build_beast_camp_action", {
	m = {},
	function create()
	{
		this.m.ID = "cp_build_unhold_camp_action";
		this.cp_build_beast_camp_action.create();

		this.m.DefenderSpawnlist = ::Const.World.Spawn.Unhold;
		this.m.CampLimitDefault = 1;
	}

// New Overrides
	function findTileToSpawn()
	{
		local minDistToSettlements = 10;
		local maxDistToSettlements = 1000;
		local minDistToEnemyLocations = 5;
		local minDistToAlliedLocations = 5;
		local minY = 0.2;	// Neither in the desert
		local maxY = 0.8;	// Nor in the snow

		local disallowedTerrain = [];
		for (local i = 0; i < ::Const.World.TerrainType.COUNT; ++i )
		{
			// Unholds live in the hills, just so they are a bit more deterministic to find
			if (i == ::Const.World.TerrainType.Hills || i == ::Const.World.TerrainType.Mountains)
			{
				continue;
			}

			disallowedTerrain.push(i);
		}

		local tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, disallowedTerrain, minDistToSettlements, maxDistToSettlements, 1000, minDistToEnemyLocations, minDistToAlliedLocations, null, minY, maxY);

		return tile;
	}
});

