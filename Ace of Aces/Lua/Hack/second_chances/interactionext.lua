local SpecialHackLock_interact = UseInteractionExt.interact

function UseInteractionExt:can_hack_keycard()
	if not managers.player:has_category_upgrade("player", "pick_lock_so_hard") then
		return false
	end
	return self.tweak_data ~= "hack_keycard" or alive(self._unit)
end

function UseInteractionExt:can_select(...)
	return BaseInteractionExt.can_select(self, ...) and self:can_hack_keycard()
end

function UseInteractionExt:can_interact(...)
	return BaseInteractionExt.can_interact(self, ...) and self:can_hack_keycard()
end

Hooks:PostHook(UseInteractionExt, "_at_interact_start", 'SpecialHackLock_at_interact_start', function(self, player)
	if self.tweak_data == "hack_keycard" then
		player:base():set_detection_multiplier("hack_keycard", 0.5)
	end
end)

Hooks:PostHook(UseInteractionExt, "_at_interact_interupt", 'SpecialHackLock_interact_interupt', function(self, player)
	if self.tweak_data == "hack_keycard" then
		player:base():set_detection_multiplier("hack_keycard", 1)
	end
end)

function UseInteractionExt:interact(player)
	if self.tweak_data == "hack_keycard" then
		if self._unit and alive(self._unit) and self._unit:base() then
			self._unit:base():device_completed("key")
		end
	else
		SpecialHackLock_interact(self, player)
	end
end