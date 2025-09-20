this.cp_beast_hexe_location <- this.inherit("scripts/entity/world/locations/cp_beast_cave_location", {
	m = {},

	function create()
	{
		this.cp_beast_cave_location.create();
		this.m.TypeID = "location.cp_beast_hexe";

		this.m.CP_CanSpawnRoamer = true;
		this.m.Resources *= 1.5;	// Hexen Locations have 50% more resources than a regular cave
	}

	function getDescription()
	{
		return "A skewed and withered hut that looks like it could collapse at any moment. Smoke is rising from an awry chimney.";
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_witch_hut");
	}

	function onSpawned()
	{
		this.m.Name = ::World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.WitchHut);
		this.location.onSpawned();
	}

// New Functions
	function spawnScaledRoamingParty( _scaling )
	{
		local resources = this.getResources() * _scaling;
		local faction = ::World.FactionManager.getFaction(this.getFaction());
		local party = faction.spawnEntity(this.getTile(), "Hexen", false, this.getRoamerSpawnList(), resources);
		party.setDescription("A malevolent old crone, said to lure and abduct little children to make broth and concoctions out of, strike sinister pacts with villagers, and weave curses.");
		party.setFootprintType(::Const.World.FootprintsType.Hexen);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.getSprite("banner").setBrush("banner_beasts_01");
		party.setLooting(false);

		party.setVisibilityMult(1.0);	// Hexen don't know how to hide
		party.setMovementSpeed(party.getBaseMovementSpeed() * 0.8);  // Hexen are not very fast

		return party;
	}

	function getLikeableTerrain()
	{
		return [
			::Const.World.TerrainType.Land,
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.Urban,
			::Const.World.TerrainType.Farmland,
			::Const.World.TerrainType.Badlands,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Steppe,
		];
	}
});

