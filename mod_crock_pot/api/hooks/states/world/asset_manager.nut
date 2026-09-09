::CrockPot.HooksMod.hook("scripts/states/world/asset_manager", function(q) {
// Private
	q.m.CP_LastSunrise <- 0;	// Last day at which we witnessed night turning into day
	q.m.CP_IsUpdating <- false;		// Is true during asset_manager.update(). Can be used to apply certain changes only during such an update loop

	q.update = @(__original) { function update( _worldState )
	{
		if (::World.getTime().Days > this.m.CP_LastSunrise)
		{
			this.m.CP_LastSunrise = ::World.getTime().Days;		// NewDay can only trigger once per day

			// Feat: trigger CP_onNewDay event for world locations
			foreach (worldEntity in ::World.getAllEntitiesAtPos(::World.State.getPlayer().getPos(), 9000000))
			{
				if (worldEntity.isLocation()) worldEntity.CP_onNewDay();
			}
		}

		this.m.CP_IsUpdating = true;
		__original(_worldState);
		this.m.CP_IsUpdating = false;
	}}.update;

	q.onDeserialize = @(__original) { function onDeserialize( _in )
	{
		__original(_in);

		this.m.CP_LastSunrise = ::World.getTime().Days;
	}}.onDeserialize;
});
