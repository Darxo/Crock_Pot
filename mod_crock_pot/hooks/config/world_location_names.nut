{	// Cave Names
	::Const.World.LocationNames.Cave <- [];

	local cavePrefix = [
		"Ancient",
		"Black",
		"Cold",
		"Dark",
		"Deep",
		"Echoing",
		"Forgotten",
		"Grim",
		"Hidden",
		"Murky",
		"Shadow",
		"Stone",
	]

	local caveSynonym = [
		"Burrow",
		"Cave",
		"Cavern",
		"Den",
		"Grotto",
		"Hollow",
		"Lair",
		"Nest",
		"Tangle",
		"Warren",
	]

	foreach (prefix in cavePrefix)
	{
		foreach (synonym in caveSynonym)
		{
			::Const.World.LocationNames.Cave.push(prefix + " " + synonym);
		}
	}
}

{	// WitchHut Names
	::Const.World.LocationNames.WitchHut <- [];

	local witchPrefix = [
		"Bewitched",
		"Crone\'s",
		"Cursewood",
		"Cursed",
		"Crooked",
		"Deceiver\'s",
		"Hag\'s",
		"Hexroot"
		"Witchbound",
		"Whispering",
	];

	local witchSynonym = [
		"Cabin",
		"Hut",
		"Lodge",
		"Retreat",
		"Shack",
		"Shed",
	];

	foreach (prefix in witchPrefix)
	{
		foreach (synonym in witchSynonym)
		{
			::Const.World.LocationNames.WitchHut.push(prefix + " " + synonym);
		}
	}
}
