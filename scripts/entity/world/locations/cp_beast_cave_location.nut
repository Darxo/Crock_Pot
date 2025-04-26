this.cp_beast_cave_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "Amidst rugged terrain, a cave entrance invites exploration into the unknown depths.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.beast_cave";
		this.m.LocationType = ::Const.World.LocationType.Lair | ::Const.World.LocationType.Passive;
		this.m.IsDespawningDefenders = false;
		// this.m.IsShowingDefenders = false;
		// this.m.IsShowingBanner = false;
		// this.setDefenderSpawnList(::Const.World.Spawn.BerserkersOnly);
		this.m.Resources = 140;
		this.m.VisibilityMult = 0.4;	// Caves are much harder to spot than regular locations
	}

	function onSpawned()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.Cave);
		this.location.onSpawned();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);

		// One treasure item is guaranteed
		this.dropTreasure(1, [	// Probably taken off a dead human corpse
			"loot/signet_ring_item",
			"loot/bead_necklace_item",
			"loot/jade_broche_item",
			"loot/bead_necklace_item",
		], _lootTable);

		// Then you either find a second treasure, or some strange meat and armor parts (fresh game?)
		if (::Math.rand(1, 3) == 1)
		{
			this.dropTreasure(1, [
				"loot/signet_ring_item",
				"loot/bead_necklace_item",
				"loot/jade_broche_item",
				"loot/bead_necklace_item",
			], _lootTable);
		}
		else
		{
			this.dropArmorParts(::Math.rand(5, 10), _lootTable);
			this.dropFood(1, [
				"strange_meat_item"
			], _lootTable);
		}
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");

		if (this.getTile().Type == ::Const.World.TerrainType.Steppe)
		{
			body.setBrush("world_cave_steppe_01");
		}
		else
		{
			body.setBrush("world_cave_01");
		}
	}

	function onDeserialize( _in )
	{
		this.location.onDeserialize(_in);
		if (this.getDefenderSpawnListId() == "")
		{
			this.fadeOutAndDie();
		}
	}

});

