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
			case "building.marketplace":
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

					_list.push({
						R = 95,
						P = 1.0,
						S = "accessory/cp_vulture_item"
					});
				}
			}
		}

		__original(_id, _list);
	}

// New Functions
	// @Return a WeightContainer with all applicable random situations for this settlemtn
	q.CP_getApplicableRandomSituations = @(__original) function()
	{
		local ret = __original();

		switch (this.getSize())
		{
			case 2:		// Both size 2 and size 3 towns can spawn these behaviors
			case 3:
			{
				ret.add("cp_physicians_gathering_situation", 12);
				if (!this.isMilitary() || ::isKindOf(this, "city_state"))	// Civilian Settlements or Citystate can have this situation
				{
					ret.add("cp_grand_travelling_show_situation", 12);
				}
				break;
			}
		}

		return ret;
	}
});
