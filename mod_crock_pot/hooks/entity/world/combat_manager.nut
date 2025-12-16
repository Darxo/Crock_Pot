::CrockPot.HooksMod.hook("scripts/entity/world/combat_manager", function(q) {
	q.m.CP_CombatFactionsMax <- 64;		// Vanilla 32

	q.joinCombat = @(__original) function(_combat, _party)
	{
		if (::MSU.isNull(_party)) return;

		// Vanilla hard-codes the maximum factions to 32 inside of `startCombat` and `onDeserialize`
		// This breaks, when mods introduce more factions (e.g. by spawning more settlements)
		// Vanilla Fix: We enlargen the combat Faction Array so that more factions are supported, than the vanilla 32
		while (_combat.Factions.len() < this.m.CP_CombatFactionsMax)
		{
			_combat.Factions.push([]);
		}

		__original(_combat, _party);
	}
});
