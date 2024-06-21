this.cp_build_unhold_bog_camp_action <- this.inherit("scripts/factions/actions/cp_build_beast_camp_action", {
	m = {},
	function create()
	{
		this.m.ID = "cp_build_unhold_bog_camp_action";
		this.cp_build_beast_camp_action.create();

		this.m.DefenderSpawnlistId = "UnholdBog";
		this.m.CampLimitDefault = 1;
	}

// New Overrides
	function findTileToSpawn()
	{
		local minDistToSettlements = 10;
		local maxDistToSettlements = 1000;
		local minDistToEnemyLocations = 5;
		local minDistToAlliedLocations = 5;
		local minY = 0.00;
		local maxY = 0.75;	// Not in the snow

		local disallowedTerrain = [];
		for (local i = 0; i < ::Const.World.TerrainType.COUNT; ++i )
		{
			// Bog Unholds only live in swamps or oasis.
			if (i == ::Const.World.TerrainType.Swamp || i == ::Const.World.TerrainType.Oasis)
			{
				continue;
			}

			disallowedTerrain.push(i);
		}

		local tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, disallowedTerrain, minDistToSettlements, maxDistToSettlements, 1000, minDistToEnemyLocations, minDistToAlliedLocations, null, minY, maxY);

		return tile;
	}
});

