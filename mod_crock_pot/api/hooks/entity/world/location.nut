::CrockPot.HooksMod.hook("scripts/entity/world/location", function(q) {
// Public
	q.m.CP_TacticalTypeOverwrite <- null;	// Define custom TacticalType that should be used when fighting this location
	q.m.CP_VacantDurationInDays <- 2;
	q.m.CP_VacantVisibilityMult <- 1.0;

	// Define custom engage image to be displayed when fighting at this location
	// Must also have a _night variant for when you fight at night
	q.m.CP_EngageImageOverwrite <- null;
	q.m.CP_TacticalTextOverwrite <- null;	// Text description to be displayed on location tooltips

// Private
	// A vacant location is barely visible, can't be attacked and might despawn if its party does not return within time
	// A location is considered vacant, if it does have an entry in its m.Flags under the VacantTimeoutFlagName. Its value is the day number at which the location self-destructs
	// World time in days at which this location fully despawn
	q.m.CP_VacantTimeoutFlagName <- "CP_VacantTimeoutFlagName";

	q.getTooltip = @(__original) function()
	{
		// A vacant location never shows its defenders, because it is effectively empty
		local oldIsShowingDefenders = this.isShowingDefenders;
		if (this.CP_isVacant()) this.isShowingDefenders = function() { return false };
		local ret = __original();
		this.isShowingDefenders = oldIsShowingDefenders;

		if (this.CP_isVacant() && !this.isHiddenToPlayer())
		{
			// Replace the "Unknown Garrison" tooltip with our vacancy info
			foreach (index, entry in ret)
			{
				if (entry.text == "Unknown garrison")
				{
					local hoursVacant = (this.m.Flags.get(this.m.CP_VacantTimeoutFlagName) - ::World.getTime().Days) * 24 - ::World.getTime().Hours;
					entry.icon = "skills/status_effect_107.png";
					entry.text = ::Reforged.Mod.Tooltips.parseString("This Location is currently [$ $|Concept.Vacant] (" + hoursVacant + " hours left)");
					break;
				}
			}
		}

		if (this.m.CP_TacticalTextOverwrite != null)
		{
			foreach (entry in ret)
			{
				if (entry.id == 21 && entry.type == "hint" && entry.icon == "ui/orientation/terrain_orientation.png")
				{
					entry.text = "This location is " + this.m.CP_TacticalTextOverwrite;
					break;
				}
			}
		}

		return ret;
	}

	q.getLastSpawnTime = @(__original) function()
	{
		// Vacancy prevents this location from being able to spawn new units
		if (this.CP_isVacant())
		{
			return ::Time.getVirtualTimeF();
		}

		return __original();
	}

	q.isAttackable = @(__original) function()
	{
		// Vacancy prevents this location from being attacked
		if (this.CP_isVacant()) return false;

		return __original();
	}

	q.isShowingDefenders = @(__original) function()
	{
		// A Vacant location can theoretically still have defender, but we want to pretent it does not, so we need to force-hide their defender
		if (this.CP_isVacant()) return false;

		return __original();
	}

	q.getVisibilityMult = @(__original) function()
	{
		local ret = __original();

		if (this.CP_isVacant()) ret *= this.m.CP_VacantVisibilityMult;

		return ret;
	}

// New Functions
	q.CP_setVacant <- function( _bool )
	{
		if (_bool)
		{
			this.m.Flags.set(this.m.CP_VacantTimeoutFlagName, ::World.getTime().Days + this.m.CP_VacantDurationInDays);
		}
		else
		{
			this.m.Flags.remove(this.m.CP_VacantTimeoutFlagName);
		}
	}

	q.CP_isVacant <- function()
	{
		return this.m.Flags.has(this.m.CP_VacantTimeoutFlagName);
	}

// New Events
	// Triggered, whenever a party is disbanding on the tile that are are, triggered by the despawn_order
	q.CP_onPartyDespawn <- function( _despawningParty )
	{
	}

	// Triggered once per day, the moment that the day counter flips over
	q.CP_onNewDay <- function()
	{
	}
});

::CrockPot.HooksMod.hookTree("scripts/entity/world/location", function(q) {
	// Triggered, whenever a party is disbanding on the tile that are are, triggered by the despawn_order
	// HookTree so that the original events can be overwritten by child classes without issues
	q.CP_onPartyDespawn = @(__original) function( _despawningParty )
	{
		if (_despawningParty.isAlliedWith(this))
		{
			this.CP_setVacant(false);

			if (this.m.IsSpawningDefenders && this.m.DefenderSpawnList != null && this.m.Resources != 0)
			{
				// Various triggers can have generated a defender party for this location before, even while it was vacant
				// We make sure to generate them again, without any debuff from "having sent out a party recently"
				this.createDefenders();
			}
		}

		__original(_despawningParty);
	}

	// Triggered once per day, the moment that the day counter flips over
	// HookTree so that the original events can be overwritten by child classes without issues
	q.CP_onNewDay = @(__original) function()
	{
		__original();

		if (this.CP_isVacant() && ::World.getTime().Days >= this.m.Flags.get(this.m.CP_VacantTimeoutFlagName))
		{
			this.fadeOutAndDie();
		}
	}
});
