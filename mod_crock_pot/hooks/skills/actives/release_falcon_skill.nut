::CrockPot.HooksMod.hook("scripts/skills/actives/release_falcon_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();

		this.m.SoundOnUse = [
			"sounds/combat/cp_falcon_use_01.wav",
			"sounds/combat/cp_falcon_use_02.wav"
		];
	}
});
