Hooks:PreHook(PlayerDamage, "revive", "AceAces_PlyDmg_revive", function(self)
	if managers.player:has_category_upgrade("temporary", "increased_dodge") and managers.player:has_inactivate_temporary_upgrade("temporary", "increased_dodge") then
		managers.player:activate_temporary_upgrade("temporary", "increased_dodge")
	end
	if managers.player:has_category_upgrade("temporary", "health_regen") and managers.player:has_inactivate_temporary_upgrade("temporary", "health_regen") then
		managers.player:activate_temporary_upgrade("temporary", "health_regen")
	end
end)

Hooks:PreHook(PlayerDamage, "_upd_health_regen", "AceAces_PlyDmg_upd_health_regen", function(self, t, dt)
	if self._temp_health_regen_timer then
		self._temp_health_regen_timer = self._temp_health_regen_timer - dt
		if self._temp_health_regen_timer <= 0 then
			self._temp_health_regen_timer = nil
		end
	end
	if managers.player:has_activate_temporary_upgrade("temporary", "health_regen") then
		if not self._temp_health_regen_timer then
			if self:get_real_health() < self:_max_health() then
				local upgrade_value = managers.player:upgrade_value("temporary", "health_regen") or {0, 0, 0}
				self:restore_health(upgrade_value[1], false)
				self:restore_health(managers.player:fixed_health_regen(self:health_ratio()), true)
				self._temp_health_regen_timer = upgrade_value[3]
			end
		end
	end
end)