Hooks:PreHook(AmmoClip, "_pickup", "AceAces_"..Idstring("AceAces_post_pickup_regain_throwable_from_ammo"):key(), function(self)
	if not self._picked_up and not self.__AA_picked_up and self._ammo_box then
		local player = managers.player:local_player()
		local player_manager = managers.player
		if not player_manager or not alive(player) or not player:character_damage() or player:character_damage():is_downed() or player:character_damage():dead() or not player_manager:has_category_upgrade("player", "regain_throwable_from_ammo") then
		
		else
			local inventory = player:inventory()
			local __is_okay
			for _, weapon in pairs(inventory:available_selections()) do
				if not self._weapon_category or self._weapon_category == weapon.unit:base():weapon_tweak_data().categories[1] then
					if type(weapon) == "table" and weapon.unit and not weapon.unit:base():ammo_full() then
						__is_okay = true
						break
					end
				end
			end
			if __is_okay then
				self.__AA_picked_up = true
				local __AA_data = managers.player:upgrade_value("player", "regain_throwable_from_ammo", nil)
				if __AA_data and __AA_data.special then
					local __chance = __AA_data.chance + __AA_data.special
					local __random = math.random()
					if __random < __chance then
						for id, weapon in pairs(inventory:available_selections()) do
							local weapon_base = weapon.unit:base()
							if not weapon_base:ammo_full() and weapon_base._ammo_pickup[2] == 0 then
								if not table.contains(tweak_data.weapon[weapon_base._name_id].categories, "saw") then
									weapon_base:add_ammo_to_pool(1, id)
								else
									weapon_base:add_ammo_to_pool(50, id)
								end
							end
						end
					end
				end
			end
		end
	end
end)