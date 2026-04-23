this.cp_hooded_man <- this.inherit("scripts/entity/tactical/enemies/necromancer", {
	m = {},
	function create()
	{
		this.necromancer.create();
		this.m.Type = ::Const.EntityType.CP_HoodedMan;
		this.m.Name = ::Const.Strings.EntityName[this.m.Type];	// This is normally done within create of human, but at that point we havent set the type yet
		this.m.XP = ::Const.Tactical.Actor.CP_HoodedMan.XP;

		this.m.BeardChance = 100;	// So that you can see the black hair as this is the "younger" variant of the necromancer
		this.m.HairColors = ["black"];	// In Vanilla necromancer have black and grey, but we reserve grey for the higher tier one

		this.m.CP_ChestWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/armor/ragged_dark_surcoat"],
			[12, "scripts/items/armor/thick_dark_tunic"],
			[12, "scripts/items/armor/ragged_surcoat"],
		]);

		this.m.CP_HelmetWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/helmets/witchhunter_hat"],
			[12, "scripts/items/helmets/dark_cowl"],
			[12, "scripts/items/helmets/hood"],
		]);

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/weapons/dagger"],
			[12, "scripts/items/weapons/butchers_cleaver"],
		]);
	}

	function onInit()
	{
		this.necromancer.onInit();

		local b = this.getBaseProperties();
		b.setValues(::Const.Tactical.Actor.CP_HoodedMan);
		this.m.CurrentProperties = clone b;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;

		this.getSprite("dirt").Visible = false;		// we don't reuse the glowing eyes
		this.getSkills().removeByID("perk.rf_soul_link");
		this.getSkills().removeByID("perk.inspiring_presence");
	}

	function assignRandomEquipment()
	{
		local helmet = this.getHeadItem();
		if (helmet != null && helmet.getID() == "armor.head.hood")
		{
			helmet.setVariant(63);
		}
	}
});

