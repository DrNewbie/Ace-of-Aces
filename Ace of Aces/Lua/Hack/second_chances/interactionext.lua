local SpecialHackLock_interact = UseInteractionExt.interact
local SpecialHackLock_interact_start = UseInteractionExt.interact_start
local SpecialHackLock_post_event = UseInteractionExt._post_event
local SpecialHackLock_selected = UseInteractionExt.selected

local SpecialHackLock_ChancgeList = {
	numpad_keycard = true
}
SpecialHackLock_CheckList = SpecialHackLock_ChancgeList
SpecialHackLock_CheckList.hack_keycard = true

function UseInteractionExt:can_hack_keycard()
	if SpecialHackLock_CheckList[self.tweak_data] then
		return managers.player:has_category_upgrade("player", "pick_lock_so_hard")
	end
	return true
end

function UseInteractionExt:can_select(...)
	return BaseInteractionExt.can_select(self, ...) and self:can_hack_keycard()
end

function UseInteractionExt:_timer_value()
	if SpecialHackLock_ChancgeList[self.tweak_data] then
		return tweak_data.interaction.hack_keycard.timer or 0
	end
	return self._tweak_data.timer or 0
end

function UseInteractionExt:interact_start(player)
	if SpecialHackLock_ChancgeList[self.tweak_data] then
		local blocked, skip_hint, custom_hint = self:_interact_blocked(player)
		local tweak_timer = tweak_data.interaction.hack_keycard.timer or 0
		local has_equipment = not self._tweak_data.special_equipment and true or managers.player:has_special_equipment(self._tweak_data.special_equipment)
		if blocked then
			if not skip_hint and (custom_hint or self._tweak_data.blocked_hint) then
				managers.hint:show_hint(custom_hint or self._tweak_data.blocked_hint)
			end

			return false
		end
		if tweak_timer > 0 and not has_equipment then
			if not self:can_interact(player) then
				if self._tweak_data.blocked_hint then
					managers.hint:show_hint(self._tweak_data.blocked_hint)
				end

				return false
			end
			local run_time = self:_get_timer()
			if run_time > 0 then
				self:_at_interact_start(player, run_time)
				self._tweak_data_at_interact_start = tweak_data.interaction.hack_keycard
				return false, run_time
			end
		end
		return self:interact(player)
	end
	return SpecialHackLock_interact_start(self, player)
end

function UseInteractionExt:selected(...)
	local Ans = SpecialHackLock_selected(self, ...)
	if SpecialHackLock_ChancgeList[self.tweak_data] then
		local has_equipment = not self._tweak_data.special_equipment and true or managers.player:has_special_equipment(self._tweak_data.special_equipment)
		if not has_equipment then
			managers.hud:show_interact({
				text = managers.localization:text(tweak_data.interaction.hack_keycard.text_id),
				icon = self.no_equipment_icon or self._tweak_data.no_equipment_icon or self._tweak_data.icon
			})
		end
	end
	return Ans
end

function UseInteractionExt:_post_event(...)
	if SpecialHackLock_ChancgeList[self.tweak_data] then
		return
	end
	return SpecialHackLock_post_event(self, ...)
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
	if not self:can_interact(player) then
		return
	end
	if self.tweak_data == "hack_keycard" then
		if self._unit and alive(self._unit) and self._unit:base() then
			self._unit:base():device_completed("key")
			return true
		end
	elseif SpecialHackLock_ChancgeList[self.tweak_data] then
		self:remove_interact()
		if self._unit:damage() then
			self._unit:damage():run_sequence_simple("interact", {unit = player})
		end
		managers.network:session():send_to_peers_synched("sync_interacted", self._unit, -2, self.tweak_data, 1)
		if self._global_event then
			managers.mission:call_global_event(self._global_event, player)
		end
		self:set_active(false)
		return true
	else
		return SpecialHackLock_interact(self, player)
	end
	return
end

function UseInteractionExt:can_interact(player)
	if self._host_only and not Network:is_server() then
		return false
	end
	if self._disabled then
		return false
	end
	if not self:_has_required_upgrade(alive(player) and player:movement() and player:movement().current_state_name and player:movement():current_state_name()) then
		return false
	end
	if not self:_has_required_deployable() then
		return false
	end
	if not self:_is_in_required_state(alive(player) and player:movement() and player:movement().current_state_name and player:movement():current_state_name()) then
		return false
	end
	if self._tweak_data.special_equipment_block and managers.player:has_special_equipment(self._tweak_data.special_equipment_block) then
		return false
	end
	if not self._tweak_data.special_equipment or self._tweak_data.dont_need_equipment then
		return true
	end
	if SpecialHackLock_CheckList[self.tweak_data] then
		return managers.player:has_category_upgrade("player", "pick_lock_so_hard")
	end
	return managers.player:has_special_equipment(self._tweak_data.special_equipment)
end