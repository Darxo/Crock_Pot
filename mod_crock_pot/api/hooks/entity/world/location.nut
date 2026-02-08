::CrockPot.HooksMod.hook("scripts/entity/world/location", function(q) {
	// Public
	q.m.CP_TacticalTypeOverwrite <- null;	// Define custom TacticalType that should be used when fighting this location

	// Define custom engage image to be displayed when fighting at this location
	// Must also have a _night variant for when you fight at night
	q.m.CP_EngageImageOverwrite <- null;
});
