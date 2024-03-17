::CrockPot.HooksMod.hook("scripts/entity/world/attached_location/hunters_cabin_location", function(q) {
	q.onUpdateShopList = @(__original) function( _id, _list )
	{
		_list.push({
			R = 95,
			P = 1.0,
			S = "accessory/cp_hawk_item"
		});

		__original(_id, _list);
	}
});
