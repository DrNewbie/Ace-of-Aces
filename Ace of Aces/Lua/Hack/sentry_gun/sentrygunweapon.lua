Hooks:PostHook(SentryGunWeapon, "init", "AA_SentryGunWeapon", function(self)
	self._explode_arrow = managers.player:has_category_upgrade("sentry_gun", "explode_arrow") and managers.player:upgrade_value("sentry_gun", "explode_arrow", -1) or 0
	if self._explode_arrow > 0 then
		self._explode_arrow_t = 0
	end
end)

Hooks:PostHook(SentryGunWeapon, "_fire_raycast", "AA_SentryGunWeapon_fire_raycast", function(self, from_pos, direction)
	if self._explode_arrow > 0 then
		local _t = math.round(TimerManager:game():time())
		if _t > self._explode_arrow_t then
			local mvec_from_pos = Vector3()
			local mvec_direction = Vector3()
			mvector3.set(mvec_from_pos, from_pos)
			mvector3.set(mvec_direction, direction)
			mvector3.multiply(mvec_direction, 100)
			mvector3.add(mvec_from_pos, mvec_direction)
			self._explode_arrow_t = _t + self._explode_arrow
			if Network:is_client() then
				local projectile_type_index = tweak_data.blackmarket:get_index_from_projectile_id("long_arrow_exp")
				managers.network:session():send_to_host("request_throw_projectile", projectile_type_index, mvec_from_pos, mvec_direction)
			else
				local unit = ProjectileBase.throw_projectile("long_arrow_exp", mvec_from_pos, mvec_direction, managers.network:session():local_peer():id())
				unit:base():set_weapon_unit(managers.player:equipped_weapon_unit())
			end
		end
	end
end)