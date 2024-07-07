this.cp_creative_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		// Public
		ChanceToTrigger = 25,
		ActionPointBonus = 3,
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.cp_creative";
		this.m.Name = "Creative";
		this.m.Icon = "ui/traits/trait_icon_cp_creative.png";
		this.m.Description = "This character is a source of innovation, occasionally finding brilliant solutions in the heat of battle.";
		this.m.Excluded = [
			"trait.dumb",
		];
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName(),
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription(),
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "At the start of each round you have a " + ::MSU.Text.colorPositive(this.m.ChanceToTrigger + "%") + " to gain " + ::MSU.Text.colorizeValue(this.m.ActionPointBonus) + " Action Points. Can only trigger once per battle. Does not trigger while stunned or fleeing.",
			}
		];
	}

	function onCombatStarted()
	{
		local creativeEffect = ::new("scripts/skills/effects/cp_creative_effect");
		creativeEffect.init(this.m.ChanceToTrigger, this.m.ActionPointBonus);
		this.getContainer().add(creativeEffect);
	}

});

