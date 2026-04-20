this.cp_ai_throw_fire_bomb <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		// Public
		PossibleSkills = [
			"actives.throw_fire_bomb",
		],
		InvalidTerrainTypes = [
			::Const.Tactical.TerrainType.DeepWater,
			::Const.Tactical.TerrainType.ShallowWater,
		],
		InvalidTerrainSubtypes = [
			::Const.Tactical.TerrainSubtype.LightSnow,
			::Const.Tactical.TerrainSubtype.Snow,
		],
		MinValidScore = 100,	// We ignore this behavior, if the best targets score is lower than this
		ScoreBase = 50,
		ScoreFreeRoots = 20,

		// Private
		Selection = null,
		Skill = null,
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.CP_ThrowFireBomb;
		this.m.Order = ::Const.AI.Behavior.Order.CP_ThrowFireBomb;
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
		if (this.m.Selection.Score < this.m.MinValidScore) return ::Const.AI.Behavior.Score.Zero;

		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];
		scoreMult *= this.getFatigueScoreMult(this.m.Skill);

		return this.m.Selection.Score * scoreMult;
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
		if (_target.getCurrentProperties().IsImmuneToFire) return 0;

		local tile = _target.getTile();
		// Not even the impact effect is applied on these tiles
		if (tile.Subtype in this.m.InvalidTerrainSubtypes) return 0;
		if (tile.Type in this.m.InvalidTerrainTypes) return 0;

		local score = this.m.ScoreBase;

		if (_target.getCurrentProperties().IsStunned) score *= ::Const.AI.Behavior.ThrowBombStunnedMult;

		// The targeted tile is already affected by something negative, our ground effect does not do anything
		// But our Firebomb still deals impact damage, that's why we only half the score here
		if (_target.getTile().Properties.Effect != null && !_target.getTile().Properties.Effect.IsPositive) score *= 0.5;

		if (tile.hasZoneOfControlOtherThan(_target.getAlliedFactions()))
		{
			// If the target is locked in Zone of Control, they can't move out of the flames
			score *= (tile.getZoneOfControlCountOtherThan(_target.getAlliedFactions()) * ::Const.AI.Behavior.ThrowBombZOCMult);
		}

		if (_target.getHitpoints() + _target.getArmor(::Const.BodyPart.Body) <= 20)
		{
			score *= ::Const.AI.Behavior.ThrowBombInstakillMult;
		}

		local targetValueMult = this.queryTargetValue(_entity, _target, _skill);
		score *= targetValueMult

		if (_target.getCurrentProperties().IsRooted)
		{
			if (::Hooks.hasMod("mod_hardened"))
			{
				score -= (this.m.ScoreFreeRoots * targetValueMult);	// Fire instantly destroys rooted effects in Hardened
				// Since this can be a good thing for allies, we implement it as a flat change, instead of a multiplier
			}
			else
			{
				score *= ::Const.AI.Behavior.ThrowBombStunnedMult;
			}
		}

		return score;
	}

	function __onQueryTile( _tile, _tag )
	{
		_tag.push(_tile);
	}
});
