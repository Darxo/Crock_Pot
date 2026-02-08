// This effect is designed to be given to an actor, after their reload their weapon with a special kind of ammunition
// It lasts only for one attack with that weapon
this.cp_loaded_compressed_net_effect <- ::inherit("scripts/skills/skill", {
	m = {
		// Public
		CP_DamageTotalMult = 0.2,
	},
	function create()
	{
		this.m.ID = "effects.cp_loaded_compressed_net";
		this.m.Name = "Loaded with Compressed Net";
		this.m.Description = "Your firearm is currently loaded with a compressed net.";
		this.m.Icon = "skills/cp_loaded_compressed_net_effect.png";
		this.m.IconMini = "cp_loaded_compressed_net_effect_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;

		this.m.SoundVolume = 0.6;
		this.m.SoundOnHit = [
			"sounds/combat/throw_net_01.wav",
			"sounds/combat/throw_net_02.wav",
		];

		// Used for passing on to the break_free_skill, when we apply our effect
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/break_free_net_01.wav",
			"sounds/combat/break_free_net_02.wav",
			"sounds/combat/break_free_net_03.wav",
		];

		this.m.CP_IsAttachedSkill = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Inflict [$ $|Skill+net_effect] on a hit"),
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "Deal " + ::MSU.Text.colorizeMultWithText(this.m.CP_DamageTotalMult) + " damage",
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

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!this.isSkillValid(_skill)) return;

		_properties.DamageTotalMult *= this.m.CP_DamageTotalMult;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!this.isSkillValid(_skill)) return;
		if (!this.isTargetValid(_targetEntity)) return;

		this.onApplyNet(_targetEntity);
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

	function isTargetValid( _targetEntity )
	{
		if (::MSU.isNull(_targetEntity)) return false;
		if (!_targetEntity.isAlive()) return false;
		if (_targetEntity.getCurrentProperties().IsImmuneToRoot) return false;
		if (_targetEntity.getCurrentProperties().IsRooted) return false;

		return true;
	}

	// Apply a net effect onto _targetEntity, the same way that vanilla does it
	// Todo: more move/most of the net logic into the net_effect skill. Perhaps using a new cp_net_effect inheriting from the vanilla one
	function onApplyNet( _targetEntity )
	{
		_targetEntity.getSkills().add(::new("scripts/skills/effects/net_effect"));
		local breakFree = ::new("scripts/skills/actives/break_free_skill");
		breakFree.m.Icon = "skills/active_74.png";
		breakFree.m.IconDisabled = "skills/active_74_sw.png";
		breakFree.m.Overlay = "active_74";
		breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
		breakFree.setDecal("net_destroyed");
		_targetEntity.getSkills().add(breakFree);

		local effect = ::Tactical.spawnSpriteEffect("bust_net", ::createColor("#ffffff"), _targetEntity.getTile(), 0, 10, 1.0, _targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
		local flip = !_targetEntity.isAlliedWithPlayer();
		effect.setHorizontalFlipping(flip);
		::Time.scheduleEvent(::TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), {
			TargetEntity = _targetEntity,
		});
	}

	function onNetSpawn( _data )
	{
		if (this.m.SoundOnHit.len() != 0)
		{
			::Sound.play(::MSU.Array.rand(this.m.SoundOnHit), ::Const.Sound.Volume.Skill * this.m.SoundVolume, _data.TargetEntity.getPos(), ::MSU.Math.randf(0.9, 1.1));
		}

		local rooted = _data.TargetEntity.getSprite("status_rooted");
		rooted.setBrush("bust_net");
		rooted.Visible = true;

		local rooted_back = _data.TargetEntity.getSprite("status_rooted_back");
		rooted_back.setBrush("bust_net_back");
		rooted_back.Visible = true;

		_data.TargetEntity.setDirty(true);
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
