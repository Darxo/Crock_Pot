// ::include("mod_crock_pot/some_priority_script");	// This file needs priority

// API Hooks
::includeFiles(::IO.enumerateFiles("mod_crock_pot/api"));

// Regular Hooks
::includeFiles(::IO.enumerateFiles("mod_crock_pot/hooks"));
