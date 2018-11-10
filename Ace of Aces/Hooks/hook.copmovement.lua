Hooks:PostHook(CopMovement, "update", "AA_joker_temp_invulnerable_update", function(self, unit, t, dt)
	local udamage = self._unit:character_damage()
	if not udamage:dead() and type(udamage._time_joker_temp_invulnerable) == "number" then
		udamage._time_joker_temp_invulnerable = udamage._time_joker_temp_invulnerable - dt
		if udamage._time_joker_temp_invulnerable < 0 then
			udamage._time_joker_temp_invulnerable = nil
			udamage:set_invulnerable(false)
		end
	end
end)