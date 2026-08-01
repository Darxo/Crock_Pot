::CrockPot.HooksMod.hook("scripts/retinue/retinue_manager", function(q) {
	q.onNewDay = @(__original) function()
	{
		__original();

		// Feat: trigger CP_onNewDay event for world locations
		foreach (worldEntity in ::World.getAllEntitiesAtPos(::World.State.getPlayer().getPos(), 9000000))
		{
			if (worldEntity.isLocation()) worldEntity.CP_onNewDay();
		}
	}
});
