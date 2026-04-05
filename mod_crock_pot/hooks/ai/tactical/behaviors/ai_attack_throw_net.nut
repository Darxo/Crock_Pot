::CrockPot.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_throw_net", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PossibleSkills.push("actives.cp_lesser_root_skill");
	}
});
