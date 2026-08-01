::CrockPot.HooksMod.hook("scripts/items/item", function(q) {
// Public
	q.m.CP_CanBeRepaired <- true;

	// Vanilla Fix: Some Recipes accepting multiple different types of items
	// We do this by making every item return its ClassNameHash, which we assume to be unique to any item script file
	// Recipes use full item script paths for declaring ingredients. That is why we fix this by warping the return value of the getID function of all items
	q.getID = @(__original) function()
	{
		if (::CrockPot.Global.IsViewingRecipes)
		{
			return this.ClassNameHash;
		}

		return __original();
	}

	q.addSkill = @(__original) function( _skill )
	{
		if (_skill.m.CP_IsAttachedSkill && ::isKindOf(this, "weapon"))
		{
			// AttachedSkills, which are added to a weapon while that weapon is not in its ideal slot, will instead be added to its dormant effects
			if (this.getCurrentSlotType() != this.getSlotType())
			{
				this.m.CP_DormantAttachedEffects.push(_skill);
				return;
			}
		}

		return __original(_skill);
	}

	q.isToBeRepaired = @(__original) function()
	{
		if (!this.CP_canBeRepaired()) return false;

		return __original();
	}

	q.setToBeRepaired = @(__original) function( _bool )
	{
		if (_bool && !this.CP_canBeRepaired()) return false;

		return __original(_bool);
	}

// New Functions
	q.CP_getEquippableTooltip <- function()
	{
		local ret = [];

		ret.push({
			id = 1,
			type = "title",
			text = this.getName(),
		});

		ret.push({
			id = 2,
			type = "description",
			text = this.getDescription(),
		});

		if (this.getIconLarge() != null)
		{
			ret.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true,
			});
		}
		else
		{
			ret.push({
				id = 3,
				type = "image",
				image = this.getIcon(),
			});
		}

		if (this.getConditionMax() > 1.0)
		{
			ret.push({
				id = 4,
				type = "progressbar",
				icon = "ui/icons/asset_supplies.png",
				value = this.getCondition(),
				valueMax = this.getConditionMax(),
				text = "" + this.getCondition() + " / " + this.getConditionMax() + "",
				style = "armor-body-slim",
			});
		}

		if (!this.CP_canBeRepaired())
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Cannot be repaired",
			});
		}

		ret.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getSlotType() != ::Const.ItemSlot.None)
		{
			local slotName = "";
			foreach (key, value in ::Const.ItemSlot)
			{
				if (value == this.getSlotType())
				{
					slotName = key;
					break;
				}
			}

			ret.push({
				id = 66,
				type = "text",
				text = "Worn in " + slotName + " Slot",
			});
		}

		if (this.m.StaminaModifier < 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]",
			});
		}

		return ret;
	}

	q.CP_canBeRepaired <- function()
	{
		return this.m.CP_CanBeRepaired;
	}
});
