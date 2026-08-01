::CrockPot.HooksMod.hook("scripts/ai/world/orders/despawn_order", function(q) {
	q.onExecute = @(__original) function( _entity, _hasChanged )
	{
		local tileEntity = ::World.getEntityAtTile(_entity.getTile().Coords);
		if (tileEntity != null && tileEntity.isLocation())
		{
			// Feat: trigger CP_onPartyDespawn events, if there is a location on the disbanding location of this party
			tileEntity.CP_onPartyDespawn(_entity);
		}

		return __original(_entity, _hasChanged);
	}
});
