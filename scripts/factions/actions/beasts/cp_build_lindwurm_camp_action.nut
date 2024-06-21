this.cp_build_lindwurm_camp_action <- this.inherit("scripts/factions/actions/cp_build_beast_camp_action", {
	m = {},
	function create()
	{
		this.m.ID = "cp_build_lindwurm_camp_action";
		this.cp_build_beast_camp_action.create();

		this.m.DefenderSpawnlistId = "Lindwurm";
		this.m.CampLimitDefault = 1;
	}

// New Overrides
	function findTileToSpawn()
	{
		local minDistToSettlements = 15;
		local maxDistToSettlements = 1000;
		local minDistToEnemyLocations = 7;
		local minDistToAlliedLocations = 7;
		local minY = 0.0;
		local maxY = 0.5;	// Only in the lower half of the map

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
