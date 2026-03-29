this.cp_citizen_south <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.Type = ::Const.EntityType.CP_CitizenSouth;
		this.m.XP = ::Const.Tactical.Actor.CP_CitizenNorth.XP;

		this.human.create();

		this.m.Bodies = ::Const.Bodies.SouthernMale;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;

		this.m.AIAgent = ::new("scripts/ai/tactical/agents/militia_melee_agent");
		this.m.AIAgent.setActor(this);

		this.m.CP_ChestWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/armor/oriental/padded_vest"],
			[12, "scripts/items/armor/oriental/thick_nomad_robe"],
		]);

		this.m.CP_HelmetWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/helmets/feathered_hat"],
			[12, "scripts/items/helmets/oriental/southern_head_wrap"],
			[12, "scripts/items/helmets/oriental/nomad_head_wrap"],
		]);

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/weapons/bludgeon"],
			[12, "scripts/items/weapons/hatchet"],
			[12, "scripts/items/weapons/militia_spear"],
			[12, "scripts/items/weapons/shortsword"],
			[6, "scripts/items/weapons/staff_sling"],
		]);
	}

	function onInit()
	{
		this.human.onInit();

		this.CP_onInitSprites();
		this.CP_onInitStatsAndSkills();
	}

	function assignRandomEquipment()
	{
		this.CP_assignArmor();
		this.CP_assignOtherGear();
	}

// Reforged Functions
	function onSpawned()
	{
	}

// New Functions
	// Assign Socket and adjust Sprites
	function CP_onInitSprites()
	{
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_caravan");
	}

	// Assign Stats and Unconditional Immunities, Perks and Actives
	function CP_onInitStatsAndSkills()
	{
		// Tweak Base Properties
		local b = this.getBaseProperties();
		b.setValues(::Const.Tactical.Actor.CP_CitizenNorth);		// Shared between North and South variant
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;

		// Generic Perks
	}

	// Assign Head and Body armor to this character
	function CP_assignArmor()
	{
	}

	// Assign all other gear to this character
	function CP_assignOtherGear()
	{
	}
});
