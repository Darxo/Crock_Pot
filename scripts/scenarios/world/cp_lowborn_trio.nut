this.cp_lowborn_trio <- this.inherit("scripts/scenarios/world/rf_random_trio", {
	m = {},
	function create()
	{
		this.rf_random_trio.create();
		this.m.ID = "scenario.cp_lowborn_trio";
		this.m.Name = "Crock Pot - Lowborn Trio";
		this.m.Description = "[p=c][img]gfx/ui/events/event_80.png[/img][/p][p]A random start into the world, without any particular advantages or disadvantages.\n\n[color=#bcad8c]Random Start:[/color] Start with a roster of 3 random lowborn.\n[color=#bcad8c]Talented:[/color] Your starting characters are level 2 and always have 2 stars in their talents.[/p]";
	}

	function onSpawnAssets()
	{
		local roster = ::World.getPlayerRoster();

		local lowbornBackgrounds = [];
		foreach (backgroundScriptName in ::Const.MV_getHireableCharacterBackgrounds())
		{
			local background = ::new("scripts/skills/backgrounds/" + backgroundScriptName);
			if (background.isLowborn()) lowbornBackgrounds.push(backgroundScriptName);
		}

		// Spawn 3 Brothers with random backgrounds
		for (local i = 1; i <= 3; ++i)
		{
			local bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = ::Time.getVirtualTimeF();
			bro.setPlaceInFormation(i + 2);
			bro.improveMood(1.5, "Joined a mercenary company");

			// Background, Stars, Level
			bro.setStartValuesEx(lowbornBackgrounds);
			bro.m.Attributes = [];
			for (local i = 0; i < bro.m.Talents.len(); ++i)
			{
				if (bro.m.Talents[i] != 0)
				{
					bro.m.Talents[i] = 2;
				}
			}
			bro.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);
			bro.m.PerkPoints = 1;
			bro.m.LevelUps = 1;
			bro.m.Level = 2;
		}

		// Items
		::World.Assets.getStash().add(::new("scripts/items/weapons/knife"));
		::World.Assets.getStash().add(::new("scripts/items/weapons/wooden_stick"));
		::World.Assets.getStash().add(::new("scripts/items/shields/wooden_shield_old"));
		::World.Assets.getStash().add(::new("scripts/items/tools/throwing_net"));
		::World.Assets.getStash().add(::new("scripts/items/supplies/ground_grains_item"));
		::World.Assets.getStash().add(::new("scripts/items/supplies/ground_grains_item"));
	}
});

