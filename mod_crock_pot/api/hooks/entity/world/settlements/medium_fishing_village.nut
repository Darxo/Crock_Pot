::CrockPot.HooksMod.hook("scripts/entity/world/settlements/medium_fishing_village", function(q) {
// Hardened Functions
	q.CP_getApplicableRandomSituations = @(__original) function()
	{
		local ret = __original();

		ret.add("lost_at_sea_situation", 12);
		ret.add("full_nets_situation", 12);

		return ret;
	}
});
