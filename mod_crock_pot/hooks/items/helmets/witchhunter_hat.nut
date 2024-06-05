::CrockPot.HooksMod.hook("scripts/items/helmets/witchhunter_hat", function(q) {
	q.create = @(__original) function()
	{
		__original();
		if (::Math.rand(1,2) == 1)
		{
			this.m.Variant = 5600;
			this.updateVariant();
		}
	}
});
