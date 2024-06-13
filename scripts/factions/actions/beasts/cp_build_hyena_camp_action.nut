this.cp_build_hyena_camp_action <- this.inherit("scripts/factions/actions/cp_build_beast_camp_action", {
	m = {},
	function create()
	{
		this.m.ID = "cp_build_hyena_camp_action";
		this.cp_build_beast_camp_action.create();

		this.m.DefenderSpawnlist = ::Const.World.Spawn.Hyenas;
		this.m.CampLimitDefault = 2;
	}

// New Overrides
	function findTileToSpawn()
	{
		local minDistToSettlements = 10;
		local maxDistToSettlements = 1000;
		local minDistToEnemyLocations = 5;
		local minDistToAlliedLocations = 10;
		local minY = 0.0;
		local maxY = 0.2;	// Only in the desert part of the world

		local disallowedTerrain = [];
		for (local i = 0; i < ::Const.World.TerrainType.COUNT; ++i )
		{
			if (i == ::Const.World.TerrainType.Desert || i == ::Const.World.TerrainType.Oasis || i == ::Const.World.TerrainType.Steppe || i == ::Const.World.TerrainType.Hills)
			{
				continue;
			}

			disallowedTerrain.push(i);
		}

		local tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, disallowedTerrain, minDistToSettlements, maxDistToSettlements, 1000, minDistToEnemyLocations, minDistToAlliedLocations, null, minY, maxY);

		return tile;
	}
});

