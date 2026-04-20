::CrockPot.HooksMod.hook("scripts/skills/actives/throw_fire_bomb_skill", function(q) {
	q.onAdded = @(__original) function()
	{
		__original();

		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		if (actor.getAIAgent().findBehavior(::Const.AI.Behavior.ID.CP_ThrowFireBomb) == null)
		{
			actor.getAIAgent().addBehavior(::new("scripts/ai/tactical/behaviors/cp_ai_throw_fire_bomb"));
			actor.getAIAgent().finalizeBehaviors();
		}
	}
});
