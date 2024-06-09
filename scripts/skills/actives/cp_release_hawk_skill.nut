this.cp_release_hawk_skill <- this.inherit("scripts/skills/skill", {
	m = {
		// Config
		DebuffDuration = 1,

		// Private
		Item = null,
	},
	function create()
	{
		this.m.ID = "actives.cp_release_hawk";
		this.m.Name = "Release Hawk";
		this.m.Description = "Release your hawk to hinder the movement of an enemy until the end of their turn. Can only be used once on any entity per battle.";
		this.m.Icon = "skills/cp_release_hawk.png";
		this.m.IconDisabled = "skills/cp_release_hawk_sw.png";
		this.m.Overlay = "cp_release_hawk";
		this.m.SoundOnUse = [
			"sounds/combat/hawk_01.wav",
			"sounds/combat/hawk_02.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.BeforeLast + 5;	// We want release-ables to be listed after break-free skills (which are BeforeLast)
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
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Apply the [Harassed by Hawk effect|Skill+cp_harassed_by_hawk_effect] to the target for 1 turn.")
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

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (target.getFlags().has("CP_WasHarassedByHawk"))
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
		target.getSkills().add(::new("scripts/skills/effects/cp_harassed_by_hawk_effect"));

		return true;
	}

// New Functions
	function getItem()
	{
		return this.m.Item;
	}
});

