this.cp_restored_order_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.cp_restored_order";
		this.m.Name = "Restored Order";
		this.m.Description = "The town watch has arrested many criminals and seized stolen goods in an effort to restore order. Much of the confiscated property has since been returned to circulation, leaving the markets better supplied than usual.";
		this.m.Icon = "ui/backgrounds/background_62.png";	// Manhunter Icon
		this.m.Rumors = [
			"The gaols in %settlement% are said to be overflowing. Either the watch finally started doing their job, or someone needed the cells filled.",
			"They say the markets in %settlement% are full of goods seized from criminals. Whatever the truth of it, merchants there seem well stocked."
			"They hauled so many thieves off in irons in %settlement% that honest folk can walk the streets without checking their coin pouch every minute."
		];
		this.m.IsStacking = false;	// Only one restored order can be in any town at any time
		this.m.ValidDays = 7;

		this.m.CP_Excluded = [
			"situation.conquered",
			"situation.raided",
			"situation.razed",
			"situation.slave_revolt",
		];
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.RarityMult *= 1.1;
		_modifiers.PriceMult *= 0.9;
	}

	function onUpdateDraftList( _draftList )
	{
		for (local i = _draftList.len() - 1; i >= 0; --i)
		{
			if (_draftList[i] == "thief_background" || _draftList[i] == "thief_southern_background" || _draftList[i] == "graverobber_background" || _draftList[i] == "killer_on_the_run_background")
			{
				_draftList.remove(i);
			}
		}
	}
});
