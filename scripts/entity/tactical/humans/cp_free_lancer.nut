this.cp_free_lancer <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.CP_FreeLancer;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.CP_FreeLancer.XP;

		this.human.create();

		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.All;

		this.m.CP_ChestWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/armor/decayed_coat_of_plates"],
			[12, "scripts/items/armor/decayed_coat_of_scales"],
		]);

		this.m.CP_HelmetWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/helmets/decayed_full_helm"],
		]);

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/weapons/pike"],
			[12, "scripts/items/weapons/ancient/bladed_pike"],
		]);

		if (::Hooks.hasMod("mod_hardened"))
		{
			this.m.AIAgent = ::new("scripts/ai/tactical/agents/hd_generic_carry_agent");
		}
		else
		{
			this.m.AIAgent = ::new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		}
		this.m.AIAgent.m.Properties.PreferWait = true;
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();

		local b = this.getBaseProperties();
		b.setValues(::Const.Tactical.Actor.CP_FreeLancer);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.getSkills().add(::new("scripts/skills/perks/perk_dodge"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_fresh_and_furious"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_vigorous_assault"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_savage_strength"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_skirmisher"));

		if (::Hooks.hasMod("mod_hardened"))
		{
			this.getSkills().add(::new("scripts/skills/perks/perk_rf_nailed_it"));
			this.getSkills().add(::new("scripts/skills/perks/perk_mastery_spear"));		// Spear Flurry = Free Attacks
			this.getSkills().add(::new("scripts/skills/perks/perk_rf_king_of_all_weapons"));	// Spear Flurry = Free Attacks
		}
		else
		{
			this.getSkills().add(::new("scripts/skills/perks/perk_rf_leverage"));	// Headshot chance alternative
			this.getSkills().add(::new("scripts/skills/perks/perk_rf_finesse"));	// Fatigue Discount alternative
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;

		local namedItem = ::MSU.Class.WeightedContainer([
			[12, ::MSU.Class.WeightedContainer([
				[12, "scripts/items/weapons/named/named_pike"],
				[12, "scripts/items/weapons/named/named_bladed_pike"],
			])],
		]).roll().roll();
		this.getItems().equip(::new(namedItem));

		return true;
	}
});
