this.cp_caravan_hand_southern <- this.inherit("scripts/entity/tactical/humans/caravan_hand", {
	m = {},
	function create()
	{
		// Switcheroo, so that caravan_hand::create assigns the correct name, because it overwrites our assigned one with CaravanHand
		local oldEntityType = ::Const.EntityType.CaravanHand;
		::Const.EntityType.CaravanHand = ::Const.EntityType.CP_CaravanHandSouthern;
		this.caravan_hand.create();
		::Const.EntityType.CaravanHand = oldEntityType;

		this.m.Type = ::Const.EntityType.CP_CaravanHandSouthern;
		this.m.BloodType = ::Const.BloodType.Red;

		// We change the look of the caravan hand to mirror that of a conscript
		this.m.Bodies = ::Const.Bodies.SouthernMale;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
	}
});
