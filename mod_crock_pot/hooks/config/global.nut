// Table, where EntityTypeIDs are the keys, and their DefaultFaction are the values
// It is used, to apply our changes to the DefaultFaction much more easily
::CrockPot.Const.DefaultFaction <- {}

local highestID = 0;
foreach (key, value in ::Const.EntityType)
{
	if (typeof value == "integer" && value > highestID)
		highestID = value;
}

function addEntityType( _typeId, _orientationIcon, _name, _namePlural, _defaultFaction)
{
	::Const.EntityType[_typeId] <- ++highestID;
	::Const.EntityIcon.push(_orientationIcon);
	::Const.Strings.EntityName.push(_name);
	::Const.Strings.EntityNamePlural.push(_namePlural);

	::CrockPot.Const.DefaultFaction[highestID] <- _defaultFaction;
}

function addSpawnlistEntry( _typeId, _script, _cost, _strength, _row, _variant = 0, _nameList = null, _titleList = null )
{
	::Const.World.Spawn.Troops[_typeId] <- {
		ID = ::Const.EntityType[_typeId],
		Script = _script,
		Cost = _cost,
		Strength = _strength,
		Row = _row,
		Variant = _variant,
		NameList = _nameList,
		TitleList = _titleList,
	}
}

{	// Changes Entities
	::Const.Strings.EntityName[::Const.EntityType.PeasantSouthern] = "Peasant";
	::Const.Strings.EntityNamePlural[::Const.EntityType.PeasantSouthern] = "Peasants";
}

{	// New Entities
	{	// Hooded Man
		local cost = 30;
		addEntityType("CP_HoodedMan", "human_01_orientation", "Hooded Man", "Hooded Men", ::Const.FactionType.Zombies);		// We re-use the orientatio of regular necromancers
		addSpawnlistEntry("CP_HoodedMan", "scripts/entity/tactical/enemies/cp_hooded_man", cost, 50, 3);	// Hooded Men don't appear as champions
	}

	{	// Citizen (North)
		// T2 Upgrade over northern Peasants
		local cost = 12;
		addEntityType("CP_CitizenNorth", "militia_captain_orientation", "Citizen", "Citizens", ::Const.FactionType.Settlement);
		addSpawnlistEntry("CP_CitizenNorth", "scripts/entity/tactical/humans/cp_citizen_north", cost, cost, 1);
	}

	{	// Citizen (South)
		// T2 Upgrade of southern Peasants
		local cost = 12;
		addEntityType("CP_CitizenSouth", "militia_captain_orientation", "Citizen", "Citizens", ::Const.FactionType.OrientalCityState);
		addSpawnlistEntry("CP_CitizenSouth", "scripts/entity/tactical/humans/cp_citizen_south", cost, cost, 1);
	}

	{	// Caravan Hand (Southern)
		local cost = 10;
		addEntityType("CP_CaravanHandSouthern", "caravan_hand_orientation", "Caravan Hand", "Caravan Hands", ::Const.FactionType.OrientalCityState);
		addSpawnlistEntry("CP_CaravanHandSouthern", "scripts/entity/tactical/humans/cp_caravan_hand_southern", cost, cost, 2);
	}

	{	// Personal Guard
		local cost = 25;
		addEntityType("CP_PersonalGuard", "caravan_guard_orientation", "Personal Guard", "Personal Guards", ::Const.FactionType.Settlement);
		addSpawnlistEntry("CP_PersonalGuard", "scripts/entity/tactical/humans/cp_personal_guard", cost, cost, 2);
	}
}
