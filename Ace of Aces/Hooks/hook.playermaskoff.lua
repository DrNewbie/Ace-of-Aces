local mod_ids = Idstring('AA:Jump and Duck in Casing Mode'):key()

Hooks:PostHook(PlayerMaskOff, "_check_action_jump", 'F_'..Idstring("PostHook:PlayerMaskOff:_check_action_jump:"..mod_ids):key(), function(self, t, input)
	if managers.player:has_category_upgrade("player", "mask_off_movement") and input.btn_jump_press then
		PlayerStandard._check_action_jump(self, t, input)
	end
end)

Hooks:PostHook(PlayerMaskOff, "_check_action_duck", 'F_'..Idstring("PostHook:PlayerMaskOff:_check_action_duck:"..mod_ids):key(), function(self, t, input)
	if managers.player:has_category_upgrade("player", "mask_off_movement") and (input.btn_duck_release or input.btn_duck_press) then
		PlayerStandard._check_action_duck(self, t, input)
	end
end)

Hooks:PostHook(PlayerMaskOff, "_check_action_interact", 'F_'..Idstring("PostHook:PlayerMaskOff:_check_action_interact:"..mod_ids):key(), function(self, ...)
	if managers.player:has_category_upgrade("player", "mask_off_movement") then 
		return true
	else
		return PlayerMaskOff.super._check_action_interact(self, ...)
	end
end)

Hooks:PostHook(PlayerMaskOff, "_upd_attention", 'F_'..Idstring("PostHook:PlayerMaskOff:_upd_attention:"..mod_ids):key(), function(self)
	if managers.player:has_category_upgrade("player", "mask_off_movement") and self._state_data.ducking then
		PlayerStandard._upd_attention(self)
	end
end)