this.cp_net_bag_large_blueprint_01 <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.cp_net_bag_large_01";
		this.m.PreviewCraftable = ::new("scripts/items/ammo/cp_net_bag_large");
		this.m.Cost = 300;

		local ingredients = [
			{
				Script = "scripts/items/ammo/cp_net_bag",
				Num = 1,
			},
			{
				Script = "scripts/items/tools/throwing_net",
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
		_stash.add(::new("scripts/items/ammo/cp_net_bag_large"));
	}
});
