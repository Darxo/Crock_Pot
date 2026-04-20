::CrockPot.HooksMod.hook("scripts/entity/world/locations/orc_cave_location", function(q) {
	q.m.CP_TacticalTypeOverwrite = "tactical.CP_cave";
	q.m.CP_EngageImageOverwrite = "engage/cp_engage_cave";
	q.m.CP_TacticalTextOverwrite = "in a cave";

	q.create = @(__original) function()
	{
		__original();

		// We no longer show the banner or defender of this location so that the player has to guess, whether it is orcs or beasts
		this.m.IsShowingBanner = false;
		this.m.IsShowingDefenders = false;	// Vanilla: true
	}

	// We mirror the default cave description to hide the fact that this is an orc location
	q.getDescription = @() function()
	{
		return "Amidst rugged terrain, a cave entrance invites exploration into the unknown depths.";
	}

	q.onSpawned = @(__original) function()
	{
		__original();
		// We mirror the default cave name generation to hide the fact that this is an orc location
		this.m.Name = ::World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.Cave);
	}
});
