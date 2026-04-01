::CrockPot.HooksMod.hook("scripts/items/item", function(q) {
	// Vanilla Fix: Some Recipes accepting multiple different types of items
	// We do this by making every item return its ClassNameHash, which we assume to be unique to any item script file
	// Recipes use full item script paths for declaring ingredients. That is why we fix this by warping the return value of the getID function of all items
	q.getID = @(__original) function()
	{
		if (::CrockPot.Global.IsViewingRecipes)
		{
			return this.ClassNameHash;
		}

		return __original();
	}

	q.addSkill = @(__original) function( _skill )
	{
		if (_skill.m.CP_IsAttachedSkill && ::isKindOf(this, "weapon"))
		{
			// AttachedSkills, which are added to a weapon while that weapon is not in its ideal slot, will instead be added to its dormant effects
			if (this.getCurrentSlotType() != this.getSlotType())
			{
				this.m.CP_DormantAttachedEffects.push(_skill);
				return;
			}
		}

		return __original(_skill);
	}
});
