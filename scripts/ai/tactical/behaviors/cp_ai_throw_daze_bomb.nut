this.cp_ai_throw_daze_bomb <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		// Public
		PossibleSkills = [
			"actives.throw_daze_bomb",
		],

		// Private
		Selection = null,
		Skill = null,
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.CP_ThrowDazeBomb;
		this.m.Order = ::Const.AI.Behavior.Order.CP_ThrowDazeBomb;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Selection = null;
		this.m.Skill = null;

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing) return ::Const.AI.Behavior.Score.Zero;
		if (!this.getAgent().hasVisibleOpponent()) return ::Const.AI.Behavior.Score.Zero;


		this.m.Skill = this.selectSkill(this.m.PossibleSkills);
		if (this.m.Skill == null) return ::Const.AI.Behavior.Score.Zero;

		this.m.Selection = this.__findBestTarget(_entity, this.m.Skill);
		if (this.m.Selection.Score <= 0) return ::Const.AI.Behavior.Score.Zero;

		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];
		scoreMult *= this.getFatigueScoreMult(this.m.Skill);

		return ::Const.AI.Behavior.Score.CP_ThrowDazeBomb * this.m.Selection.Score * scoreMult;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(_entity.getTile());
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (::Const.AI.VerboseMode)
		{
			::logInfo("* " + _entity.getName() + ": Using " + this.m.Skill.getName() + "!");
		}

		this.m.Skill.use(this.m.Selection.TargetTile);

		if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.Selection.TargetTile.IsVisibleForPlayer))
		{
			this.getAgent().declareAction();
			this.getAgent().declareEvaluationDelay();
		}

		this.m.Selection = null;
		this.m.Skill = null;

		return true;
	}

	/// @return table with TargetTile and Score
	function __findBestTarget( _entity, _skill )
	{
		local ret = {
			Score = 0,
			TargetTile = null,
		};

		local myTile = _entity.getTile();
		local tiles = [];
		::Tactical.queryTilesInRange(myTile, _skill.getMinRange(), _skill.getMaxRange(), false, [], this.__onQueryTile, tiles);

		foreach (tile in tiles)
		{
			if (!_skill.isUsableOn(tile)) continue;

			local targets = [];
			if (tile.IsOccupiedByActor) targets.push(tile.getEntity());

			foreach (neighborTile in ::MSU.Tile.getNeighbors(tile))
			{
				if (!neighborTile.IsOccupiedByActor) continue;
				targets.push(neighborTile.getEntity());
			}

			local score = 0;
			foreach (target in targets)
			{
				if (target.isAlliedWith(_entity))		// Fire can also affect allies
				{
					// Not hitting allies is a little bit more important than hitting enemies
					score -= 1.2 * __getTargetScore(_entity, target, _skill);
				}
				else
				{
					score += __getTargetScore(_entity, target, _skill);
				}
			}

			if (score > ret.Score)
			{
				ret.Score = score;
				ret.TargetTile = tile;
			}
		}

		return ret;
	}

	/// Calculate the score for getting _target afflicted with the acid debuff
	function __getTargetScore( _entity, _target, _skill )
	{
		if (_target.getCurrentProperties().IsImmuneToDaze) return 0;
		if (_target.getCurrentProperties().IsStunned) return 0;		// Dazing a target that is already stunned, does do very little
		if (_target.getSkills().hasSkill("effects.dazed")) return 0;

		local score = this.queryTargetValue(_entity, _target, _skill);

		local tile = _target.getTile();
		// If a hostile (to _target) Neighbor has deathblow or is important, then we wanna daze it
		foreach (neighborTile in ::MSU.Tile.getNeighbors(tile))
		{
			if (!neighborTile.IsOccupiedByActor) continue;

			local neighbor = neighborTile.getEntity();
			if (neighbor.isAlliedWith(_target)) continue;

			if (neighbor.getCurrentProperties().TargetAttractionMult > 1.0)
			{
				score *= ::Const.AI.Behavior.ThrowBombPriorityTargetMult;
			}

			if (neighbor.getSkills().hasSkill("actives.deathblow"))
			{
				score *= ::Const.AI.Behavior.ThrowBombPriorityTargetMult;
			}
		}

		// Fleeing characters probably dont have a turn anyways
		if (_target.getMoraleState() == ::Const.MoraleState.Fleeing) score *= 0.2;

		// Hardcoded check for a few weapon types
		local weapon = _target.getMainhandItem();
		if (weapon != null)
		{
			if (weapon.isItemType(::Const.Items.ItemType.TwoHanded) && weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
			{
				score *= ::Const.AI.Behavior.ThrowBombPriorityTargetMult;
			}

			if (weapon.isAoE())
			{
				score *= ::Const.AI.Behavior.ThrowBombPriorityTargetMult;
			}
		}

		if (tile.hasZoneOfControlOtherThan(_target.getAlliedFactions()))
		{
			// If the target is locked in Zone of Control, they can't just wait out the dazed
			score *= (tile.getZoneOfControlCountOtherThan(_target.getAlliedFactions()) * ::Const.AI.Behavior.ThrowBombZOCMult);
		}

		return score;
	}

	function __onQueryTile( _tile, _tag )
	{
		_tag.push(_tile);
	}
});
