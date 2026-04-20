local generateAllIterations = function( _prefixes, _suffixes )
{
	local ret = [];
	foreach (prefix in _prefixes)
	{
		foreach (suffix in _suffixes)
		{
			ret.push(prefix + " " + suffix);
		}
	}
	return ret;
}

local firebrandSuffixes = [
	"the Ashen",
	"the Blacksmoke",
	"the Blast",
	"the Burner",
	"the Cinder",
	"the Firestarter",
	"the Flash",
	"the Kindler",
	"the Torch",
	"the Scorcher",
	"the Wildfire",
];
::Const.Strings.CP_FirebrandNames <- generateAllIterations(["%randomname%"], firebrandSuffixes);

local freeLancerSuffixes = [
	"the Breaklance",
	"the Charger",
	"the Gallows Pike",
	"the Impaler",
	"the Jouster",
	"the Lance",
	"the Longreach",
	"the Piercer",
	"the Runthrough",
	"the Skewer",
	"the Tilt",
];
::Const.Strings.CP_FreeLancerNames <- generateAllIterations(["%randomname%"], freeLancerSuffixes);

local ironguardSuffixes = [
	"the Anvil",
	"the Bastion",
	"the Bulwark",
	"the Gate",
	"the Holdfast",
	"the Ironclad",
	"the Steadfast",
	"the Shield",
	"the Unyielding",
	"the Wall",
	"the Ward",
];
::Const.Strings.CP_IronguardNames <- generateAllIterations(["%randomname%"], ironguardSuffixes);
