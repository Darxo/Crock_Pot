// ::include("mod_crock_pot/some_priority_script");	// This file needs priority

::includeFiles(::IO.enumerateFiles("mod_crock_pot/hooks"));		// This will load and execute all hooks
