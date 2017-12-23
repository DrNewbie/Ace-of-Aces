local AA_MaskOff_check_action_jump = PlayerMaskOff._check_action_jump
local AA_MaskOff_check_action_duck = PlayerMaskOff._check_action_duck

function PlayerMaskOff:_check_action_jump(t, input)
	if input.btn_jump_press then
		if managers.player:has_category_upgrade("player", "mask_off_movement") then
			PlayerStandard._check_action_jump(self, t, input)
			return
		end
		AA_MaskOff_check_action_jump(self, t, input)
	end
end

function PlayerMaskOff:_check_action_duck(t, input)
	if input.btn_duck_press then
		if managers.player:has_category_upgrade("player", "mask_off_movement") then
			if not self._state_data.ducking then
				PlayerStandard._start_action_ducking(self, t)
			elseif self._state_data.ducking then
				PlayerStandard._end_action_ducking(self, t)
			end
			return
		end
		AA_MaskOff_check_action_duck(self, t, input)
	end
end

local AceAces_MaskOff = PlayerMaskOff._update_check_actions

function PlayerMaskOff:_update_check_actions(t, dt)
	if not managers.player:has_category_upgrade("player", "mask_off_movement") then
		AceAces_MaskOff(self, t, dt)
	else
		local input = self:_get_input(t, dt)
		self._stick_move = self._controller:get_input_axis("move")

		if mvector3.length(self._stick_move) < 0.1 or self:_interacting() then
			self._move_dir = nil
		else
			self._move_dir = mvector3.copy(self._stick_move)
			local cam_flat_rot = Rotation(self._cam_fwd_flat, math.UP)

			mvector3.rotate_with(self._move_dir, cam_flat_rot)
		end

		self:_update_interaction_timers(t)
		self:_update_start_standard_timers(t)

		if input.btn_stats_screen_press then
			self._unit:base():set_stats_screen_visible(true)
		elseif input.btn_stats_screen_release then
			self._unit:base():set_stats_screen_visible(false)
		end

		self:_update_foley(t, input)

		local new_action = nil
		new_action = new_action or self:_check_use_item(t, input)
		new_action = new_action or self:_check_action_interact(t, input)

		self:_check_action_jump(t, input)
		self:_check_action_duck(t, input)
		self:_check_action_run(t, input)
		self:_check_action_change_equipment(t, input)
	end
end