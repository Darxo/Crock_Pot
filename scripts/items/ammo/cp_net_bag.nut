this.cp_net_bag <- this.inherit("scripts/items/ammo/powder_bag", {
	m = {},
	function create()
	{
		this.powder_bag.create();

		if (::Hooks.hasMod("mod_hardened"))
		{
			this.m.ID = "ammo.cp_net_bag";	// Hardened allows ammo items to have unique IDs
			this.m.AmmoWeight = 4;
		}

		this.m.Name = "Bag of compressed Nets";
		this.m.Description = "A bag of tightly bound throwing nets, folded to unfurl upon launch and entangle their target.";
		this.m.Icon = "ammo/cp_net_bullets.png";
		this.m.Value = 600;
		this.m.Ammo = 2;
		this.m.AmmoMax = 2;
		this.m.AmmoCost = 10;
	}

	function onEquip()
	{
		this.ammo.onEquip();

		if (!::Hooks.hasMod("mod_hardened"))
		{
			this.addSkill(::new("scripts/skills/effects/cp_net_bag_effect"));
		}
	}

	function getTooltip()
	{
		local ret = this.powder_bag.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Gain [$ $|Skill+cp_loaded_compressed_net_effect] when you reload your weapon"),
		});

		return ret;
	}

// Hardened Events
	// With Hardened, we can skip the need for an intermediate dummy effect and react directly to the reload action
	// This is important, so that this item also works with other effects, that trigger a reload (e.g. Ready to go)
	// If Hardened is not present, then this function does nothing
	function HD_onReload( _reloadedItem )
	{
		_reloadedItem.addSkill(::new("scripts/skills/effects/cp_loaded_compressed_net_effect"));
	}
});
