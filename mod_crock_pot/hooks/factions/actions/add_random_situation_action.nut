::CrockPot.HooksMod.hook("scripts/factions/actions/add_random_situation_action", function(q) {
	// Overwrite, because we modularize this action allowing much easier addition of more situations
	// Applicable random Situations are now managed by CP_getApplicableRandomSituations from settlement.nut
	// Public
	q.m.Chance <- 2;
	q.m.MaximumSituations <- 2;
	q.m.MinDistanceToPlayer <- 11;

	// Overwrite, because we modularize it to make it much more moddable
	q.onUpdate = @() function( _faction )
	{
		this.m.Settlement = ::MSU.Array.rand(_faction.getSettlements());
		this.m.Settlement.updateSituations();

		if (!this.isReadyForRandomSituation(_faction)) return;

		local possibleSituations = this.m.Settlement.CP_getApplicableRandomSituations();
		if (possibleSituations.len() == 0) return;

		// if (::Math.rand(1, 100) <= 75 - possibleSituations.len() * 25) return;
		this.m.Situation = possibleSituations.roll();
		this.m.Score = 1;
	}

// New Functions
	q.isReadyForRandomSituation <- function( _faction )
	{
		if (::Math.rand(1, 100) > this.m.Chance) return false;
		if (_faction.getType() == ::Const.FactionType.NobleHouse && !this.m.Settlement.isMilitary()) return false;
		if (this.m.Settlement.getSituations().len() >= this.m.MaximumSituations) return false;
		if (this.m.Settlement.getTile().getDistanceTo(::World.State.getPlayer().getTile()) < this.m.MinDistanceToPlayer) return false;

		if (this.m.Settlement.hasSituation("situation.raided")) return false;
		if (this.m.Settlement.hasSituation("situation.conquered")) return false;
		if (this.m.Settlement.hasSituation("situation.besieged")) return false;
		if (this.m.Settlement.hasSituation("situation.short_on_food")) return false;

		return true;
	}
});
