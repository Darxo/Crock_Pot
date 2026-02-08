::CrockPot.HooksMod.hook("scripts/entity/tactical/humans/councilman", function(q) {
	q.create = @(__original) function()
	{
		// Switcheroo, so that actor::create assigns the correct name, because __original() overwrites our assigned one with Knight
		local oldEntityType = ::Const.EntityType.Knight;
		::Const.EntityType.Knight = ::Const.EntityType.CP_Councilman;
		__original();
		::Const.EntityType.Knight = oldEntityType;

		this.m.AIAgent = ::new("scripts/ai/tactical/agents/military_standard_bearer_agent");	// Vanilla: military_melee_agent
		this.m.AIAgent.setActor(this);
	}

	q.onInit = @(__original) function()
	{
		__original();
		this.setAppearance();

		this.getSkills().add(::Reforged.new("scripts/skills/special/cp_vip", function(o) {
			o.m.BodyguardsMax = 2;
		}));
	}

// Reforged Functions
	q.onSpawned = @(__original) function()
	{
		__original();

		// We assign the weapons here, because they would otherwise show up, when this entity is shown in the
		local weaponContainer = ::MSU.Class.WeightedContainer([	// Vanilla: No Weapon
			[12, "scripts/items/weapons/dagger"],
			[12, "scripts/items/weapons/shortsword"],
		]);

		if (this.getItems().hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.getItems().equip(::new(weaponContainer.roll()));
		}
	}
});
