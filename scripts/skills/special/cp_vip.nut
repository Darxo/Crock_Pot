// A hidden skill that is used in conjunction with the cp_vip_bodyguard skill and ai_rf_bodyguard behavior
// to make an entity behave as the dedicated very-important-person that is to be protected
this.cp_vip <- ::inherit("scripts/skills/skill", {
	m = {
		// Public
		BodyguardsMin = 1,	// How many Bodyguards should be assigned to this character at the very least?
		BodyguardsMax = 1,

		// Private
		Bodyguards = [],	// Weakreferences of all bodyguards protecting this character
	},
	function create()
	{
		this.m.ID = "special.cp_vip";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsSerialized = false;
		this.m.IsHidden = true;
	}

	function requiresBodyguards()
	{
		this.collectGarbage();
		return this.m.Bodyguards.len() < this.m.BodyguardsMin;
	}

	function hasSpaceForBodyguards()
	{
		this.collectGarbage();
		return this.m.Bodyguards.len() < this.m.BodyguardsMax;
	}

	function registerBodyguard( _entity )
	{
		this.m.Bodyguards.push(::MSU.asWeakTableRef(_entity));
	}

	function collectGarbage()
	{
		for (local i = this.m.Bodyguards.len() - 1; i >= 0; --i)
		{
			local bodyguard = this.m.Bodyguards[i];
			if (::MSU.isNull(bodyguard) || !bodyguard.isAlive())
			{
				this.m.Bodyguards.remove(i);
			}
		}
	}
});
