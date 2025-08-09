::CrockPot.HooksMod.hook("scripts/entity/world/settlements/large_steppe_village", function(q) {
// Hardened Functions
	q.CP_getApplicableRandomSituations = @(__original) function()
	{
		local ret = __original();

		ret.add("draught_situation", 12);
		ret.add("good_harvest_situation", 12);

		return ret;
	}
});
