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

{	// Hooded Man
	local cost = 30;
	addEntityType("CP_HoodedMan", "human_01_orientation", "Hooded Man", "Hooded Men", ::Const.FactionType.Zombies);		// We re-use the orientatio of regular necromancers
	addSpawnlistEntry("CP_HoodedMan", "scripts/entity/tactical/enemies/cp_hooded_man", cost, 50, 3);	// Hooded Men don't appear as champions
}
