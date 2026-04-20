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

