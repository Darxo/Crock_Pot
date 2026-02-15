::CrockPot.HooksMod.hook("scripts/items/item", function(q) {
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
