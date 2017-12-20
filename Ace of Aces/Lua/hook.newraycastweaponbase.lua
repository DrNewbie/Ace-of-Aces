local AA_head_shot_add_free = NewRaycastWeaponBase.get_add_head_shot_mul

function NewRaycastWeaponBase:get_add_head_shot_mul()
	if managers.player:has_category_upgrade("weapon", "head_shot_add_free") then
		return managers.player:upgrade_value("weapon", "automatic_head_shot_add", nil)
	end
	return AA_head_shot_add_free(self)
end