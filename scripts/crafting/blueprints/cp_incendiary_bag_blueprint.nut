this.cp_incendiary_bag_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.cp_incendiary_bag";
		this.m.PreviewCraftable = ::new("scripts/items/ammo/cp_incendiary_bag");
		this.m.Cost = 150;

		local ingredients = [
			{
				Script = "scripts/items/ammo/powder_bag",
				Num = 1,
			},
			{
				Script = "scripts/items/misc/sulfurous_rocks_item",
				Num = 1,
			},
			{
				Script = "scripts/items/misc/serpent_skin_item",
				Num = 1,
			},
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(::new("scripts/items/ammo/cp_incendiary_bag"));
	}
});
