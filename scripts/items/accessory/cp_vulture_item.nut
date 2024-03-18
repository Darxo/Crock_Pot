this.cp_vulture_item <- this.inherit("scripts/items/accessory/cp_bird", {
	m = {
		ThreatModifier = 10,
	},

	function create()
	{
		this.cp_bird.create();
		this.m.ID = "accessory.cp_vulture";
		this.m.Name = "Vulture";
		this.m.Description = "A trained vulture that scares adjacent enemies while by your side. Can be released in battle to consume a corpse.";
		this.m.Icon = "accessory/cp_vulture.png";
		this.m.DefaultIcon = "accessory/cp_vulture.png";
		this.m.DefaultSound = [
			"sounds/inventory/cp_vulture_inventory_01.wav",
			"sounds/inventory/cp_vulture_inventory_02.wav"
		];
		this.m.Value = 1800;
	}

	function getTooltip()
	{
		local tooltip = this.cp_bird.getTooltip();

		if (!this.isReleased() && this.m.ThreatModifier != 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/kills.png",
				text = "Adjacent enemies have " + ::MSU.Text.colorizeValue(-1 * this.m.ThreatModifier) + " Resolve during Morale Checks."
			});
		}

		return tooltip;
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		if (!this.isReleased())
		{
			_properties.Threat += this.m.ThreatModifier;
		}
	}

	function onEquip()
	{
		this.cp_bird.onEquip();
		local skill = this.new("scripts/skills/actives/cp_release_vulture_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}

});

