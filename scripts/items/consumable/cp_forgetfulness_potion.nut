this.cp_forgetfulness_potion <- this.inherit("scripts/items/item", {
	m = {
		RedundedPerks = 1,	// Amount of perks refunded, when drinking this potion
	},

	function create()
	{
		this.item.create();
		this.m.ID = "consumable.cp_forgetfulness_potion";
		this.m.Name = "Forgetfulness Potion";
		this.m.Description = "A single sip clouds the mind, wiping away what once was known.";
		this.m.Icon = "consumables/vial_blue_01.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 800;
	}

	function getTooltip()
	{
		local result = this.item.getTooltip();

		result.push({
			id = 65,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Refund two random perk points."
		});
		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});

		return result;
	}

	function isUsable()
	{
		return this.m.IsUsable;
	}

	function onUse( _actor, _item = null )
	{
		local refundablePerks = _actor.getSkills().getSkillsByFunction(@(skill) skill.isType(::Const.SkillType.Perk) && skill.isRefundable() && (skill.getItem() == null));
		if (refundablePerks.len() == 0) return false;	// Can't be used if there is nothing to refund

		// Same sound effect as Anatomist Potions
		::Sound.play("sounds/combat/drink_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);

		for (local i = 1; i <= this.m.RedundedPerks; ++i)
		{
			this.refundRandomPerk(_actor);
		}

		return true;
	}

// New Functions
	function refundRandomPerk( _actor )
	{
		local refundablePerks = _actor.getSkills().getSkillsByFunction(@(skill) skill.isType(::Const.SkillType.Perk) && skill.isRefundable() && (skill.getItem() == null));
		if (refundablePerks.len() == 0) return;

		::MSU.Array.rand(refundablePerks).removeSelf();
		_actor.m.PerkPoints++;
		_actor.m.PerkPointsSpent--;
		_actor.setPerkTier(::Math.max(_actor.getPerkTier() - 1, ::DynamicPerks.Const.DefaultPerkTier));
	}
});

