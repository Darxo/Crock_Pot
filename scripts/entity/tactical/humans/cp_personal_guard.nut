this.cp_personal_guard <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.Type = ::Const.EntityType.CP_PersonalGuard;
		this.m.XP = ::Const.Tactical.Actor.CP_PersonalGuard.XP;

		this.human.create();

		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.Young;
		this.m.Beards = ::Const.Beards.All;

		this.m.AIAgent = ::new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.m.Properties.PreferWait = true;	// To make use of the high Initiative and Relentless
		this.m.AIAgent.setActor(this);

		this.m.CP_ChestWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/armor/padded_leather"],
			[12, "scripts/items/armor/leather_lamellar"],
		]);

		this.m.CP_HelmetWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/helmets/rf_padded_scale_helmet"],
			[6, "scripts/items/helmets/padded_nasal_helmet"],
			[6, "scripts/items/helmets/dented_nasal_helmet"],
		]);

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/weapons/falchion"],
			[12, "scripts/items/weapons/boar_spear"],
			[12, "scripts/items/weapons/oriental/light_southern_mace"],		// Fitting weapontype/damage range but questionable origin when spawned on northern guards
		]);

		this.m.CP_OffhandWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/shields/wooden_shield"],
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
		::Reforged.Skills.addMasteryOfEquippedWeapon(this);
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
		b.setValues(::Const.Tactical.Actor.CP_PersonalGuard);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;

		// Generic Effects
		this.getSkills().add(::new("scripts/skills/special/cp_vip_bodyguard"));

		// Generic Perks
		this.getSkills().add(::new("scripts/skills/perks/perk_relentless"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rotation"));
		this.getSkills().add(::new("scripts/skills/perks/perk_shield_expert"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_line_breaker"));
	}

	// Assign Head and Body armor to this character
	function CP_assignArmor()
	{
	}

	// Assign all other gear to this character
	function CP_assignOtherGear()
	{
		this.getItems().addToBag(::new("scripts/items/accessory/bandage_item"));
	}
});
