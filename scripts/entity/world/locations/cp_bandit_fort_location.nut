this.cp_bandit_fort_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "A stone fortress, where elite bandits train, plan their raids, and revel in luxury from their plundered treasures.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.cp_bandit_fort";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.human_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Palisade;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(::Const.World.Spawn.BanditDefenders);
		this.m.Resources = 300;
		this.m.NamedShieldsList = ::Const.Items.NamedBanditShields;
	}

	function onSpawned()
	{
		this.m.Name = ::World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.BanditCamp);
		this.location.onSpawned();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(::Math.rand(200, 600), _lootTable);
		this.dropArmorParts(::Math.rand(20, 40), _lootTable);
		this.dropAmmo(::Math.rand(0, 40), _lootTable);
		this.dropMedicine(::Math.rand(3, 13), _lootTable);
		local treasure = [
			"trade/furs_item",
			"trade/copper_ingots_item",
			"trade/cloth_rolls_item",
			"trade/salt_item",
			"trade/amber_shards_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",

			// New compared to bandit_camp
			"loot/looted_valuables_item",
			"loot/valuable_furs_item",
		];

		// Heavily polute the pool so that further additions are very unlikely
		treasure.extend(treasure);
		treasure.extend(treasure);
		treasure.extend(treasure);

		// Add upgrades to the pool
		treasure.push("armor_upgrades/metal_plating_upgrade");
		treasure.push("armor_upgrades/metal_pauldrons_upgrade");
		treasure.push("armor_upgrades/mail_patch_upgrade");
		treasure.push("armor_upgrades/leather_shoulderguards_upgrade");
		treasure.push("armor_upgrades/leather_neckguard_upgrade");
		treasure.push("armor_upgrades/joint_cover_upgrade");
		treasure.push("armor_upgrades/heraldic_plates_upgrade");
		treasure.push("armor_upgrades/double_mail_upgrade");
		this.dropTreasure(::Math.rand(2, 3), treasure, _lootTable);

		this.dropFood(::Math.rand(3, 7), [
			"bread_item",
			"beer_item",
			"dried_fruits_item",
			"ground_grains_item",
			"roots_and_berries_item",
			"pickled_mushrooms_item",
			"smoked_ham_item",
			"mead_item",
			"cured_venison_item",
			"goat_cheese_item"
		], _lootTable);

		if (::Math.rand(1, 100) <= 10)
		{
			local paint = [];
			paint.push("misc/paint_set_item");
			paint.push("misc/paint_black_item");
			paint.push("misc/paint_red_item");
			paint.push("misc/paint_orange_red_item");
			paint.push("misc/paint_white_blue_item");
			paint.push("misc/paint_white_green_yellow_item");
			this.dropTreasure(1, paint, _lootTable);
		}
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_bandit_camp_03");
	}

	// This type of location is deprecated because it is superseded by the T3 Bandit Location introduced by Reforged
	function onDeserialize( _in )
	{
		this.location.onDeserialize(_in);
		this.fadeOutAndDie();
	}

});

