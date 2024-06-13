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
		this.m.Resources = 120;
		this.m.VisibilityMult = 0.75;	// Caves are harder to spot. TODO: make them harder to spot once they are mentioned in rumors and send roamer

		// Todo: add beast specific suffixes to the cave name? Something like "of the slithering" for a Snake den
	}

	function onSpawned()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.Cave);
		this.location.onSpawned();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(::Math.rand(0, 5), _lootTable);
		this.dropFood(::Math.rand(0, 1), [
			"strange_meat_item"
		], _lootTable);

		// Probably taken off a dead human corpse
		this.dropTreasure(1, [
			"loot/signet_ring_item",
			"loot/bead_necklace_item",
			"loot/jade_broche_item",
			"loot/bead_necklace_item",
		], _lootTable);
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

});

