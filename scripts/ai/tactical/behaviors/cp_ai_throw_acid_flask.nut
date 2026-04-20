this.cp_ai_throw_acid_flask <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		// Public
		PossibleSkills = [
			"actives.throw_acid_flask",
		],

		// Private
		Selection = null,
		Skill = null,
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.CP_ThrowAcidFlask;
		this.m.Order = ::Const.AI.Behavior.Order.CP_ThrowAcidFlask;
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

			local mainTarget = tile.getEntity();
			local score = __getTargetScore(_entity, mainTarget, _skill);

			foreach (neighborTile in ::MSU.Tile.getNeighbors(tile))
			{
				if (!neighborTile.IsOccupiedByActor) continue;

				local neighbor = neighborTile.getEntity();
				local neighborScore = __getTargetScore(_entity, neighbor, _skill) * 0.33;	// 33% chance to affect neighbors

				if (neighbor.isAlliedWith(_entity))		// Acid can also affect allies
				{
					// Not hitting allies is a little bit more important than hitting enemies
					score -= 1.2 * neighborScore;
				}
				else
				{
					score += neighborScore;
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
		if (_target.getSkills().hasSkill("effects.acid")) return 0;

		// Acid deals 20% of current Armor as Armor Damage to both body parts over 3 turns
		// We slightly simplify that by only comparing the the armor damage of the first hit
		local currentArmor = _target.getArmor(::Const.BodyPart.Head) + _target.getArmor(::Const.BodyPart.Body);
		local armorDamage = currentArmor * 0.2;

		local score = armorDamage;
		if (_target.getCurrentProperties().NegativeStatusEffectDuration > 0) score *= 0.4;

		score *= this.queryTargetValue(_entity, _target, _skill);

		return score;
	}

	function __onQueryTile( _tile, _tag )
	{
		_tag.push(_tile);
	}
});
