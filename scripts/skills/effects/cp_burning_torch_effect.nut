// This effect is passively granted, while a torch is lit
this.cp_burning_torch_effect <- ::inherit("scripts/skills/skill", {
	m = {
		ResolveModifier = 15,
		MeleeDefenseModifierAgainstUnarmed = 15,
		RevealRadius = 5,	// All tiles around the user this many tiles away are revealed, including bushes
		ConditionLossPerRound = 8,
	},
	function create()
	{
		this.m.ID = "effects.cp_burning_torch";
		this.m.Name = "Burning Torch";
		this.m.Description = "Your torch casts a warm light through the darkness. The sight of fire keeps many beasts at bay.";
		this.m.Icon = "skills/cp_burning_torch_effect.png";
		this.m.Overlay = "cp_burning_torch_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "During your turn, reveal tiles and hidden characters in a radius of " + ::MSU.Text.colorPositive(this.m.RevealRadius) + " tiles",
		});

		if (this.getResolveModifier() != 0)
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::MSU.Text.colorizeValue(this.getResolveModifier(), {AddSign = true}) + ::Reforged.Mod.Tooltips.parseString(" [Resolve|Concept.Bravery]"),
			});
		}

		if (this.getMeleeDefenseModifier() != 0)
		{
			ret.push({
				id = 13,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("%s [Melee Defense|Concept.MeleeDefense] against %s characters", ::MSU.Text.colorizeValue(this.getMeleeDefenseModifier(), {AddSign = true}), ::Hooks.hasMod("mod_hardened") ? "[$ $|Concept.Unarmed]" : "unarmed")),
			});
		}

		if (this.m.ConditionLossPerRound > 0)
		{
			local torchString = ::MSU.isNull(this.getItem()) ? "Your torch" : ::Reforged.NestedTooltips.getNestedItemName(this.getItem());
			ret.push({
				id = 15,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(torchString + " loses " + ::MSU.Text.colorNegative(this.m.ConditionLossPerRound) + " condition at the end of each [round|Concept.Round]"),
			});
		}

		return ret;
	}

	function onAdded()
	{
		this.triggerReveal();
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += this.getResolveModifier();
		// Todo: add more chance for breaking free from rooted effects to succeed
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (this.isTargetValid(_attacker))
		{
			_properties.MeleeDefense += this.getMeleeDefenseModifier();
		}
	}

	function onMovementFinished()
	{
		this.triggerReveal();
	}

	function onTurnStart()
	{
		this.triggerReveal();
	}

	function onRoundEnd()
	{
		this.getItem().CP_lowerCondition(this.m.ConditionLossPerRound);
	}

// MSU Functions
	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (!_targetTile.IsOccupiedByActor) return;

		if (this.isTargetValid(_targetTile.getEntity()))
		{
			_tooltip.push({
				icon = this.getIconColored(),
				text = this.getName(),
			});
		}
	}

	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		if (this.isTargetValid(_skill.getContainer().getActor()))
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::MSU.Text.colorNegative((this.getMeleeDefenseModifier()) + "% ") + ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedSkillName(this)),
			});
		};
	}

// New Functions
	// Will our torch provide melee defense against _target?
	function isTargetValid( _target )
	{
		if (::MSU.isNull(_target)) return false;

		return _target.getMainhandItem() == null || _target.isDisarmed();
	}

	function getResolveModifier()
	{
		return this.m.ResolveModifier;
	}

	function getMeleeDefenseModifier()
	{
		return this.m.MeleeDefenseModifierAgainstUnarmed
	}

	function triggerReveal()
	{
		local actor = this.getContainer().getActor();
		::Tactical.queryTilesInRange(actor.getTile(), 1, this.m.RevealRadius, false, [], this.revealTile, actor.getFaction());
	}

	function revealTile( _tile, _factionID )
	{
		_tile.addVisibilityForFaction(_factionID);
		if (_tile.IsOccupiedByActor) _tile.getEntity().setDiscovered(true);
	}
});
