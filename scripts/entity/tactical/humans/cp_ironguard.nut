this.cp_ironguard <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.Type = ::Const.EntityType.CP_Ironguard;
		this.m.XP = ::Const.Tactical.Actor.CP_Ironguard.XP;

		this.human.create();

		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.All;

		this.m.CP_ChestWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/armor/rf_breastplate"],
			[12, "scripts/items/armor/rf_reinforced_footman_armor"],
			[36, "scripts/items/armor/sellsword_armor"],		// Most iconic armor piece
		]);

		this.m.CP_HelmetWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/helmets/barbarians/heavy_horned_plate_helmet"],
			[12, "scripts/items/helmets/decayed_great_helm"],
		]);

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/weapons/flail"],
			[12, "scripts/items/weapons/warhammer"],
			[12, "scripts/items/weapons/winged_mace"],
		]);

		this.m.CP_OffhandWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/shields/greenskins/orc_heavy_shield"],
		]);

		if (::Hooks.hasMod("mod_hardened"))
		{
			this.m.AIAgent = ::new("scripts/ai/tactical/agents/hd_generic_carry_agent");
		}
		else
		{
			this.m.AIAgent = ::new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		}

		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();

		local b = this.getBaseProperties();
		b.setValues(::Const.Tactical.Actor.CP_Ironguard);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.getSkills().add(::new("scripts/skills/perks/perk_battle_forged"));
		this.getSkills().add(::new("scripts/skills/perks/perk_hold_out"));
		this.getSkills().add(::new("scripts/skills/perks/perk_shield_expert"));
		this.getSkills().add(::new("scripts/skills/perks/perk_underdog"));

		this.getSkills().add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_finesse"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_line_breaker"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_survival_instinct"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_the_rush_of_battle"));

		if (::Hooks.hasMod("mod_hardened"))
		{
			this.getSkills().add(::new("scripts/skills/perks/perk_hd_warden"));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;

		local namedItem = ::MSU.Class.WeightedContainer([
			[12, ::MSU.Class.WeightedContainer([
				[12, "scripts/items/weapons/named/named_mace"],
				[12, "scripts/items/weapons/named/named_warhammer"],
				[12, "scripts/items/weapons/named/named_flail"],
			])],
			[12, ::MSU.Class.WeightedContainer([
				[12, "scripts/items/shields/named/named_orc_heavy_shield"],
			])],
		]).roll().roll();
		this.getItems().equip(::new(namedItem));

		return true;
	}

// Reforged Functions
	function onSpawned()
	{
	}
});
