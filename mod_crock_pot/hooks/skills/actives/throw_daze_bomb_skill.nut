::CrockPot.HooksMod.hook("scripts/skills/actives/throw_daze_bomb_skill", function(q) {
	q.onAdded = @(__original) function()
	{
		__original();

		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		if (actor.getAIAgent().findBehavior(::Const.AI.Behavior.ID.CP_ThrowDazeBomb) == null)
		{
			actor.getAIAgent().addBehavior(::new("scripts/ai/tactical/behaviors/cp_ai_throw_daze_bomb"));
			actor.getAIAgent().finalizeBehaviors();
		}
	}
});
