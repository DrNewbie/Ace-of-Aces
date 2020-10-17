Hooks:PreHook(PlayerTased, "_on_malfunction_to_taser_event", "AA_electro_boom", function(self)
	if not alive(self._taser_unit) and not alive(self._counter_taser_unit) then
	
	else
		local unit = alive(self._taser_unit) and self._taser_unit or alive(self._counter_taser_unit) and self._counter_taser_unit or nil
		if unit and unit:movement() and managers.player:has_category_upgrade("player", "electro_boom") then
			local __pos = unit:movement():m_head_pos()
			managers.explosion:play_sound_and_effects(
				unit:movement():m_head_pos(),
				math.UP,
				1000,
				{
					sound_event = "grenade_explode",
					effect = "effects/payday2/particles/explosions/grenade_explosion",
					camera_shake_max_mul = 4,
					sound_muffle_effect = true,
					feedback_range = 2000
				}
			)
			local damage = 10
			if unit:character_damage() and not unit:character_damage():dead() then
				damage = math.max(unit:character_damage()._HEALTH_INIT * 0.55, damage)
			end
			managers.explosion:detect_and_give_dmg({
				curve_pow = 5,
				player_damage = 0,
				hit_pos = unit:movement():m_head_pos(),
				range = 1000,
				collision_slotmask = managers.slot:get_mask("explosion_targets"),
				damage = damage,
				no_raycast_check_characters = false
			})
			for u_key, u_data in pairs(managers.enemy:all_enemies()) do
				if u_data.unit and alive(u_data.unit) and u_data.unit:character_damage() and u_data.unit:character_damage().damage_fire and mvector3.distance(u_data.unit:position(), __pos) <= 3000 then
					managers.fire:add_doted_enemy(
						u_data.unit, 
						TimerManager:game():time(), 
						self._unit:inventory():equipped_unit(),
						9.1, 
						3, 
						self._unit,
						true
					)
				end
			end
		end
	end
end)