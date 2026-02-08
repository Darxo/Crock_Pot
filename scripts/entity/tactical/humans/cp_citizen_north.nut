this.cp_citizen_north <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.Type = ::Const.EntityType.CP_CitizenNorth;
		this.m.XP = ::Const.Tactical.Actor.CP_Citizen.XP;

		this.human.create();

		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.Young;
		this.m.Beards = ::Const.Beards.All;

		this.m.AIAgent = ::new("scripts/ai/tactical/agents/militia_melee_agent");
		this.m.AIAgent.setActor(this);

		this.m.CP_ChestWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/armor/leather_tunic"],
			[12, "scripts/items/armor/thick_tunic"],
			[12, "scripts/items/armor/ragged_surcoat"],
		]);

		// this.m.CP_ChanceForNoHelmet = 80;
		this.m.CP_HelmetWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/helmets/hood"],
			[12, "scripts/items/helmets/aketon_cap"],
			[12, "scripts/items/helmets/feathered_hat"],
			[6, "scripts/items/helmets/open_leather_cap"],
		]);

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/weapons/bludgeon"],
			[12, "scripts/items/weapons/hatchet"],
			[12, "scripts/items/weapons/militia_spear"],
			[12, "scripts/items/weapons/shortsword"],
			[6, "scripts/items/weapons/short_bow"],
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
		b.setValues(::Const.Tactical.Actor.CP_Citizen);		// Shared between North and South variant
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
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			if (weapon.isWeaponType(::Const.Items.WeaponType.Bow))
			{
				this.getItems().equip(::new("scripts/items/ammo/quiver_of_arrows"));
				this.getItems().addToBag(::new("scripts/items/weapons/knife"));

				// A citizen with a shortbow will sometimes spawn with a fitting hunters hat
				if (::Math.rand(1, 2) == 1)
				{
					if (this.getHeadItem() != null) this.getItems().unequip(this.getHeadItem());
					this.getItems().equip(::new("scripts/items/helmets/hunters_hat"));
				}
			}
		}
	}
});
