local AA_take_ammo = AmmoBagBase._take_ammo

function AmmoBagBase:_take_ammo(...)
	local Ans = AA_take_ammo(self, ...)
	if managers.player:has_category_upgrade("player", "take_less_from_ammo_bag") then
		Ans = Ans * managers.player:upgrade_value("player", "take_less_from_ammo_bag", 1)
	end
	return Ans
end