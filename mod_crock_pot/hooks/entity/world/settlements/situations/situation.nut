::CrockPot.HooksMod.hook("scripts/entity/world/settlements/situations/situation", function(q) {
	q.m.CP_Excluded <- [];	// Array of situation ids, which must not be present for this situation to be eligable

// New Functions
	q.CP_isExcluded <- function( _id )
	{
		return this.m.CP_Excluded.find(_id) != null;
	}

	// Check, whether the existing situations in _settlements prohibit this one from being added on top
	q.CP_isSettlementValid <- function( _settlement )
	{
		if (_settlement == null) return false;

		foreach (situation in _settlement.getSituations())
		{
			if (this.CP_isExcluded(situation.getID()))
			{
				return false;
			}
		}

		return true;
	}
});
