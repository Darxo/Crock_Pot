::CrockPot.HooksMod.hook("scripts/skills/skill", function(q) {
	// If true, then this skill will persist on the item it is attached, while that item is not equipped; but at most until the end of combat
	// This is useful for implementing ammunition effects
	q.m.CP_IsAttachedSkill <- false;
});
