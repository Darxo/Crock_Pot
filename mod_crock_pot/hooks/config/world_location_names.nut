::Const.World.LocationNames.Cave <- [];

local cavePrefix = [
	"Ancient",
	"Black",
	"Cold",
	"Dark",
	"Deep",
	"Echo",
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
]

foreach (prefix in cavePrefix)
{
	foreach (synonym in caveSynonym)
	{
		::Const.World.LocationNames.Cave.push(prefix + " " + synonym);
	}
}
