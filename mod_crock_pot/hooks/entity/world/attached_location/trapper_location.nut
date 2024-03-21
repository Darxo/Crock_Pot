::CrockPot.HooksMod.hook("scripts/entity/world/attached_location/trapper_location", function(q) {
	q.onUpdateShopList = @(__original) function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 95,
				P = 1.0,
				S = "accessory/cp_owl_item"
			});
		}

		__original(_id, _list);
	}
});
