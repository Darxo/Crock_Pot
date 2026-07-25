this.named_cp_physician_mask <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {
		CP_DamageReceivedMiasmaMult = 0.5,

	// Private
		// We don't use the vanilla Variant system, because
		//	- it can't deal with modded content well
		//	- we only use one variant anyways
		// Instead we use a fixed string, that is not serialized; and overwrite the updateVariant() function
		CP_VariantStringOverwrite = "named_cp_physician_mask",
	},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.named_cp_physician_mask";
		this.m.Description = "This physician's mask bears the marks of a master leatherworker, its beak reinforced with polished brass fittings and careful stitching. It seems made to outlast the pestilence it was meant to face.";
		this.m.NameList = [
			"Black Beak",
			"Carrion Beak",
			"Pestbane",
			"Pestwarden",
			"Plaguebane",
			"Plaguewarden",
			"Poxwalker",
			"Raven Mask",
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2550;		// 170 * 15

		// Base Values don't really matter, because they are fetched from the base item anyways
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.StaminaModifier = -3;
		this.m.Vision = -1;

		this.randomizeValues();

		this.m.BaseItemScript = "scripts/items/helmets/physician_mask";
	}

	function setValuesBeforeRandomize( _baseItem )
	{
		this.named_helmet.setValuesBeforeRandomize(_baseItem);

		// The original item is already designed as a weaker, mid-game helmet. So we choose to boost its condition for its use as a named item
		this.m.Condition += 30;
	}

	function getTooltip()
	{
		local ret = this.named_helmet.getTooltip();

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Take " + ::MSU.Text.colorizeMultWithText(this.m.CP_DamageReceivedMiasmaMult, {InvertColor = true}) + " Miasma Damage",
		});

		return ret;
	}

	function onUpdateProperties( _properties )
	{
		this.named_helmet.onUpdateProperties(_properties);

		_properties.DamageReceivedMiasmaMult = 0.5;
	}

	// Overwrite, because we don't use the
	function updateVariant()
	{
		this.m.Sprite = "bust_" + this.m.CP_VariantStringOverwrite;
		this.m.SpriteDamaged = "bust_" + this.m.CP_VariantStringOverwrite + "_damaged";
		this.m.SpriteCorpse = "bust_" + this.m.CP_VariantStringOverwrite + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_" + this.m.CP_VariantStringOverwrite + ".png";
	}
});
