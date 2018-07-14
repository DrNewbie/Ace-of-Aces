AA_take_ammo = AA_take_ammo or AmmoBagBase._take_ammo

function AmmoBagBase:_take_ammo(...)
	local Ans = AA_take_ammo(self, ...)
	if managers.player:has_category_upgrade("player", "take_less_from_ammo_bag") then
		Ans = Ans * managers.player:upgrade_value("player", "take_less_from_ammo_bag", 1)
	end
	return Ans
end

Hooks:PostHook(AmmoBagBase, "update", "AA_AmmoBagBase_Update", function(self, unit, t, dt)
	if self._unit and not self._empty and managers.player:has_category_upgrade("player", "no_ammo_cost_repeat") then
		local ply_unit = managers.player:player_unit()
		if ply_unit and mvector3.distance(ply_unit:position(), self._unit:position()) <= 500 then
			local data = managers.player:upgrade_value("player", "no_ammo_cost_repeat") or {0, 0, 0}
			if self._no_ammo_cost_repeat_delay then
				self._no_ammo_cost_repeat_delay = self._no_ammo_cost_repeat_delay - dt
				if self._no_ammo_cost_repeat_delay <= 0 then
					self._no_ammo_cost_repeat_delay = nil
				end
			end
			if not self._no_ammo_cost_repeat_delay and data[1] >= math.random() then
				self._no_ammo_cost_repeat_delay = data[3]
				managers.player:add_to_temporary_property("bullet_storm", data[2], 1)
			end
		end
	end
end)