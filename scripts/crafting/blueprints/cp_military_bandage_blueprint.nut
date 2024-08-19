this.cp_military_bandage_blueprint <- ::inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.cp_military_bandage";
		this.m.PreviewCraftable = ::new("scripts/items/accessory/cp_military_bandage_item");
		this.m.Cost = 50;

		local ingredients = [
			{
				Script = "scripts/items/accessory/bandage_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/spider_silk_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(::new("scripts/items/accessory/cp_military_bandage_item"));
	}

});
