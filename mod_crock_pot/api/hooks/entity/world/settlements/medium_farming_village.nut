::CrockPot.HooksMod.hook("scripts/entity/world/settlements/medium_farming_village", function(q) {
// Hardened Functions
	q.CP_getApplicableRandomSituations = @(__original) function()
	{
		local ret = __original();

		ret.add("draught_situation", 12);
		ret.add("good_harvest_situation", 12);

		return ret;
	}
});
