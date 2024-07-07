this.cp_creative_effect <- ::inherit("scripts/skills/skill", {
	m = {
		// Public
		ChanceToTrigger = null,
		ActionPointBonus = null,

		// Private
		IconActive = "ui/traits/trait_icon_cp_creative.png",
		IconMiniActive = "cp_creative_effect_mini",
		IsSpent = false,
	},
	function create()
	{
		this.m.ID = "effects.cp_creative";
		this.m.Name = "Creative";
		this.m.Description = "It\'s only a matter of time before this character finally gets that spark of inspiration.";
		this.m.Icon = "ui/traits/trait_icon_cp_creative_inactive.png";
		this.m.IconMini = "";
		// this.m.Overlay = "cp_arrow_to_the_knee_debuff_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		if (this.m.IsSpent)
		{
			return this.m.Name + " (Active)";
		}
		else
		{
			return this.m.Name + " (Dormant)";
		}
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.IsSpent)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::MSU.Text.colorizeValue(this.m.ActionPointBonus) + " Action Points",
			});
		}
		else
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "At the start of each round you have a " + ::MSU.Text.colorPositive(this.m.ChanceToTrigger + "%") + " to gain " + ::MSU.Text.colorizeValue(this.m.ActionPointBonus) + " Action Points. Can only trigger once per battle. Does not trigger while stunned or fleeing.",
			});
		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (this.m.IsSpent)
		{
			_properties.ActionPoints += this.m.ActionPointBonus;
		}
	}

	function onNewRound()
	{
		local actor = this.getContainer().getActor();
		if (!this.m.IsSpent && !actor.getCurrentProperties().IsStunned && actor.getMoraleState() != ::Const.MoraleState.Fleeing && ::Math.rand(1, 100) <= this.m.ChanceToTrigger)
		{
			this.triggerInspiration();
		}
	}

	function onTurnEnd()
	{
		if (this.m.IsSpent)
		{
			this.removeSelf();	// This effect has been used up and is no longer relevant for this battle.
		}
	}

// New Function
	function init( _chanceToTrigger, _actionPointBonus )
	{
		this.m.ChanceToTrigger = _chanceToTrigger;
		this.m.ActionPointBonus = _actionPointBonus;
	}

	function triggerInspiration()
	{
		this.m.IsSpent = true;

		local actor = this.getContainer().getActor();
		if (!actor.isHiddenToPlayer())
		{
			this.spawnIcon("cp_creative_effect", actor.getTile());
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has a creative idea!");
		}

		this.m.Icon = this.m.IconActive;
		this.m.IconMini = this.m.IconMiniActive;
		this.m.Description = "It was only a matter of time before this character finally got that spark of inspiration.";
	}
});
