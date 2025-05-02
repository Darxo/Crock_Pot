// We remove all hooks from Reforged, which target release_falcon_skill, as we revert their changes to the skill
local script = "scripts/skills/actives/release_falcon_skill";
local mod = "mod_reforged";
if (script in ::Hooks.BBClass)
{
	local modIDFound = false;
	for (local i = ::Hooks.BBClass[script].RawHooks.len() - 1; i >= 0; --i)
	{
		if (::Hooks.BBClass[script].RawHooks[i].Mod.ID == mod)
		{
			::Hooks.BBClass[script].RawHooks.remove(i);
			modIDFound = true;
		}
	}
	if (!modIDFound)
	{
		::logWarning("CrockPot: modID " + mod + " was never sniped. You might have mistyped it");
	}
}
else
{
	::logWarning("CrockPot: Path " + script + " is never hooked. Hooks from mod " + mod + " could not be sniped");
}
