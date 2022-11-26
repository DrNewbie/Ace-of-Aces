Hooks:PostHook(PlayerDamage, "revive", "AceAces_PlyDmg_revive", function(self)
	if managers.player:has_category_upgrade("temporary", "increased_dodge") and managers.player:has_inactivate_temporary_upgrade("temporary", "increased_dodge") then
		managers.player:activate_temporary_upgrade("temporary", "increased_dodge")
	end
	if managers.player:has_category_upgrade("temporary", "health_regen") and managers.player:has_inactivate_temporary_upgrade("temporary", "health_regen") then
		managers.player:activate_temporary_upgrade("temporary", "health_regen")
	end
end)

Hooks:PostHook(PlayerDamage, "_upd_health_regen", "AceAces_PlyDmg_upd_health_regen", function(self, t, dt)
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

AA_plydmg_raw_max_armor = AA_plydmg_raw_max_armor or PlayerDamage._raw_max_armor
function PlayerDamage:_raw_max_armor(...)
	local Ans = AA_plydmg_raw_max_armor(self, ...)
	if managers.player:has_category_upgrade("temporary", "joker_give_armor") then
		local upgrade_value = managers.player:upgrade_value("temporary", "joker_give_armor") or {0, 0}
		local joker_count = math.min(managers.groupai:state():get_amount_enemies_converted_to_criminals(), upgrade_value[2])
		local buff = 1 + upgrade_value[1] * joker_count
		Ans = Ans * buff
	end
	return Ans
end

AA_plydmg_raw_max_health = AA_plydmg_raw_max_health or PlayerDamage._raw_max_health

function PlayerDamage:_raw_max_health(...)
	local Ans = AA_plydmg_raw_max_health(self, ...)
	if self.__aa_overheal_bonus and self.__aa_overheal_bonus[3] then
		Ans = Ans * self.__aa_overheal_bonus[3]
	end
	return Ans
end

function PlayerDamage:active_aa_overheal_bonus()
	if managers.player:has_category_upgrade("player", "aa_overheal_bonus") then
		self.__aa_overheal_bonus = managers.player:upgrade_value("player", "aa_overheal_bonus") or {0, 0, 0, 0}
		self.__aa_overheal_bonus[3] = self.__aa_overheal_bonus[1]
		self.__aa_overheal_bonus[4] = self.__aa_overheal_bonus[2]
	end
	return
end

Hooks:PostHook(PlayerDamage, "update", "AceAces_PlyDmg_OverHealBouns", function(self, unit, t, dt, ...)
	if type(self.__aa_overheal_bonus) == "table" then
		self.__aa_overheal_bonus[4] = self.__aa_overheal_bonus[4] - dt
		self.__aa_overheal_bonus[3] = self.__aa_overheal_bonus[1] * (self.__aa_overheal_bonus[4]/self.__aa_overheal_bonus[2])
		if self.__aa_overheal_bonus[3] <= 0 then
			self.__aa_overheal_bonus = nil
		else
			self:set_health(self:get_real_health())
		end
	end
end)