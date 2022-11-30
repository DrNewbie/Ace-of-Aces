Hooks:PostHook(CopDamage, "damage_simple", "AA_Graze_Taser_Effect", function(self, attack_data)
	if self._dead or self._invulnerable then
	
	else
		if not managers.player:has_category_upgrade("snp", "graze_taser_effect") then
		
		else
			if not attack_data or not attack_data.variant or attack_data.variant ~= "graze" or not attack_data.attacker_unit or not alive(attack_data.attacker_unit) or attack_data.attacker_unit ~= managers.player:player_unit() then
			
			else
				local col_ray = {
					unit = self._unit,
					ray = (attack_data.attacker_unit:position() - self._unit:position()):normalized(),
					position = self._unit:position()
				}
				attack_data.damage = 0
				attack_data.weapon_unit = attack_data.attacker_unit:inventory():equipped_unit()
				attack_data.armor_piercing = true
				attack_data.col_ray = col_ray
				attack_data.attack_dir = col_ray.ray
				attack_data.variant = "heavy"
				self:damage_tase(attack_data)
				if type(self.damage_fire) == "function" then
					self:damage_fire({
						variant = "fire",
						damage = 1,
						weapon_unit = attack_data.weapon_unit,
						attacker_unit = attack_data.attacker_unit,
						col_ray = col_ray,
						armor_piercing = true,
						fire_dot_data = {
							dot_trigger_chance = 100,
							dot_damage = 10,
							dot_length = 8.1,
							dot_trigger_max_distance = 3000,
							dot_tick_period = 0.5
						}
					})
				end
				if type(self.damage_tase) == "function" then
					self:damage_tase({
						damage = 1,
						weapon_unit = attack_data.weapon_unit,
						attacker_unit = attack_data.attacker_unit,
						col_ray = col_ray,
						armor_piercing = true,
						attack_dir = col_ray.ray,
						variant = "heavy"
					})
				end
			end
		end
	end
end)

Hooks:PostHook(CopDamage, "convert_to_criminal", "AA_joker_temp_invulnerable_init", function(self)
	if managers.player:has_category_upgrade("temporary", "joker_temp_invulnerable") then
		self._is_joker_temp_invulnerable = true
		self._time_joker_temp_invulnerable = nil
	end
end)

Hooks:PostHook(CopDamage, "_apply_damage_to_health", "AA_joker_temp_invulnerable_run", function(self, damage)
	if self._is_joker_temp_invulnerable and not self._time_joker_temp_invulnerable then
		self._time_joker_temp_invulnerable = managers.player:upgrade_value("temporary", "joker_temp_invulnerable", 0)
		self:set_invulnerable(true)
	end
end)