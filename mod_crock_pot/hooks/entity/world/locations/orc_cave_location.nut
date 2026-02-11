::CrockPot.HooksMod.hook("scripts/entity/world/locations/orc_cave_location", function(q) {
	q.m.CP_TacticalTypeOverwrite = "tactical.CP_cave";
	q.m.CP_EngageImageOverwrite = "engage/cp_engage_cave";
});
