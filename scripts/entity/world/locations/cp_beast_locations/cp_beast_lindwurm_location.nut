this.cp_beast_lindwurm_location <- this.inherit("scripts/entity/world/locations/cp_beast_cave_location", {
	m = {},

	function create()
	{
		this.cp_beast_cave_location.create();
		this.m.TypeID = "location.cp_beast_lindwurm_location";
		this.m.CP_CanSpawnRoamer = true;
	}

// New Functions
	function spawnScaledRoamingParty( _scaling = 0.5 )
	{
		local resources = this.getResources() * _scaling * this.getDayScalingMult();
		local faction = ::World.FactionManager.getFaction(this.getFaction());
		local party = faction.spawnEntity(this.getTile(), "Lindwurms", false, this.getRoamerSpawnList(), resources);
		party.setDescription("A Lindwurm - a wingless bipedal dragon resembling a giant snake.");
		party.setFootprintType(::Const.World.FootprintsType.Lindwurms);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.getSprite("banner").setBrush("banner_beasts_01");
		party.setLooting(false);
		return party;
	}

	function getLikeableTerrain()
	{
		return [
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.Desert,
			::Const.World.TerrainType.Steppe,
		];
	}
});

