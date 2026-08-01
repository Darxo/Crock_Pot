this.cp_set_fire_skill <- this.inherit("scripts/skills/skill", {
	m = {
		BurningGroundDuration = 2,
	},
	function create()
	{
		this.m.ID = "actives.cp_set_fire_skill";
		this.m.Name = "Set Fire";
		this.m.Description = "Use your burning torch to set the nearby ground alight.";
		this.m.Icon = "skills/cp_set_fire_skill.png";
		this.m.IconDisabled = "skills/cp_set_fire_skill_bw.png";
		this.m.Overlay = "cp_set_fire_skill";
		this.m.SoundOnUse = [
			// The first vanilla variant has a small delay, which we don't like
			// The second vanilla variant is too much ambient, rather than active burning
			"sounds/combat/dlc6/status_on_fire_03.wav",
		];

		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsActive = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsSerialized = false;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;

		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Set an empty tile on fire for " + ::MSU.Text.colorPositive(this.m.BurningGroundDuration) + " rounds. Water and snow can not burn.",
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Destroy any consumable corpse on the targeted tile.",
		});

		if (!this.getItem().m.IsLit)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Requires a burning torch",
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.getItem().m.IsLit;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;

		if (!_targetTile.IsEmpty) return false;
		if (::Tactical.Entities.getNonFlammableTileSubtypes().find(_targetTile.Subtype) != null) return false;

		return true;
	}

	function onUse( _user, _targetTile )
	{
		::Tactical.State.spawnFireOnTile(_targetTile, _user.isPlayerControlled(), true, this.m.BurningGroundDuration);

		if (this.hasDestroyableCorpse(_targetTile))
		{
			this.destroyCorpse(_targetTile);
		}

		return true;
	}

// MSU Functions
	function onQueryTileTooltip( _tile, _tooltip )
	{
		local actor = this.getContainer().getActor();
		if (_tile.IsCorpseSpawned && actor.isPreviewing() && ::MSU.isEqual(actor.getPreviewSkill(), this))
		{
			if (this.hasDestroyableCorpse(_tile))
			{
				_tooltip.push({
					id = 90,
					type = "text",
					icon = this.getIcon(),
					text = "Will destroy corpse of " + ::MSU.Text.colorPositive(_tile.Properties.get("Corpse").CP_OriginalName),
				});
			}
			else
			{
				_tooltip.push({
					id = 90,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "Corpse of " + ::MSU.Text.colorPositive(_tile.Properties.get("Corpse").CP_OriginalName) + " cannot be destroyed!",
				});
			}
		}
	}

// New Functions
	function hasDestroyableCorpse( _targetTile )
	{
		if (!_targetTile.IsCorpseSpawned) return false;

		local corpse = _targetTile.Properties.get("Corpse");
		if (!corpse.IsConsumable) return false;

		return true;
	}

	// Inspired by the vanilla gruesome_feast.nut
	// Requires a corpse to be present on _targetTile
	function destroyCorpse( _targetTile )
	{
		if (_targetTile.IsVisibleForPlayer)
		{
			local corpseName = _targetTile.Properties.get("Corpse").CP_OriginalName;
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " destroys the corpse of " + ::MSU.Text.colorPositive(corpseName));
		}

		// Remove Corpse
		::Tactical.Entities.removeCorpse(_targetTile);
		_targetTile.clear(::Const.Tactical.DetailFlag.Corpse);
		_targetTile.Properties.remove("Corpse");
		_targetTile.Properties.remove("IsSpawningFlies");
	}
});

