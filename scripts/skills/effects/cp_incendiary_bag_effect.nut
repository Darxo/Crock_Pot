// This effect is designed to be given to an actor, after their reload their weapon with a special kind of ammunition
// It lasts only for one attack with that weapon
this.cp_incendiary_bag_effect <- ::inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "effects.cp_incendiary_bag";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsHidden = true;
	}

// MSU Events
	// We need the timing of onBeforeAnySkillExecuted, because reloadHandgonne removes itself from the actor during execution
	// So there is a chance that after the execution, we can't know which weapon it was attached to, anymore
	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.getID() != "actives.reload_handgonne") return;

		local weapon = _skill.getItem();
		if (weapon == null) weapon = this.getContainer().getActor().getMainhandItem();

		if (weapon == null)
		{
			::logError("CrockPot: neither the itemSkill of reload_handgonne, nor the equipped mainHandItem exist. Loading effect could not be applied");
			return;
		}

		weapon.addSkill(::new("scripts/skills/effects/cp_loaded_incendiary_shot_effect"));
	}
});
