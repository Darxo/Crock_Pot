::CrockPot.HooksMod.hook("scripts/entity/world/settlement", function(q) {
	q.onUpdateShopList = @(__original) function( _id, _list )
	{
		if (this.getSize() >= 3 || this.isMilitary())
		{
			_list.push({
				R = 95,
				P = 1.0,
				S = "accessory/cp_hawk_item"
			});

			_list.push({
				R = 95,
				P = 1.0,
				S = "accessory/cp_owl_item"
			});
		}

		__original(_id, _list);
	}
});
