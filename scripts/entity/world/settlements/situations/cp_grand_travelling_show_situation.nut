this.cp_grand_travelling_show_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.cp_grand_travelling_show";
		this.m.Name = "Grand Travelling Show";
		this.m.Description = "A great caravan of entertainers, beast handlers, and wandering oddities has rolled into the settlement, drawing crowds from near and far.";
		this.m.Icon = "ui/backgrounds/background_14.png";
		this.m.Rumors = [
			"They say a big show come to %settlement%, with jugglers, beast tamers, and wildmen. Folks are coming from all over to see it.",
			"Heard %settlement% got a traveling troupe with strange folks and beasts. The place is full, and food\'s gettin\' pricey.",
			"I heard the noise from %settlement% far off. A grand show\'s there, bringing crowds. The talk all around is about them performers and animals.",
		];
		this.m.IsStacking = false;	// Only one show can be in any town at any time
		this.m.ValidDays = 7;
	}

	function getAddedString( _s )
	{
		return _s + " now has a " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer has a " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodPriceMult *= 1.25;
		_modifiers.RecruitsMult *= 1.5;
	}

	function onUpdateDraftList( _draftList )
	{
		for (local i = 1; i <= 4; ++i)
		{
			_draftList.push("juggler_background");
			_draftList.push("houndmaster_background");
			_draftList.push("wildman_background");
		}
	}
});

