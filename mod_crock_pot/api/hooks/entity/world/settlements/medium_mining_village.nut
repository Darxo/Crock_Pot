::CrockPot.HooksMod.hook("scripts/entity/world/settlements/medium_mining_village", function(q) {
// Hardened Functions
	q.CP_getApplicableRandomSituations = @(__original) function()
	{
		local ret = __original();

		ret.add("mine_cavein_situation", 12);
		ret.add("rich_veins_situation", 12);

		return ret;
	}
});
