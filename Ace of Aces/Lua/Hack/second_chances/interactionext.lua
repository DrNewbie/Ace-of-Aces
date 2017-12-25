local SpecialHackLock_interact = UseInteractionExt.interact

function UseInteractionExt:can_select(...)
	return BaseInteractionExt.can_select(self, ...) 
end

function UseInteractionExt:can_interact(...)
	return BaseInteractionExt.can_interact(self, ...)
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