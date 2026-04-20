this.cp_sellsword <- this.inherit("scripts/entity/tactical/humans/mercenary", {
	m = {},
	function create()
	{
		// Switcheroo, so that mercenary::create assigns the correct name, because it overwrites our assigned one with Mercenary
		local oldEntityType = ::Const.EntityType.Mercenary;
		::Const.EntityType.Mercenary = ::Const.EntityType.CP_Sellsword;
		this.mercenary.create();
		::Const.EntityType.Mercenary = oldEntityType;

		this.m.Type = ::Const.EntityType.CP_Sellsword;
		this.m.XP = ::Const.Tactical.Actor.CP_Sellsword.XP;

		this.m.CP_ChestWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/armor/rf_breastplate"],
			[12, "scripts/items/armor/rf_reinforced_footman_armor"],
			[36, "scripts/items/armor/sellsword_armor"],		// Most iconic armor piece
		]);

		this.m.CP_HelmetWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/helmets/nordic_helmet"],
			[12, "scripts/items/helmets/barbute_helmet"],
			[12, "scripts/items/helmets/rf_half_closed_sallet"],
		]);

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/weapons/noble_sword"],
			[12, "scripts/items/weapons/fighting_spear"],
			[12, "scripts/items/weapons/warhammer"],
			[12, "scripts/items/weapons/military_cleaver"],
			[12, "scripts/items/weapons/winged_mace"],
			[12, "scripts/items/weapons/fighting_axe"],

			[6, "scripts/items/weapons/warbrand"],
			[6, "scripts/items/weapons/greataxe"],
			[6, "scripts/items/weapons/rf_kriegsmesser"],
			[6, "scripts/items/weapons/greatsword"],

			[6, "scripts/items/weapons/rf_halberd"],
			[6, "scripts/items/weapons/rf_swordstaff"],
		]);

		this.m.CP_OffhandWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/shields/heater_shield"],
			[12, "scripts/items/shields/kite_shield"],
			[12, "scripts/items/shields/wooden_shield"],
			[12, "scripts/items/tools/reinforced_throwing_net"],
		]);
	}

	function onInit()
	{
		this.mercenary.onInit();

		local b = this.getBaseProperties();
		b.setValues(::Const.Tactical.Actor.CP_Sellsword);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;

		this.getSkills().add(::new("scripts/skills/perks/perk_rf_poise"));
	}
});
