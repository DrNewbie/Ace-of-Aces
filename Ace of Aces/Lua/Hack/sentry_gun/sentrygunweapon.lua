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
			local expl_pos = from_pos + Vector3(0, 0, 30)
			local expl_dir = self._to - expl_pos + Vector3(0, 0, -100)
			mvector3.normalize(expl_dir)
			self._explode_arrow_t = _t + self._explode_arrow
			if Network:is_client() then
				local projectile_type_index = tweak_data.blackmarket:get_index_from_projectile_id("long_arrow_exp")
				managers.network:session():send_to_host("request_throw_projectile", projectile_type_index, expl_pos, expl_dir)
			else
				local unit = ProjectileBase.throw_projectile("long_arrow_exp", expl_pos, expl_dir, managers.network:session():local_peer():id())
				unit:base():set_weapon_unit(managers.player:equipped_weapon_unit())
			end
		end
	end
end)