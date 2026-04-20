this.cp_bottomless_bag_effect <- ::inherit("scripts/skills/skill", {
	m = {
		RandomItemChoices = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/tools/acid_flask_item"],
			[12, "scripts/items/tools/daze_bomb_item"],
			[12, "scripts/items/tools/fire_bomb_item"],
		]),
	},
	function create()
	{
		this.m.ID = "effects.cp_bottomless_bag";
		this.m.Name = "Bottomless Bag";
		this.m.Description = "You are carrying a bag with a sheer endless supply of utility items";
		this.m.Icon = "ui/perks/perk_20.png";	// Bags and Belts icon
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local possibleItemChoices = [];
		local i = 100;
		foreach (itemScript in this.m.RandomItemChoices.toArray())
		{
			local item = ::new(itemScript);
			possibleItemChoices.push({
				id = i,
				type = "text",
				icon = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedItemImage(item)),
				text = ::Reforged.Mod.Tooltips.parseString(format("[%s|Item+%s]", item.getName(), item.ClassName)),
			});
			++i;
		}

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("At the end of your turn, equip one of the following items at random"),
			children = possibleItemChoices,
		});

		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().IsStunned)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will not trigger because you are [stunned|Skill+stunned_effect]"),
			});
		}
		else if (actor.getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will not trigger because you are fleeing"),
			});
		}
		else
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/unlocked_small.png",
				text = ::Reforged.Mod.Tooltips.parseString("Does not trigger while [stunned|Skill+stunned_effect] or fleeing"),
			});
		}

		return ret;
	}

	function onTurnEnd()
	{
		if (this.isEnabled())
		{
			local randomItem = ::new(this.m.RandomItemChoices.roll());
			local actor = this.getContainer().getActor();

			// First we unequip anything that is sitting in the slot, that the newly generated item is for
			// This is done, so that NPCs are not softlocked into an item, which there is no use for (e.g. all enemies are immune)
			local existingItem = actor.getItems().getItemAtSlot(randomItem.getSlotType());
			if (existingItem != null) actor.getItems().unequip(existingItem);

			if (actor.getItems().equip(randomItem))
			{
				randomItem.playInventorySound(::Const.Items.InventoryEventType.Equipped);
				this.spawnIcon("cp_bottomless_bag_effect", actor.getTile());
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " equips " + ::MSU.Text.colorPositive(randomItem.getName()));
			}
		}
	}

// New Functions
	function isEnabled()
	{
		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().IsStunned) return false;
		if (actor.getMoraleState() == ::Const.MoraleState.Fleeing) return false;

		return true;
	}
});
