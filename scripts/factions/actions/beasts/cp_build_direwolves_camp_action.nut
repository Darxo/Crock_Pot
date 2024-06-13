this.cp_build_direwolves_camp_action <- this.inherit("scripts/factions/actions/cp_build_beast_camp_action", {
	m = {},
	function create()
	{
		this.m.ID = "cp_build_direwolves_camp_action";
		this.cp_build_beast_camp_action.create();

		this.m.DefenderSpawnlist = ::Const.World.Spawn.Direwolves;
		this.m.CampLimitDefault = 2;
	}

// New Overrides
	function findTileToSpawn()
	{
		local minDistToSettlements = 10;
		local maxDistToSettlements = 1000;
		local minDistToEnemyLocations = 5;
		local minDistToAlliedLocations = 10;
		local minY = 0.2;	// Everywhere but the desert part of the world
		local maxY = 1.0;

		local disallowedTerrain = [];
		for (local i = 0; i < ::Const.World.TerrainType.COUNT; ++i )
		{
			// Direwolfs only live in Forests
			if (i == ::Const.World.TerrainType.Forest || i == ::Const.World.TerrainType.SnowyForest || i == ::Const.World.TerrainType.LeaveForest || i == ::Const.World.TerrainType.AutumnForest)
			{
				continue;
			}

			disallowedTerrain.push(i);
		}

		local tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, disallowedTerrain, minDistToSettlements, maxDistToSettlements, 1000, minDistToEnemyLocations, minDistToAlliedLocations, null, minY, maxY);

		return tile;
	}
});

