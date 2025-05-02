this.falcon_item <- this.inherit("scripts/items/accessory/cp_bird", {
	m = {
		InitiativeBonus = 15,
	},

	function create()
	{
		this.cp_bird.create();
		this.m.ID = "accessory.falcon";
		this.m.Name = "Falcon";
		this.m.Description = "A trained falcon that grants initiative while by your side. Can be released in battle to discover hidden prey.";
		this.m.Icon = "tools/falcon.png";
		this.m.DefaultIcon = "tools/falcon.png";
		this.m.Value = 800;

		this.m.DefaultSound = [
			"sounds/inventory/cp_falcon_inventory_01.wav",
			"sounds/inventory/cp_falcon_inventory_02.wav",
		];
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
		local skill = this.new("scripts/skills/actives/release_falcon_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}

});

