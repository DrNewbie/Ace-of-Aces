Hooks:PostHook(CopDamage, "damage_simple", "AA_Graze_Taser_Effect", function(self, attack_data)
	if self._dead or self._invulnerable then
		return
	end
	if not managers.player:has_category_upgrade("snp", "graze_taser_effect") then
		return
	end
	if not attack_data or not attack_data.variant or attack_data.variant ~= "graze" or not attack_data.attacker_unit or not alive(attack_data.attacker_unit) or attack_data.attacker_unit ~= managers.player:player_unit() then
		return
	end
	local col_ray = {
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
end)