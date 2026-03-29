::CrockPot.HooksMod.hook("scripts/entity/tactical/enemies/necromancer", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.HairColors = ["grey"];	// In Vanilla necromancer have black and grey, but we reserve black for the lower tier one

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/weapons/rondel_dagger"],
			[12, "scripts/items/weapons/scramasax"],
		]);
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

		this.getItems().unequip(this.getHeadItem());		// Necromancer no longer wear a head item as their signature
	}
});
