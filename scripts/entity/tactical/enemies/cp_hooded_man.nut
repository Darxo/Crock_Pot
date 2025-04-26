this.cp_hooded_man <- this.inherit("scripts/entity/tactical/enemies/necromancer", {
	m = {},
	function create()
	{
		this.necromancer.create();
		this.m.Type = ::Const.EntityType.CP_HoodedMan;
		this.m.Name = this.Const.Strings.EntityName[this.m.Type];	// This is normally done within create of human, but at that point we havent set the type yet
		this.m.XP = ::Const.Tactical.Actor.CP_HoodedMan.XP;

		this.m.BeardChance = 100;	// So that you can see the black hair as this is the "younger" variant of the necromancer
		this.m.HairColors = ["black"];	// In Vanilla necromancer have black and grey, but we reserve grey for the higher tier one
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
		local r = ::Math.rand(1, 2);

		if (r == 1)
		{
			this.getItems().equip(::new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			this.getItems().equip(::new("scripts/items/weapons/butchers_cleaver"));
		}

		r = ::Math.rand(1, 2);
		if (r == 1)
		{
			this.getItems().equip(::new("scripts/items/armor/ragged_dark_surcoat"));
		}
		else if (r == 2)
		{
			this.getItems().equip(::new("scripts/items/armor/thick_dark_tunic"));
		}

		local r = ::Math.rand(1, 3);
		if (r == 1)
		{
			this.getItems().equip(::new("scripts/items/helmets/witchhunter_hat"));
		}
		else if (r == 2)
		{
			this.getItems().equip(::new("scripts/items/helmets/dark_cowl"));
		}
		else if (r == 3)
		{
			local hood = ::new("scripts/items/helmets/hood");
			hood.setVariant(63);
			this.getItems().equip(hood);
		}
	}
});

