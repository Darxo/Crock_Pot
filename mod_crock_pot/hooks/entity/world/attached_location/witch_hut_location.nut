::CrockPot.HooksMod.hook("scripts/entity/world/locations/legendary/witch_hut_location", function(q) {
	q.onSpawned = @(__original) function()
	{
		__original();

		this.m.Name = "The Witch Hut";	// Vanilla: Witch Hut
	}
});
