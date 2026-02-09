this.cp_crowntaker <- this.inherit("scripts/entity/tactical/humans/bounty_hunter", {
	m = {},
	function create()
	{
		// Switcheroo, so that bounty_hunter::create assigns the correct name, because it overwrites our assigned one with BountyHunter
		local oldEntityType = ::Const.EntityType.BountyHunter;
		::Const.EntityType.BountyHunter = ::Const.EntityType.CP_Crowntaker;
		this.bounty_hunter.create();
		::Const.EntityType.BountyHunter = oldEntityType;

		this.m.Type = ::Const.EntityType.CP_Crowntaker;
		this.m.XP = ::Const.Tactical.Actor.CP_Crowntaker.XP;

		this.m.CP_HelmetWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/helmets/nordic_helmet"],
			[12, "scripts/items/helmets/barbute_helmet"],
		]);

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[16, "scripts/items/weapons/fighting_spear"],
			[16, "scripts/items/weapons/fighting_axe"],
			[16, "scripts/items/weapons/shamshir"],
			[16, "scripts/items/weapons/three_headed_flail"],
			[16, "scripts/items/weapons/winged_mace"],
		]);

		this.m.CP_ChanceForNoOffhand = 30;
		this.m.CP_OffhandWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/tools/reinforced_throwing_net"],
		]);

		if (::Hooks.hasMod("mod_hardened"))
		{
			// If Hardened present, we turn off its Offhand generation to prevent a normal net from being added
			this.m.ChanceForNoOffhand = 100;
		}
	}

	function onInit()
	{
		this.bounty_hunter.onInit();

		this.CP_onInitSprites();
		this.CP_onInitStatsAndSkills();
	}

	function assignRandomEquipment()
	{
		this.bounty_hunter.assignRandomEquipment()

		this.CP_assignArmor();
		this.CP_assignOtherGear();
	}

// New Functions
	// Assign Socket and adjust Sprites
	function CP_onInitSprites()
	{
	}

	// Assign Stats and Unconditional Immunities, Perks and Actives
	function CP_onInitStatsAndSkills()
	{
		// Tweak Base Properties
		local b = this.getBaseProperties();
		b.setValues(::Const.Tactical.Actor.CP_Crowntaker);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;

		// Generic Perks
		this.getSkills().add(::new("scripts/skills/perks/perk_anticipation"));
		this.getSkills().add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_small_target"));

		this.getSkills().add(::new("scripts/skills/perks/perk_rf_angler"));
		this.getSkills().add(::new("scripts/skills/perks/perk_mastery_throwing"));
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
