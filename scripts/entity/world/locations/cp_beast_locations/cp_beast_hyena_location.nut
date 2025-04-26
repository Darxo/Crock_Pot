this.cp_beast_hyena_location <- this.inherit("scripts/entity/world/locations/cp_beast_cave_location", {
	m = {},

	function create()
	{
		this.cp_beast_cave_location.create();
		this.m.TypeID = "location.cp_beast_hyena_location";
		this.m.CP_CanSpawnRoamer = true;
	}

// New Functions
	function spawnScaledRoamingParty( _scaling = 0.5 )
	{
		local resources = this.getResources() * _scaling * this.getDayScalingMult();
		local faction = ::World.FactionManager.getFaction(this.getFaction());
		local party = faction.spawnEntity(this.getTile(), "Hyenas", false, this.getRoamerSpawnList(), resources);
		party.setDescription("A pack of esurient hyenas on the hunt for prey.");
		party.setFootprintType(::Const.World.FootprintsType.Hyenas);
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
			::Const.World.TerrainType.Desert,
			::Const.World.TerrainType.Oasis,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills,
		];
	}
});

