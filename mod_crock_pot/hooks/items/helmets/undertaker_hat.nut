::CrockPot.HooksMod.hook("scripts/items/helmets/undertaker_hat", function(q) {
	q.create = @(__original) function()
	{
		__original();
		if (::Math.rand(1,2) == 1)
		{
			this.m.Variant = 5602;
			this.m.Description = "A wide-brimmed feathered hat. Durable enough to protect against weather and scratches.";
			this.m.HideBeard = false;	// The vanilla undertaker hat covers the entire face. This edit only consists of a hat
			this.updateVariant();
		}
	}

	q.onDeserialize = @(__original) function( _in )
	{
		__original(_in);

		if (this.m.Variant == 5602)
		{
			this.m.Description = "A wide-brimmed feathered hat. Durable enough to protect against weather and scratches.";
			this.m.HideBeard = false;	// The vanilla undertaker hat covers the entire face. This edit only consists of a hat
		}
		else
		{
			this.m.Description = "A wide-brimmed feathered hat with a scarf to cover the mouth. Durable enough to protect against weather and scratches.";
			this.m.HideBeard = true;
		}
	}
});
