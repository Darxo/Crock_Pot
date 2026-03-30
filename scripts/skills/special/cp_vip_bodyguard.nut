// A hidden skill that is used in conjunction with the ai_rf_bodyguard behavior
// to make an entity behave as the dedicated bodyguard of a cp_vip
this.cp_vip_bodyguard <- ::inherit("scripts/skills/special/rf_bodyguard", {
	m = {
		// Public
		VIPType = null,		// Can be set to an EntityType, causing this unit to only seek out that VIP
	},
	function create()
	{
		this.rf_bodyguard.create();
		this.m.ID = "special.cp_vip_bodyguard";
	}

	function onCombatStarted()
	{
		// We search for a VIP to protect during this combat and register the closest one found to us
		local actor = this.getContainer().getActor();
		local myTile = this.getContainer().getActor().getTile();
		local closestValidVIP = null;
		local closestVIPDistance = 9000;
		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(actor.getFaction()))
		{
			// Maybe we need better checks to make sure that VIPTypes have higher priority
			if (this.m.VIPType != null && ally.getType() != this.m.VIPType)	continue; 	// That ally is not the VIPType that we are programmed to guard

			local vipSkill = ally.getSkills().getSkillByID("special.cp_vip");
			if (vipSkill == null) continue;
			if (!vipSkill.hasSpaceForBodyguards()) continue;
			if (!vipSkill.requiresBodyguards()) continue;

			local tileDistance = ally.getTile().getDistanceTo(myTile);
			if (tileDistance > closestVIPDistance) continue;

			closestValidVIP = ally;
			closestVIPDistance = tileDistance;
		}

		if (closestValidVIP == null) return;

		this.setVIP(closestValidVIP);
	}

// Reforged Functions
	function setVIP( _entity )
	{
		local vipSkill = _entity.getSkills().getSkillByID("special.cp_vip");
		if (vipSkill == null)
		{
			::logWarning("CrockPot: cp_vip_bodyguard::setVIP was called on a _entity that doesnt have special.cp_vip. This should not happen.")
			return;
		}
		vipSkill.registerBodyguard(_entity);

		this.rf_bodyguard.setVIP(_entity);		// calling the base function
	}
});
