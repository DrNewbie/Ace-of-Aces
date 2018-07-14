Hooks:PostHook(PlayerMovement, "init", "AA_PlayerMovementInit", function(self)
	if managers.player:has_category_upgrade("player", "far_long_dis_revive") and self._rally_skill_data and self._rally_skill_data.range_sq then
		self._rally_skill_data.range_sq = 810000 * 2
	end
end)

AA_on_SPOOCed = AA_on_SPOOCed or PlayerMovement.on_SPOOCed

function PlayerMovement:on_SPOOCed(enemy_unit)
	local Ans = AA_on_SPOOCed(self, enemy_unit)
	if tostring(Ans) == "countered" then
		if managers.player:has_category_upgrade("player", "counter_strike_spooc_boom") then
			managers.explosion:play_sound_and_effects(
				enemy_unit:movement():m_head_pos(),
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
			if enemy_unit:character_damage() and not enemy_unit:character_damage():dead() then
				damage = math.max(enemy_unit:character_damage()._HEALTH_INIT * 0.55, damage)
			end
			managers.explosion:detect_and_give_dmg({
				curve_pow = 5,
				player_damage = 0,
				hit_pos = enemy_unit:movement():m_head_pos(),
				range = 1000,
				collision_slotmask = managers.slot:get_mask("explosion_targets"),
				damage = damage,
				no_raycast_check_characters = false
			})
		end
	end
	return Ans
end