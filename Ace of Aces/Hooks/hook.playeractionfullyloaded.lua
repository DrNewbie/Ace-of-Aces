local function on_ammo_pickup(unit, pickup_chance, increase)
	local gained_throwable = false
	local chance = pickup_chance
	if unit == managers.player:player_unit() then
		local random = math.random()
		if random < chance then
			gained_throwable = true
			managers.player:add_grenade_amount(1, true)
			--AA skill
			--bandoliers, player_regain_throwable_from_ammo_2
			local data = managers.player:upgrade_value("player", "regain_throwable_from_ammo", nil)
			if data and data.special then
				local inventory = managers.player:player_unit():inventory()
				if inventory then
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
		else
			chance = chance * increase
		end
	end
	return gained_throwable, chance
end

PlayerAction.FullyLoaded = {
	Priority = 1,
	Function = function (player_manager, pickup_chance, increase)
		local co = coroutine.running()
		local gained_throwable = false
		local chance = pickup_chance
		local function on_ammo_pickup_message(unit)
			gained_throwable, chance = on_ammo_pickup(unit, chance, increase)
		end
		player_manager:register_message(Message.OnAmmoPickup, co, on_ammo_pickup_message)
		player_manager:register_message(Message.OnAmmoPickup, co, on_ammo_pickup)
		while not gained_throwable do
			coroutine.yield(co)
		end
		player_manager:unregister_message(Message.OnAmmoPickup, co)
	end
}