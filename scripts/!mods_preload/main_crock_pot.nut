::CrockPot <- {
	ID = "mod_crock_pot",
	Name = "Crock Pot",
	Version = "0.4.0",
	GitHubURL = "https://github.com/Darxo/Crock_Pot",
	Const = {
		DayThresholdMinDangerBeasts = 10,	// Higher Tier Beast Caves (Lindwurms and Unholds) only start appearing at this day count
	}
}

::CrockPot.HooksMod <- ::Hooks.register(::CrockPot.ID, ::CrockPot.Version, ::CrockPot.Name);
::CrockPot.HooksMod.require(["mod_reforged"]);

::CrockPot.HooksMod.queue(">mod_reforged", function() {
	::CrockPot.Mod <- ::MSU.Class.Mod(::CrockPot.ID, ::CrockPot.Version, ::CrockPot.Name);

	::CrockPot.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, ::CrockPot.GitHubURL);
	::CrockPot.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	::include("mod_crock_pot/load");		// Load mod adjustments and other hooks
	::include("mod_crock_pot/ui/load");		// Load JS Adjustments and Hooks
});
