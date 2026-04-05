// Variant of the Vanilla root_skill, which only roots a single target
this.cp_lesser_root_skill <- this.inherit("scripts/skills/actives/root_skill", {
	m = {
	},
	function create()
	{
		this.root_skill.create();
		this.m.ID = "actives.cp_lesser_root_skill";
		this.m.Name = "Lesser Root";
		this.m.IsTargetingActor = true;		// This skill can now only be used on tiles with an actor on top
		this.m.ActionPointCost = 5;		// Base: 6
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		if (actor.getAIAgent().findBehavior(::Const.AI.Behavior.ID.ThrowNet) == null)
		{
			actor.getAIAgent().addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
			actor.getAIAgent().finalizeBehaviors();
		}
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Inflict [$ $|Skill+rooted_effect] to the target"),
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles",
		});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.root_skill.onVerifyTarget(_originTile, _targetTile)) return false;

		// This skill can now only be used on tiles with an actor on top
		return this.isViableTarget(this.getContainer().getActor(), _targetTile.getEntity());
	}

	function onUse( _user, _targetTile )
	{
		this.CP_applyRoot(_targetTile.getEntity());

		if (this.m.SoundOnHit.len() != 0)
		{
			::Sound.play(::MSU.Array.rand(this.m.SoundOnHit), ::Const.Sound.Volume.Skill, this.targetEntity.getPos());
		}

		return true;
	}

// New Functions
	function CP_applyRoot( _target )
	{
		_target.getSkills().add(::new("scripts/skills/effects/rooted_effect"));
		local breakFree = ::new("scripts/skills/actives/break_free_skill");
		breakFree.setDecal("roots_destroyed");
		breakFree.m.Icon = "skills/active_75.png";
		breakFree.m.IconDisabled = "skills/active_75_sw.png";
		breakFree.m.Overlay = "active_75";
		breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
		_target.getSkills().add(breakFree);
		_target.raiseRootsFromGround("bust_roots", "bust_roots_back");
	}
});

