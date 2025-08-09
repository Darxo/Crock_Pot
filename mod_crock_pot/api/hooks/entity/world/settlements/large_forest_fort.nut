::CrockPot.HooksMod.hook("scripts/entity/world/settlements/large_forest_fort", function(q) {
// Hardened Functions
	q.CP_getApplicableRandomSituations = @(__original) function()
	{
		local ret = __original();

		ret.add("hunting_season_situation", 12);

		return ret;
	}
});
