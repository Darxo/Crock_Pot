::CrockPot.HooksMod.hook("scripts/items/helmets/dark_cowl", function(q) {
	q.create = @(__original) function()
	{
		__original();
		if (::Math.rand(1,2) == 1)
		{
			this.m.Variant = 5601;
			this.updateVariant();
		}
	}
});
