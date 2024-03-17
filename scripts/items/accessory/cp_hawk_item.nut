this.cp_hawk_item <- this.inherit("scripts/items/accessory/cp_bird", {
	m = {
		InitiativeBonus = 15,
	},

	function create()
	{
		this.cp_bird.create();
		this.m.ID = "accessory.cp_hawk";
		this.m.Name = "Hawk";
		this.m.Description = "A trained hawk that grants initiative while by your side. Can be released in battle to hinder the movement of your prey.";
		this.m.Icon = "accessory/cp_hawk.png";
		this.m.DefaultIcon = "accessory/cp_hawk.png";
		this.m.DefaultSound = [
			"sounds/inventory/hawk_inventory_01.wav",
			"sounds/inventory/hawk_inventory_02.wav"
		];
		this.m.Value = 1400;
	}

	function getTooltip()
	{
		local tooltip = this.cp_bird.getTooltip();

		if (!this.isReleased() && this.m.InitiativeBonus != 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::MSU.Text.colorizeValue(this.m.InitiativeBonus) + " Initiative"
			});
		}

		return tooltip;
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		if (!this.isReleased())
		{
			_properties.Initiative += this.m.InitiativeBonus;
		}
	}

	function onEquip()
	{
		this.cp_bird.onEquip();
		local skill = this.new("scripts/skills/actives/cp_release_hawk_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}

});

