this.cp_military_bandage_item <- this.inherit("scripts/items/accessory/bandage_item", {
	m = {},
	function create()
	{
		this.bandage_item.create();
		this.m.ID = "accessory.cp_military_bandage";
		this.m.Name = "Military Bandages";
		this.m.Description = "Durable bandages that can be applied quickly in battle to stabilize severe wounds and control blood loss.";
		this.m.Icon = "consumables/cp_military_bandages.png";
		this.m.StaminaModifier = -6;
		this.m.Value = 200;
	}

	function onEquip()
	{
		this.accessory.onEquip();
		local skill = ::new("scripts/skills/actives/bandage_ally_skill");
		skill.m.ActionPointCost -= 3;
		skill.setItem(this);
		this.addSkill(skill);
	}
});
