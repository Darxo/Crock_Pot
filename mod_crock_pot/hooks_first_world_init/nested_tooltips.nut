{	// New Concepts
	::MSU.Table.merge(::Reforged.NestedTooltips.Tooltips.Concept, {
		Vacant = ::MSU.Class.BasicTooltip("Vacant", ::Reforged.Mod.Tooltips.parseString(
			"Some locations that send out world parties will become vacant for some time or until that party returns.\n\n" +
			"A vacant location cannot send out patrols and cannot be attacked."
		)),
	});
}
