::CrockPot.HooksMod.hook("scripts/items/helmets/greatsword_hat", function(q) {
	q.create = @(__original) function()
	{
		__original();
		if (::Math.rand(1,2) == 1)
		{
			this.m.Variant = 82;	// Unused vanilla art, which we also redid
			this.updateVariant();
		}
	}
});
