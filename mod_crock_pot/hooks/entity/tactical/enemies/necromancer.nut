::CrockPot.HooksMod.hook("scripts/entity/tactical/enemies/necromancer", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.HairColors = ["grey"];	// In Vanilla necromancer have black and grey, but we reserve black for the lower tier one
	}

	q.onInit = @(__original) function()
	{
		__original();
		this.getSprite("dirt").setBrush("bust_glowing_eyes");	// Same effect that the barbarian madman uses
		this.getSprite("dirt").Visible = true;
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();

		local mainHandItem = this.getMainhandItem();
		if (mainHandItem == null || !mainHandItem.isItemType(::Const.Items.ItemType.Named))
		{
			// Necromancer no longer spawn without weapon, with a knife, butchers cleaver or dagger
			this.getItems().unequip(mainHandItem);
			local r = ::Math.rand(1, 2);
			if (r == 1)
			{
				this.getItems().equip(::new("scripts/items/weapons/rondel_dagger"));
			}
			else if (r == 2)
			{
				this.getItems().equip(::new("scripts/items/weapons/scramasax"));
			}
		}

		this.getItems().unequip(this.getHeadItem());		// Necromancer no longer wear a head item as their signature
	}
});
