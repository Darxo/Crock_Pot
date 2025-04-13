this.cp_ayahuasca <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "consumable.cp_ayahuasca";
		this.m.Name = "Ayahuasca";
		this.m.Description = "Experience a higher state of consciousness and unlock the ability to learn advanced perks sooner than before.";
		this.m.Icon = "consumables/cp_ayahuasca.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 1800;
	}

	function getTooltip()
	{
		local result = this.item.getTooltip();

		result.push({
			id = 65,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Increase your [Perk Tier|Concept.PerkTier] by " + ::MSU.Text.colorPositive("1"))
		});
		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		result.push({
			id = 70,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Causes temporary sickness"
		});
		return result;
	}

	function isUsable()
	{
		return this.m.IsUsable;
	}

	function onUse( _actor, _item = null )
	{
		// Same sound effect as Anatomist Potions
		::Sound.play("sounds/combat/drink_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);

		// Main Effect
		_actor.setPerkTier(_actor.getPerkTier() + 1);

		// guaranteed Side-Effect
		if (_actor.getSkills().hasSkill("injury.sickness"))
		{
			_actor.getSkills().getSkillByID("injury.sickness").addHealingTime(::Math.rand(1, 3));
		}
		else
		{
			_actor.getSkills().add(::new("scripts/skills/injury/sickness_injury"));
		}

		return true;
	}

});

