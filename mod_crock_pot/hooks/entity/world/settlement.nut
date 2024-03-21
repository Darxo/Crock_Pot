::CrockPot.HooksMod.hook("scripts/entity/world/settlement", function(q) {
	q.onUpdateShopList = @(__original) function( _id, _list )
	{
		switch (_id)
		{
			case "building.alchemist":
			{
				_list.push({
					R = 75,
					P = 1.0,
					S = "accessory/cp_vulture_item"
				});

				_list.push({
					R = 75,
					P = 1.0,
					S = "accessory/cp_owl_item"
				});
				break;
			}
		}

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

			_list.push({
				R = 95,
				P = 1.0,
				S = "accessory/cp_vulture_item"
			});
		}

		__original(_id, _list);
	}
});
