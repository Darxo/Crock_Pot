::CrockPot <- {
	ID = "mod_crock_pot",
	Name = "Crock Pot",
	Version = "0.1.4",
	// GitHubURL = "https://github.com/YOURNAME/mod_crock_pot",
}

::CrockPot.HooksMod <- ::Hooks.register(::CrockPot.ID, ::CrockPot.Version, ::CrockPot.Name);
::CrockPot.HooksMod.require(["mod_reforged"]);

::CrockPot.HooksMod.queue(">mod_reforged", function() {
	::CrockPot.Mod <- ::MSU.Class.Mod(::CrockPot.ID, ::CrockPot.Version, ::CrockPot.Name);

	// Add an official mod source and turn on automatic ingame reminder about new updates
	// ::CrockPot.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, ::mod_crock_pot.GitHubURL);
	// ::CrockPot.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	::include("mod_crock_pot/load");		// Load mod adjustments and other hooks
	::include("mod_crock_pot/ui/load");		// Load JS Adjustments and Hooks
});
