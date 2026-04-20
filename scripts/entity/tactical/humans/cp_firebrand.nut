this.cp_firebrand <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.CP_Firebrand;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.CP_Firebrand.XP;
		this.human.create();

		// Southern Appearance
		this.m.Bodies = ::Const.Bodies.SouthernMale;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;

		this.m.CP_ChestWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/armor/wanderers_coat"],
			[12, "scripts/items/armor/reinforced_leather_tunic"],
		]);

		this.m.CP_HelmetWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/helmets/physician_mask"],
			[12, "scripts/items/helmets/masked_kettle_helmet"],
		]);

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/weapons/javelin"],
			[12, "scripts/items/weapons/throwing_axe"],
		]);

		// this.m.AIAgent = ::new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");

		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();

		local b = this.getBaseProperties();
		b.setValues(::Const.Tactical.Actor.CP_Firebrand);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.getSkills().add(::new("scripts/skills/perks/perk_backstabber"));
		this.getSkills().add(::new("scripts/skills/perks/perk_anticipation"));
		this.getSkills().add(::new("scripts/skills/perks/perk_dodge"));
		this.getSkills().add(::new("scripts/skills/perks/perk_hold_out"));
		this.getSkills().add(::new("scripts/skills/perks/perk_footwork"));
		this.getSkills().add(::new("scripts/skills/perks/perk_mastery_throwing"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_offhand_training"));

		if (::Hooks.hasMod("mod_hardened"))
		{
			this.getSkills().add(::new("scripts/skills/perks/perk_hd_elusive"));
		}
		else
		{
			this.getSkills().add(::new("scripts/skills/perks/perk_pathfinder"));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;

		local namedItem = ::MSU.Class.WeightedContainer([
			[12, ::MSU.Class.WeightedContainer([
				[12, "scripts/items/weapons/named/named_throwing_axe"],
				[12, "scripts/items/weapons/named/named_javelin"],
			])],
			[12, ::MSU.Class.WeightedContainer([
				[12, "scripts/items/armor/named/black_leather_armor"],
			])],
		]).roll().roll();
		this.getItems().equip(::new(namedItem));

		return true;
	}

	function assignRandomEquipment()
	{
		// Source of endless utility items
		this.getItems().equip(::new("scripts/items/accessory/cp_bottomless_bag"));

		// secondary weapon
		this.getItems().addToBag(::new("scripts/items/weapons/battle_whip"));
	}
});
