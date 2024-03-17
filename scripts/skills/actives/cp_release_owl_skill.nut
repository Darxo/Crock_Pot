this.cp_release_owl_skill <- this.inherit("scripts/skills/skill", {
	m = {
		// Config
		MoraleCheckPenalty = 15,		// A positive value that gets inverted, when it's used for the morale check

		// Private
		Item = null,
	},
	function create()
	{
		this.m.ID = "actives.cp_release_owl";
		this.m.Name = "Release Owl";
		this.m.Description = "Release your owl to scare an enemy.";
		this.m.Icon = "skills/active_104.png";	// Placeholder
		this.m.IconDisabled = "skills/active_104_sw.png";	// Placeholder
		this.m.Overlay = "active_104";	// Placeholder
		this.m.SoundOnUse = [
			"sounds/combat/cp_owl_use_01.wav",
			"sounds/combat/cp_owl_use_02.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.NonTargeted + 5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsTargetingActor = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 8;
		this.m.MaxLevelDifference = 4;
	}

	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.push({
			id = 8,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorGreen(this.getMaxRange()) + " tiles."
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/kills.png",
			text = "Trigger a negative morale check on the target with a additional difficulty of " + ::MSU.Text.colorGreen(this.getMoraleCheckPenalty()) + "."
		});

		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The additional difficulty is doubled during night."
		});

		return tooltip;
	}

	function isUsable()
	{
		if (this.getItem().isReleased() || !this.skill.isUsable())
		{
			return false;
		}

		return true;
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = this.getItem().isReleased();
	}

	function onUse( _user, _targetTile )
	{
		this.getItem().setReleased(true);

		local target = _targetTile.getEntity();
		target.checkMorale(-1, -1 * this.getMoraleCheckPenalty(), ::Const.MoraleCheckType.MentalAttack);

		return true;
	}

// New Functions
	function getItem()
	{
		return this.m.Item;
	}

	function getMoraleCheckPenalty()
	{
		if (::World.getTime().IsDaytime)
		{
			return this.m.MoraleCheckPenalty;
		}
		else	// Night
		{
			return 2 * this.m.MoraleCheckPenalty;
		}
	}
});

