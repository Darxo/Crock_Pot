::CrockPot.HooksMod.hook("scripts/crafting/crafting_manager", function(q) {
	q.getQualifiedBlueprintsForUI = @(__original) function()
	{
		::CrockPot.Global.IsViewingRecipes = true;
		local ret = __original();
		::CrockPot.Global.IsViewingRecipes = false;

		return ret;
	}
});
