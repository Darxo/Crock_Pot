this.cp_incendiary_bag_large <- this.inherit("scripts/items/ammo/cp_incendiary_bag", {
	m = {},
	function create()
	{
		this.cp_incendiary_bag.create();

		if (::Hooks.hasMod("mod_hardened"))
		{
			this.m.ID = "ammo.cp_incendiary_bag_large";	// Hardened allows ammo items to have unique IDs
			this.m.AmmoWeight = 0.5;	// Same as Hardened large powder bags
		}

		this.m.Name = "Large Bag of incendiary Shot";
		this.m.Description = "A bag of specially prepared shot that bursts into flames on impact.";
		this.m.Icon = "ammo/cp_incendiary_bullets_large.png";

		this.m.Value = 2000;
		this.m.Ammo = 7;
		this.m.AmmoMax = 7;
	}
});
