this.cp_build_beast_camp_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		// Config
		CampLimitDefault = 1,	// This many camps can be present from Day 1
		DefenderSpawnlistId = "",	// Must be set by an inheriting class
	},
	function create()
	{
		// this.m.IsRunOnNewCampaign = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		local settlements = _faction.getSettlements();

		local foundCaves = 0;
		foreach (cave in settlements)
		{
			if (cave.getDefenderSpawnListId() == this.m.DefenderSpawnlistId)	// Cheap way to identify our related caves quickly
			{
				foundCaves++;
			}
		}

		if (foundCaves >= this.getCampLimit())
		{
			return;
		}

		this.m.Score = 2;
	}

	function onExecute( _faction )
	{
		local tile = this.findTileToSpawn();
		if (tile != null)
		{
			local camp = ::World.spawnLocation("scripts/entity/world/locations/cp_beast_cave_location", tile.Coords);
			if (camp != null)	// This creation might fail for some reason. Not sure though as it's in the exe
			{
				camp.setDefenderSpawnListId(this.m.DefenderSpawnlistId)
				camp.onSpawned();
				camp.setBanner("banner_beasts_01");
				_faction.addSettlement(camp, false);
			}
		}
	}

// New Functions
	function getCampLimit()
	{
		return this.m.CampLimitDefault;
	}

	function findTileToSpawn()
	{
		local minDistToSettlements = 7;
		local maxDistToSettlements = 1000;
		local minDistToEnemyLocations = 5;
		local minDistToAlliedLocations = 5;
		local minY = 0.2;
		local maxY = 0.75;

		local tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [
			::Const.World.TerrainType.Mountains,
			::Const.World.TerrainType.Snow
		], minDistToSettlements, maxDistToSettlements, 1000, minDistToEnemyLocations, minDistToAlliedLocations, null, minY, maxY);

		return tile;
	}
});

