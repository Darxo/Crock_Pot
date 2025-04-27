this.cp_beast_webknecht_location <- this.inherit("scripts/entity/world/locations/cp_beast_cave_location", {
	m = {},

	function create()
	{
		this.cp_beast_cave_location.create();
		this.m.TypeID = "location.cp_beast_webknecht_location";
		this.m.CP_CanSpawnRoamer = true;
	}

// New Functions
	function spawnScaledRoamingParty( _scaling = 0.5 )
	{
		local resources = this.getResources() * _scaling * this.getDayScalingMult();
		local faction = ::World.FactionManager.getFaction(this.getFaction());
		local party = faction.spawnEntity(this.getTile(), "Webknechts", false, this.getRoamerSpawnList(), resources);
		party.setDescription("A swarm of webknechts skittering about.");
		party.setFootprintType(::Const.World.FootprintsType.Spiders);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.getSprite("banner").setBrush("banner_beasts_01");
		party.setLooting(false);

		party.getFlags().set("IsWebknechts", true);

		party.setVisibilityMult(0.5);

		return party;
	}

	function getLikeableTerrain()
	{
		return [
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.AutumnForest,
		];
	}
});

