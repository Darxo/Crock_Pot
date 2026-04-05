this.cp_goblin_taskmaster <- this.inherit("scripts/entity/tactical/goblin", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.CP_GoblinTaskmaster;
		this.m.XP = ::Const.Tactical.Actor.CP_GoblinTaskmaster.XP;
		this.goblin.create();
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/goblin_leader_agent");
		this.m.AIAgent.setActor(this);
		this.m.AIAgent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_knock_out"));		// Important so that they will use Disarm
		this.m.AIAgent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_engage_melee"));		// Important so that they will engage in melee

		this.m.CP_ChestWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/armor/greenskins/goblin_leader_armor"],
		]);

		this.m.CP_HelmetWeightedContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/helmets/greenskins/goblin_light_helmet"],
		]);

		this.m.CP_WeaponWeightContainer = ::MSU.Class.WeightedContainer([
			[12, "scripts/items/weapons/barbarians/thorned_whip"],
		]);
	}

	function onInit()
	{
		this.goblin.onInit();

		local b = this.getBaseProperties();
		b.setValues(::Const.Tactical.Actor.CP_GoblinTaskmaster);
		this.m.CurrentProperties = clone b;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;

		this.getSprite("head").setBrush("bust_goblin_03_head_01");
		this.addDefaultStatusSprites();

		// Generic Effects

		// Generic Perks
		this.getSkills().add(::new("scripts/skills/perks/perk_anticipation"));

		// Generic Actives
		this.getSkills().add(::Reforged.new("scripts/skills/actives/goblin_whip", function(o) {
			o.m.ActionPointCost = 4;	// Vanilla: 3
		}));
	}
});

