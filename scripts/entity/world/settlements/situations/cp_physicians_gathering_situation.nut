this.cp_physicians_gathering_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.cp_physicians_gathering";
		this.m.Name = "Physician\'s Gathering";
		this.m.Description = "Healers, physicians, and scholars of the body have come together in this settlement to share knowledge and discuss their craft. Traders have taken notice, offering herbs, salves, and remedies in greater numbers to meet the demand.";
		this.m.Icon = "ui/backgrounds/background_70.png";
		this.m.Rumors = [
			"Seems like all the healers and doctors are gathered in %settlement%. They say there\'s plenty of medicine to be had if you know where to look.",
			"I heard %settlement% is full of folks in robes talking about cures and potions. Traders are selling herbs and salves like never before.",
			"Some say the smartest minds of the land are meeting in %settlement%... others say it's just a bunch of madmen arguing over how much blood to drain."
		];
		this.m.IsStacking = false;	// Only one gathering can be in any town at any time
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
		_modifiers.MedicalRarityMult *= 1.5;
		_modifiers.MedicalPriceMult *= 0.8;
		// _modifiers.RecruitsMult *= 1.2;
	}

	function onUpdateDraftList( _draftList )
	{
		for (local i = 1; i <= 6; ++i)
		{
			_draftList.push("anatomist_background");
			_draftList.push("monk_background");
		}
	}

});

