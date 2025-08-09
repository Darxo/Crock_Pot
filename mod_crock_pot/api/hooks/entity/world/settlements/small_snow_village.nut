::CrockPot.HooksMod.hook("scripts/entity/world/settlements/large_farming_village", function(q) {
// Hardened Functions
	q.CP_getApplicableRandomSituations = @(__original) function()
	{
		local ret = __original();

		ret.add("snow_storms_situation", 12);

		return ret;
	}
});
