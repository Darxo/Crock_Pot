this.cp_net_bag_large <- this.inherit("scripts/items/ammo/cp_net_bag", {
	m = {},
	function create()
	{
		this.cp_net_bag.create();

		if (::Hooks.hasMod("mod_hardened"))
		{
			this.m.ID = "ammo.cp_net_bag_large";	// Hardened allows ammo items to have unique IDs
		}

		this.m.Name = "Large Bag of compressed Nets";
		this.m.Description = "A large bag of tightly bound throwing nets, folded to unfurl upon launch and entangle their target.";
		this.m.Icon = "ammo/cp_net_bullets_large.png";
		this.m.IconEmpty = "ammo/powder_bag_large_empty.png";

		this.m.Value = 1200;
		this.m.Ammo = 3;
		this.m.AmmoMax = 3;
	}
});
