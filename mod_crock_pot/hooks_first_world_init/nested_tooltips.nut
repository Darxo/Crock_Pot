{	// New Concepts
	::MSU.Table.merge(::Reforged.NestedTooltips.Tooltips.Concept, {
		Vacant = ::MSU.Class.BasicTooltip("Vacant", ::Reforged.Mod.Tooltips.parseString(
			"Some locations that send out world parties will become vacant until that party returns.\n\n" +
			"A vacant location cannot send out patrols, cannot be attacked and will despawn after some days, unless an allied party returns from its patrol in time."
		)),
	});
}
