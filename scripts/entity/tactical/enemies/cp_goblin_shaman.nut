this.cp_goblin_shaman <- this.inherit("scripts/entity/tactical/enemies/goblin_shaman", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.CP_GoblinShaman;
		this.m.XP = this.Const.Tactical.Actor.CP_GoblinShaman.XP;
		this.goblin.create();
		this.m.SoundPitch = this.Math.rand(90, 100) * 0.01;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/goblin_shaman_agent");
		this.m.AIAgent.setActor(this);

		this.m.CP_ChestWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/armor/greenskins/goblin_shaman_armor"],
		]);

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/weapons/greenskins/goblin_staff"],
		]);
	}

	function onInit()
	{
		this.goblin_shaman.onInit();

		local b = this.getBaseProperties();
		b.setValues(::Const.Tactical.Actor.CP_GoblinShaman);
		this.m.CurrentProperties = clone b;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;

		// Generic Effects
		this.getSkills().removeByID("perk.mastery.mace");
		this.getSkills().removeByID("actives.root");
		this.getSkills().add(::new("scripts/skills/actives/cp_lesser_root_skill"));
	}
});

