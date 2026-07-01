// Namespace for generic global utility functions
::CrockPot.Util <- {};

::CrockPot.Util.ScriptReplacementTable <- {};

::CrockPot.Util.registerReplacementScript <- function( _oldScript, _newScript )
{
	::CrockPot.Util.ScriptReplacementTable[_oldScript] <- _newScript;
}
