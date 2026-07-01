local oldNew = ::new;
::new = function( _script )
{
	foreach (oldScript, newScript in ::CrockPot.Util.ScriptReplacementTable)
	{
		if (_script == oldScript)
		{
			_script = newScript;
		}
	}

	return oldNew(_script);
}
