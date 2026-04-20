this.cp_bottomless_bag <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.cp_bottomless_bag";
		this.m.Name = "Bottomless Bag";
		this.m.Description = "A bag with a sheer endless supply of utility items";
		this.m.SlotType = ::Const.ItemSlot.Accessory;
		this.m.Icon = "ammo/powder_bag_empty.png";
		this.m.Value = 3000;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Gain [$ $|Skill+cp_bottomless_bag_effect]"),
		});
		return result;
	}

	function onEquip()
	{
		this.accessory.onEquip();
		this.addSkill(::new("scripts/skills/effects/cp_bottomless_bag_effect"));
	}
});
