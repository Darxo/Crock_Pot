// This effect is designed to be given to an actor, after their reload their weapon with a special kind of ammunition
// It lasts only for one attack with that weapon
this.cp_loaded_incendiary_shot_effect <- ::inherit("scripts/skills/skill", {
	m = {
		// Public
		CP_BurningGroundDuration = 2,	// Amount of turns that the burning ground from this skill will last

		// Private
		CP_TargetedTile = null,		// Briefly save the
		CP_IsUnEquipping = false,	// Is set to true during onUnequip
	},
	function create()
	{
		this.m.ID = "effects.cp_loaded_incendiary_shot";
		this.m.Name = "Loaded with Incendiary Ammo";
		this.m.Description = "Your firearm is currently loaded with incendiary ammunition.";
		this.m.Icon = "skills/cp_loaded_incendiary_shot_effect.png";
		this.m.IconMini = "cp_loaded_incendiary_shot_effect_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;

		this.m.CP_IsAttachedSkill = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.getItem() == null)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/campfire.png",
				text = ::Reforged.Mod.Tooltips.parseString("Convert all weapon damage to fire damage"),
			});
		}
		else
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/campfire.png",
				text = "Convert all damage to fire damage with " + ::MSU.Text.colorPositive(this.getItem().getName()),
			});
		}

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/campfire.png",
			text = ::Reforged.Mod.Tooltips.parseString("Light the targeted tile on fire for " + ::MSU.Text.colorPositive(this.m.CP_BurningGroundDuration) + ::Reforged.Mod.Tooltips.parseString(" [turn(s)|Concept.Turn] on a hit")),
		});

		if (this.getItem() != null)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Lasts until you attack with " + ::MSU.Text.colorPositive(this.getItem().getName()),
			});
		}

		return ret;
	}

	function onUpdate( _properties )
	{
		if (this.getItem() == null) return;

		foreach (skill in this.getItem().m.SkillPtrs)
		{
			if (!this.isSkillValid(skill)) continue;

			skill.getDamageType().clear();
			skill.getDamageType().add(::Const.Damage.DamageType.Burning);
		}
	}

	function onRemoved()
	{
		if (this.m.CP_IsUnEquipping)
		{
			// If this skill was removed, because its attached item was unequipped, then we don't do any item reset-logic
			this.m.CP_IsUnEquipping = false;
			return;
		}

		// We need to reset the weapon slightly delayed, as we are still inside a container update at this point and unequipping the weapon during that will cause glitches
		::Time.scheduleEvent(::TimeUnit.Virtual, 1, this.CP_onRemoved.bindenv(this), this.getContainer().getActor());
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.CP_TargetedTile = _targetEntity.getTile();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.CP_TargetedTile == null) return;
		if (!this.isSkillValid(_skill)) return;
		if (!this.isTileValid(this.m.CP_TargetedTile)) return;

		this.onApplyFire(this.m.CP_TargetedTile);

		this.m.CP_TargetedTile = null;
	}

// MSU Events
	function onUnequip( _item )
	{
		// When our item is unequiped, we make note of that, so that we can later during onRemoved do better decisions
		this.m.CP_IsUnEquipping = ::MSU.isEqual(_item, this.getItem());
	}

// Reforged Functions
	function onAnySkillExecutedFully( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!this.isSkillValid(_skill)) return;

		// This effect only lasts for a single attack
		this.removeSelf();
	}

// New Functions
	// Is _skill allowed to apply a net on a hit?
	function isSkillValid( _skill )
	{
		if (!_skill.isAttack()) return false;
		if (!_skill.isRanged()) return false;
		if (!_skill.isUsingHitchance()) return false;
		if (!::MSU.isEqual(_skill.getItem(), this.getItem())) return false;
		return true;
	}

	// Is _tile valid to be put on fire?
	function isTileValid( _tile )
	{
		if (_tile.Subtype == ::Const.Tactical.TerrainSubtype.Snow) return false;
		if (_tile.Subtype == ::Const.Tactical.TerrainSubtype.LightSnow) return false;
		if (_tile.Type == ::Const.Tactical.TerrainType.ShallowWater) return false;
		if (_tile.Type == ::Const.Tactical.TerrainType.DeepWater) return false;

		if (_tile.Properties.Effect != null && _tile.Properties.Effect.Type == "fire")
		{
			if (_tile.Properties.Effect.Timeout >= ::Time.getRound() + this.m.CP_BurningGroundDuration) return false;
		}

		return true;
	}

	function onApplyFire( _tile )
	{
		if (_tile.Properties.Effect != null && _tile.Properties.Effect.Type == "fire")
		{
			_tile.Properties.Effect.Timeout = ::Time.getRound() + this.m.CP_BurningGroundDuration;
			return;
		}
		else
		{
			if (_tile.Properties.Effect != null)
			{
				::Tactical.Entities.removeTileEffect(_tile);
			}

			local fireEffect = {
				Type = "fire",
				Tooltip = "Fire rages here, melting armor and flesh alike",
				IsPositive = false,
				IsAppliedAtRoundStart = false,
				IsAppliedAtTurnEnd = true,
				IsAppliedOnMovement = false,
				IsAppliedOnEnter = false,
				IsByPlayer = this.getContainer().getActor().isPlayerControlled(),
				Timeout = ::Time.getRound() + this.m.CP_BurningGroundDuration,
				Callback = ::Const.Tactical.Common.onApplyFire,
				function Applicable( _a )
				{
					return true;
				}
			};

			_tile.Properties.Effect = clone fireEffect;
			local particles = [];
			for (local i = 0; i < ::Const.Tactical.FireParticles.len(); ++i)
			{
				particles.push(::Tactical.spawnParticleEffect(true, ::Const.Tactical.FireParticles[i].Brushes, _tile, ::Const.Tactical.FireParticles[i].Delay, ::Const.Tactical.FireParticles[i].Quantity, ::Const.Tactical.FireParticles[i].LifeTimeQuantity, ::Const.Tactical.FireParticles[i].SpawnRate, ::Const.Tactical.FireParticles[i].Stages));
			}

			::Tactical.Entities.addTileEffect(_tile, _tile.Properties.Effect, particles);
			_tile.clear(::Const.Tactical.DetailFlag.Scorchmark);
			_tile.spawnDetail("impact_decal", ::Const.Tactical.DetailFlag.Scorchmark, false, true);
		}
	}

	function CP_onRemoved( _actor )
	{
		if (!_actor.isAlive()) return;

		local weapon = _actor.getMainhandItem();
		if (weapon != null)
		{
			// We unrequip and reequip the weapon to reset its skills and their damage types to the default
			_actor.getItems().unequip(weapon);
			_actor.getItems().equip(weapon);
		}
	}

// MSU Events
	function onQueryTooltip( _skill, _tooltip )
	{
		if (this.isSkillValid(_skill))
		{
			local extraData = "entityId:" + this.getContainer().getActor().getID();
			_tooltip.push({
				id = 100,
				type = "text",
				icon = this.getIconColored(),
				text = ::Reforged.Mod.Tooltips.parseString("Affected by " + ::Reforged.NestedTooltips.getNestedSkillName(this, extraData)),
			});
		}
	}
});
