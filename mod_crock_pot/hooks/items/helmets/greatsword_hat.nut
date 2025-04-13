::CrockPot.HooksMod.hook("scripts/items/helmets/greatsword_hat", function(q) {
	q.onDeserialize = @(__original) function( _in )
	{
		__original(_in);

		if (this.m.Variant == 82)
		{
			this.m.Variant = 83;	// We no longer replace the artwork of this item so we reset it back to 83, whenever it gets deserialized
			this.updateVariant();
		}
	}
});
