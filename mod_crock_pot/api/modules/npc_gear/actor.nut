::CrockPot.HooksMod.hook("scripts/entity/tactical/actor", function(q) {
	// Public
	q.m.CP_ChanceForNoChest <- 0;		// Value between 1 and 100 determining the chance for this actor to get no Body Armor assigned from ChestWeightedContainer
	q.m.CP_ChestWeightedContainer <- null;		// If defined, the Body Armor worn by this actor will by assigned by this weighted container
	q.m.CP_ChanceForNoHelmet <- 0;		// Value between 1 and 100 determining the chance for this actor to get no Helmet assigned from ChestWeightedContainer
	q.m.CP_HelmetWeightedContainer <- null;	// If defined, the Helmet worn by this actor will by assigned by this weighted container
	q.m.CP_ChanceForNoWeapon <- 0;		// Value between 1 and 100 determining the chance for this actor to get no Weapon assigned from WeaponWeightContainer
	q.m.CP_WeaponWeightContainer <- null;		// If defined, the Weapon worn by this actor will by assigned by this weighted container
	q.m.CP_ChanceForNoOffhand <- 0;		// Value between 1 and 100 determining the chance for this actor to get no Offhand assigned from OffhandWeightContainer
	q.m.CP_OffhandWeightContainer <- null;		// If defined, the Offhand worn by this actor will by assigned by this weighted container
});

::CrockPot.HooksMod.hookTree("scripts/entity/tactical/actor", function(q) {
	// Assign all regular Equipment that this character brings into battle BEFORE any other assign equipment logic runs
	//	That way custom-gear code can react to these basic assignments
	q.assignRandomEquipment = @(__original) function()
	{
		if (this.m.CP_ChestWeightedContainer != null && this.getItems().hasEmptySlot(::Const.ItemSlot.Body))
		{
			if (::Math.rand(1, 100) > this.m.CP_ChanceForNoChest)
			{
				this.getItems().equip(::new(this.m.CP_ChestWeightedContainer.roll()));
			}
		}

		if (this.m.CP_HelmetWeightedContainer != null && this.getItems().hasEmptySlot(::Const.ItemSlot.Head))
		{
			if (::Math.rand(1, 100) > this.m.CP_ChanceForNoHelmet)
			{
				this.getItems().equip(::new(this.m.CP_HelmetWeightedContainer.roll()));
			}
		}

		// We assume that the offhand is always empty if the mainhand is empty
		if (this.m.CP_WeaponWeightContainer != null && this.getItems().hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			if (::Math.rand(1, 100) > this.m.CP_ChanceForNoWeapon)
			{
				this.getItems().equip(::new(this.m.CP_WeaponWeightContainer.roll()));
			}
		}

		if (this.m.CP_OffhandWeightContainer != null && this.getItems().hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			if (::Math.rand(1, 100) > this.m.CP_ChanceForNoOffhand)
			{
				this.getItems().equip(::new(this.m.CP_OffhandWeightContainer.roll()));
			}
		}

		__original();
	}
});
