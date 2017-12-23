local AA_head_shot_add_free = NewRaycastWeaponBase.get_add_head_shot_mul

function NewRaycastWeaponBase:get_add_head_shot_mul()
	if managers.player:has_category_upgrade("weapon", "head_shot_add_free") then
		return managers.player:upgrade_value("weapon", "automatic_head_shot_add", nil)
	end
	return AA_head_shot_add_free(self)
end

local AA_reload_speed_multiplier = NewRaycastWeaponBase.reload_speed_multiplier

function NewRaycastWeaponBase:reload_speed_multiplier()
	local multiplier = AA_reload_speed_multiplier(self)
	if self._use_shotgun_reload and managers.player:has_category_upgrade("weapon", "put_that_in_faster") then
		multiplier = multiplier + 1 - managers.player:upgrade_value("weapon", "put_that_in_faster", 1)
	end
	return multiplier
end