function ArrowBase:set_weapon_unit(weapon_unit)
	ArrowBase.super.set_weapon_unit(self, weapon_unit)

	self._weapon_damage_mult = weapon_unit and weapon_unit:base().projectile_damage_multiplier and weapon_unit:base():projectile_damage_multiplier() or 1
	self._weapon_charge_value = weapon_unit and weapon_unit:base().projectile_charge_value and weapon_unit:base():projectile_charge_value() or 1
	self._weapon_speed_mult = weapon_unit and weapon_unit:base().projectile_speed_multiplier and weapon_unit:base():projectile_speed_multiplier() or 1
	self._weapon_charge_fail = weapon_unit and weapon_unit:base().charge_fail and weapon_unit:base():charge_fail() or false

	if not self._weapon_charge_fail then
		self:add_trail_effect()
	end
end