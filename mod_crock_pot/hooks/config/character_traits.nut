::Const.CharacterTraits.push([
	"trait.cp_creative",
	"scripts/skills/traits/cp_creative_trait",
]);


local excludeTrait = function( _scriptPath, _traitID )
{
	::CrockPot.HooksMod.hook(_scriptPath, function(q) {
		q.create = @(__original) function()
		{
			__original();
			this.m.Excluded.push(_traitID);
		}
	});
}

{	// Creative Trait
	local excludedBackgrounds = [
		"deserter_background",
		"farmhand_background",
		"monk_background",
		"fisherman_background",
		"lumberjack_background",
		"caravan_hand_background",
		"miller_background",
		"servant_background",
		"gravedigger_background",
		"brawler_background",
		"mason_background",
		"flagellant_background",
		"militia_background",
		"wildman_background",
		"bowyer_background",
		"cultist_background",
		"butcher_background",
		"miner_background",
		"messenger_background",
		"historian_background",
		"tailor_background",
		"shepherd_background",
	];
	local excludedTraits = [
		"dumb_trait",
	];

	local rootPath = "scripts/skills/backgrounds/";
	foreach (backgroundName in excludedBackgrounds)
	{
		excludeTrait(rootPath + backgroundName, "trait.cp_creative");
	}
	rootPath = "scripts/skills/traits/";
	foreach (traitName in excludedTraits)
	{
		excludeTrait(rootPath + traitName, "trait.cp_creative");
	}
}
