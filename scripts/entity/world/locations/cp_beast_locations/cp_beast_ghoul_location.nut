this.cp_beast_ghoul_location <- this.inherit("scripts/entity/world/locations/cp_beast_cave_location", {
	m = {},

	function create()
	{
		this.cp_beast_cave_location.create();
		this.m.TypeID = "location.cp_beast_ghoul_location";
		this.m.CP_CanSpawnRoamer = true;
	}

// New Functions
	function spawnScaledRoamingParty( _scaling = 0.5 )
	{
		local resources = this.getResources() * _scaling * this.getDayScalingMult();
		local faction = ::World.FactionManager.getFaction(this.getFaction());
		local party = faction.spawnEntity(this.getTile(), "Nachzehrers", false, this.getRoamerSpawnList(), resources);
		party.setDescription("A flock of scavenging nachzehrers.");
		party.setFootprintType(::Const.World.FootprintsType.Ghouls);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.getSprite("banner").setBrush("banner_beasts_01");
		party.setLooting(false);

		party.setVisibilityMult(0.5);

		return party;
	}

	function getLikeableTerrain()
	{
		return [
			::Const.World.TerrainType.Land,
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.Urban,
			::Const.World.TerrainType.Farmland,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Badlands,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Desert,
			::Const.World.TerrainType.Oasis,
		];
	}
});

