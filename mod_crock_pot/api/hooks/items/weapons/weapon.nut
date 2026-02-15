::CrockPot.HooksMod.hook("scripts/items/weapons/weapon", function(q) {
	// Attached effects are temporary skills, which are linked to this item
	// They will persist on the user of this item until the item is unequipped or the battle ends
	// Re-equipping the item will add the same skill back to the character
	q.m.CP_DormantAttachedEffects <- [];	// Hard references of all attached skills, so that they can persist in this array, while the item is not equipped

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		local dormantEffects = [];
		foreach (dormantEffect in this.m.CP_DormantAttachedEffects)
		{
			dormantEffects.push({
				id = 100,
				type = "text",
				icon = dormantEffect.getIconColored(),
				text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedSkillName(dormantEffect)),
			});
		}

		if (dormantEffects.len() != 0)
		{
			ret.push({
				id = 100,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Dormant Effects:"),
				children = dormantEffects,
			});
		}

		return ret;
	}

	q.onEquip = @(__original) function()
	{
		__original();

		// In order for dormant skills to show up correctly on the weapon tooltip, we can't have them be deleted as soon as they are equipped to the dummy player
		if (::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer())) return;

		foreach (attachedEffect in this.m.CP_DormantAttachedEffects)
		{
			// When an item is unequipped, vanilla clears all skills, putting their IsGarbage to true,
			// Even if we save a copy of the attached-effects, that flag is still set for them, so we need to reverse that flag at this point here
			attachedEffect.m.IsGarbage = false;
			this.addSkill(attachedEffect);
		}
		this.m.CP_DormantAttachedEffects = [];
	}

	q.onCombatFinished = @(__original) function()
	{
		__original();

		this.m.CP_DormantAttachedEffects = [];
	}

	q.clearSkills = @(__original) function()
	{
		if (::MSU.isNull(this.getContainer())) return;

		local actor = this.getContainer().getActor();
		if (::MSU.isNull(actor)) return;

		foreach (skill in this.m.SkillPtrs)
		{
			if (skill.isGarbage()) continue;
			if (!skill.m.CP_IsAttachedSkill) continue;

			this.m.CP_DormantAttachedEffects.push(skill);
		}

		__original();
	}
});
