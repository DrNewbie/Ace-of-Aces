local old_take = FirstAidKitBase.take

function FirstAidKitBase:take(unit, ...)
	if self._empty then
		return
	elseif managers.player:has_category_upgrade("player", "aa_overheal_bonus") then
		if type(unit:character_damage().active_aa_overheal_bonus) == "function" then
			unit:character_damage():active_aa_overheal_bonus()
		end
	end
	return old_take(self, unit, ...)
end