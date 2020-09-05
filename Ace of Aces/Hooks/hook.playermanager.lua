_G.AceAces = _G.AceAces or {}
AceAces.ModPath = ModPath
dofile(AceAces.ModPath.."Base.lua")

function AceAces:Skill_in_AA(skill_id)
	local profile = self:GetCurrentSet()
	self.Settings[profile] = self.Settings[profile] or {}
	skill_id = tostring(skill_id)
	for _, data in pairs(self.Settings[profile]) do
		if data and type(data.skill_id) == "string" and data.skill_id == skill_id and managers.skilltree:skill_completed(skill_id) then
			return true
		end
	end
	return false
end

function AceAces:Skill_Apply()
	self:Load()
	self.Skill_Tweak_ids = {}
	for skill_id, data in pairs(self.Skill_Tweak) do
		for _, upgrade in pairs(data.upgrades) do
			local upgrade_data = tweak_data.upgrades.definitions[upgrade] and tweak_data.upgrades.definitions[upgrade].upgrade
			if upgrade_data then
				self.Skill_Tweak_ids[upgrade_data.upgrade] = skill_id
				managers.upgrades:unaquire(upgrade, UpgradesManager.AQUIRE_STRINGS[1])
			else
				log("[AA]: No 'upgrade_data'? \t"..tostring(skill_id).."\t"..tostring(upgrade))
			end
		end
	end
	local profile = self:GetCurrentSet()
	self.Settings[profile] = self.Settings[profile] or {}
	for _, data_save in pairs(self.Settings[profile]) do
		if self:Skill_in_AA(data_save.skill_id) then
			if type(self.Skill_Tweak[data_save.skill_id]) == "table" and type(self.Skill_Tweak[data_save.skill_id].upgrades) == "table" then
				for _, upgrade in pairs(self.Skill_Tweak[data_save.skill_id].upgrades) do
					managers.upgrades:aquire(upgrade, false, UpgradesManager.AQUIRE_STRINGS[1])
				end
			end
		end
	end
end

Hooks:PreHook(PlayerManager, "aquire_default_upgrades", "AceAces_GiveSkill", function(self)
	AceAces:Skill_Apply()
end)

Hooks:PostHook(PlayerManager, "aquire_upgrade", "AceAces_GiveSkillCheckAgain", function(self, upgrade_data)
	if upgrade_data.category == "player" and upgrade_data.upgrade == "extra_ammo_multiplier" then
		--Some skill get remove cause bad coding.	
	else
		if upgrade_data.upgrade and AceAces.Skill_Tweak_ids and AceAces.Skill_Tweak_ids[upgrade_data.upgrade] then
			if not managers.skilltree:skill_completed(AceAces.Skill_Tweak_ids[upgrade_data.upgrade]) then
				self:unaquire_upgrade(upgrade_data)
			end
		end
	end
end)

Hooks:PostHook(PlayerManager, "on_headshot_dealt", "AceAces_Ply_on_headshot_dealt", function(self)
	local t = Application:time()
	if self._on_headshot_dealt_t and t < self._on_headshot_dealt_t then
		local cdr = self:upgrade_value("player", "headshot_regen_armor_cooldown_reduce", 0)
		if cdr > 0 then
			self._on_headshot_dealt_t = self._on_headshot_dealt_t - cdr
		end
	end
end)

AA_ply_run_and_punch = AA_ply_run_and_punch or PlayerManager.mod_movement_penalty

function PlayerManager:mod_movement_penalty(...)
	local Ans = AA_ply_run_and_punch(self, ...)
	if self:has_category_upgrade("player", "run_and_punch") then		
		if self:current_state() == "standard" and self:player_unit() and self:player_unit():movement() and self:player_unit():movement()._current_state then
			if self:player_unit():movement()._current_state:_is_meleeing() then
				Ans = Ans * self:upgrade_value("player", "run_and_punch", 1)
			end
		end
	end
	return Ans
end

function PlayerManager:_on_recharge_super_syndrome_event()
	if self:has_category_upgrade("player", "super_syndrome") then
		self._super_syndrome_count = self:upgrade_value("player", "super_syndrome")
	else
		self._super_syndrome_count = 0
	end
end

Hooks:PostHook(PlayerManager, "check_skills", "AceAces_Ply_check_skills", function(self)
	if self:has_category_upgrade("player", "recharge_super_syndrome") then
		self._message_system:register(Message.OnDoctorBagUsed, "recharge_super_syndrome", callback(self, self, "_on_recharge_super_syndrome_event"))
	else
		self._message_system:unregister(Message.OnDoctorBagUsed, "recharge_super_syndrome")
	end
end)

function PlayerManager:_add_equipment_normal(params)
	if self:has_equipment(params.equipment) then
		return
	end

	local equipment = params.equipment
	local tweak_data = tweak_data.equipments[equipment]
	local amount = {}
	local amount_digest = {}
	local quantity = tweak_data.quantity

	for i = 1, #quantity, 1 do
		local equipment_name = equipment

		if tweak_data.upgrade_name then
			equipment_name = tweak_data.upgrade_name[i]
		end

		local amt = (quantity[i] or 0) + self:equiptment_upgrade_value(equipment_name, "quantity")
		amt = managers.modifiers:modify_value("PlayerManager:GetEquipmentMaxAmount", amt, params)

		table.insert(amount, amt)
		table.insert(amount_digest, Application:digest_value(0, true))
	end

	local icon = params.icon or tweak_data and tweak_data.icon
	local use_function_name = params.use_function_name or tweak_data and tweak_data.use_function_name
	local use_function = use_function_name or nil

	table.insert(self._equipment.selections, {
		equipment = equipment,
		amount = amount_digest,
		use_function = use_function,
		action_timer = tweak_data.action_timer,
		icon = icon,
		unit = tweak_data.unit,
		on_use_callback = tweak_data.on_use_callback
	})

	self._equipment.selected_index = self._equipment.selected_index or 1

	if #amount > 1 then
		managers.hud:add_item_from_string({
			amount_str = string.format("%01d|%01d", amount[1], amount[2]),
			amount = amount,
			icon = icon
		})
	else
		managers.hud:add_item({
			amount = amount[1],
			icon = icon
		})
	end

	for i = 1, #amount, 1 do
		self:add_equipment_amount(equipment, amount[i], i)
	end
end

Hooks:PreHook(PlayerManager, "_add_equipment", "AceAces_Ply_add_equipment", function(self, params)
	if self:has_category_upgrade("player", "second_deployable_normal") then
		if params and type(params.slot) == "number" and params.slot == 2 then
			self:_add_equipment_normal(params)
			return
		end
	end
end)

AA_ply_upgrade_value = AA_ply_upgrade_value or PlayerManager.upgrade_value

function PlayerManager:upgrade_value(category, upgrade, ...)
	local Ans = AA_ply_upgrade_value(self, category, upgrade, ...)
	if category == "pistol" and upgrade == "reload_speed_multiplier" and self:has_category_upgrade("pistol", "reload_speed_bonus") and self:has_category_upgrade("pistol", "stacked_accuracy_bonus") then	
		local __desperado = math.log(self:get_property("desperado", 1)) * 2
		if __desperado < 0 then
			Ans = Ans + math.abs(__desperado)
		end
	elseif category == "pistol" and upgrade == "magazine_capacity_inc" and self:has_category_upgrade("pistol", "magazine_capacity_multiplier") then	
		local multiplier = self:upgrade_value("pistol", "magazine_capacity_multiplier", 1)
		Ans = math.round(Ans * multiplier)
	elseif category == "player" and upgrade == "health_damage_reduction" and self:has_category_upgrade("player", "health_damage_reduction_forced") then
		Ans = self:upgrade_value("player", "health_damage_reduction_forced", 1)
	elseif category == "player" and upgrade == "max_health_reduction" and self:has_category_upgrade("player", "max_health_reduction_forced") then
		Ans = self:upgrade_value("player", "max_health_reduction_forced", 1)
	elseif category == "player" and upgrade == "movement_speed_multiplier" and self:has_activate_temporary_upgrade("temporary", "underdog_zed_time") then
		Ans = Ans * 2
	elseif category == "player" and upgrade == "armor_multiplier" and self:has_category_upgrade("player", "armor_multiplier_addon") then
		Ans = Ans + self:upgrade_value("player", "armor_multiplier_addon", 0)
	elseif category == "player" and upgrade == "cheat_death_chance" and self:has_category_upgrade("player", "cheat_death_chance_addon") then
		Ans = Ans + self:upgrade_value("player", "cheat_death_chance_addon", 0)
	elseif category == "player" and upgrade == "regain_throwable_from_ammo" and self:has_category_upgrade("player", "regain_throwable_from_ammo_addon") then
		Ans = self:upgrade_value("player", "regain_throwable_from_ammo_addon", Ans)
	elseif category == "player" and upgrade == "headshot_regen_armor_bonus" and self:has_category_upgrade("player", "headshot_regen_armor_bonus_addon") then
		Ans = Ans + self:upgrade_value("player", "headshot_regen_armor_bonus_addon", 0)
	elseif category == "player" and upgrade == "taser_malfunction" and self:has_category_upgrade("player", "taser_malfunction_addon") then
		Ans = self:upgrade_value("player", "taser_malfunction_addon", Ans)
	elseif category == "player" and upgrade == "armor_regen_time_mul" and self:has_category_upgrade("player", "armor_regen_time_mul_addon") then
		Ans = self:upgrade_value("player", "armor_regen_time_mul_addon", Ans)
	elseif category == "player" and upgrade == "increased_pickup_area" and self:has_category_upgrade("player", "increased_pickup_area_addon") then
		Ans = self:upgrade_value("player", "increased_pickup_area_addon", Ans)
	elseif category == "player" and upgrade == "revive_damage_reduction" and self:has_category_upgrade("player", "revive_damage_reduction_addon") then
		Ans = self:upgrade_value("player", "revive_damage_reduction_addon", Ans)
	elseif category == "player" and upgrade == "super_syndrome" and self:has_category_upgrade("player", "super_syndrome_addon") then
		Ans = self:upgrade_value("player", "super_syndrome_addon", Ans)
	elseif category == "trip_mine" and upgrade == "fire_trap" and self:has_category_upgrade("trip_mine", "fire_trap_addon") then
		Ans = self:upgrade_value("trip_mine", "fire_trap_addon", Ans)
	elseif category == "player" and upgrade == "head_shot_ammo_return" and self:has_category_upgrade("player", "head_shot_ammo_return_addon") then
		Ans = self:upgrade_value("player", "head_shot_ammo_return_addon", Ans)
	elseif category == "player" and upgrade == "hostage_health_regen_addend" and self:has_category_upgrade("player", "hostage_health_regen_addend_addon") then
		Ans = self:upgrade_value("player", "hostage_health_regen_addend_addon", Ans)
	elseif category == "player" and upgrade == "bleed_out_health_multiplier" and self:has_category_upgrade("player", "bleed_out_health_multiplier_addon") then
		Ans = self:upgrade_value("player", "bleed_out_health_multiplier_addon", Ans)
	elseif category == "pistol" and upgrade == "stacking_hit_damage_multiplier" and self:has_category_upgrade("pistol", "stacking_hit_damage_multiplier_addon") then
		Ans = self:upgrade_value("pistol", "stacking_hit_damage_multiplier_addon", Ans)
	elseif category == "pistol" and upgrade == "stacked_accuracy_bonus" and self:has_category_upgrade("pistol", "stacked_accuracy_bonus_addon") then
		Ans = self:upgrade_value("pistol", "stacked_accuracy_bonus_addon", Ans)
	elseif category == "pistol" and upgrade == "magazine_capacity_multiplier" and self:has_category_upgrade("pistol", "magazine_capacity_multiplier_addon") then
		Ans = self:upgrade_value("pistol", "magazine_capacity_multiplier_addon", Ans)
	elseif category == "temporary" and upgrade == "berserker_damage_multiplier" and self:has_category_upgrade("temporary", "berserker_damage_multiplier_addon") then
		Ans = self:upgrade_value("temporary", "berserker_damage_multiplier_addon", Ans)
	elseif category == "pistol" and upgrade == "spread_index_addend" and self:has_category_upgrade("pistol", "spread_index_addend_addon") then
		Ans = self:upgrade_value("pistol", "spread_index_addend_addon", Ans)
	elseif category == "player" and upgrade == "pick_lock_easy_speed_multiplier" and self:has_category_upgrade("player", "pick_lock_easy_speed_multiplier_addon") then
		Ans = self:upgrade_value("player", "pick_lock_easy_speed_multiplier_addon", Ans)
	elseif category == "sentry_gun" and upgrade == "extra_ammo_multiplier" and self:has_category_upgrade("sentry_gun", "extra_ammo_multiplier_addon") then
		Ans = self:upgrade_value("sentry_gun", "extra_ammo_multiplier_addon", Ans)
	elseif category == "saw" and upgrade == "extra_ammo_multiplier" and self:has_category_upgrade("saw", "extra_ammo_multiplier_addon") then
		Ans = Ans + self:upgrade_value("saw", "extra_ammo_multiplier_addon", 0)
	elseif category == "player" and upgrade == "messiah_revive_from_bleed_out" and self:has_category_upgrade("player", "messiah_revive_from_bleed_out_addon") then
		Ans = self:upgrade_value("player", "messiah_revive_from_bleed_out_addon", Ans)
	elseif category == "player" and upgrade == "crouch_dodge_chance" and self:has_category_upgrade("player", "crouch_dodge_chance_addon") then
		Ans = self:upgrade_value("player", "crouch_dodge_chance_addon", Ans)
	end
	return Ans
end

AA_ply_skill_dodge_chance = AA_ply_skill_dodge_chance or PlayerManager.skill_dodge_chance

function PlayerManager:skill_dodge_chance(...)
	local Ans = AA_ply_skill_dodge_chance(self, ...)
	if self:has_activate_temporary_upgrade("temporary", "increased_dodge") then
		local upgrade_value = self:upgrade_value("temporary", "increased_dodge") or {0, 0}
		Ans = Ans + upgrade_value[1]
	end
	if self:has_category_upgrade("player", "stamina_to_dodge") then
		if self:local_player() and self:local_player():movement() then
			local prec_stamina = 1 - (self:local_player():movement()._stamina / self:local_player():movement():_max_stamina())
			local muilt = self:upgrade_value("player", "stamina_to_dodge") or 0
			prec_stamina = prec_stamina * muilt
			Ans = Ans + prec_stamina
		end
	end
	if tostring(self._current_state) == "driving" then
		Ans = Ans + self:upgrade_value("player", "vehicle_dodge_chance", 0)
	end
	return Ans
end

Hooks:PostHook(PlayerManager, "activate_temporary_upgrade", "AceAces_Ply_Post_activate_temporary_upgrade", function(self, id, var)
	if id == "temporary" and var == "dmg_dampener_outnumbered_strong" and self:has_category_upgrade("temporary", "underdog_zed_time") and not self:has_activate_temporary_upgrade("temporary", "underdog_zed_time") then
		local data = self:upgrade_value("temporary", "underdog_zed_time") or nil
		if type(data) == "table" and math.random() <= data[1] then
			self:activate_temporary_upgrade("temporary", "underdog_zed_time")
			managers.time_speed:play_effect("underdog_zed_time", data[3])
			HudChallengeNotification.queue(
				"["..managers.localization:to_upper_text("aceaces_zealtime_name").."]",
				managers.localization:text("aceaces_zealtime_desc"),
				"equipment_gasoline"
			)
		end
	end
end)

AA_ply_modify_value = AA_ply_modify_value or PlayerManager.modify_value

function PlayerManager:modify_value(var1, var2, ...)
	if type(var1) == "string" and var1 == "damage_taken" and type(var2) == "number" and self:has_activate_temporary_upgrade("temporary", "underdog_zed_time") then
		local data = self:upgrade_value("temporary", "underdog_zed_time") or nil
		if data then
			var2 = var2 * (1 - data[4])
		end
	end
	return AA_ply_modify_value(self, var1, var2, ...)
end

function PlayerManager:_on_enter_ammo_efficiency_event_AA()
	self:on_ammo_increase(1)
end

Hooks:PreHook(PlayerManager, "_on_enter_ammo_efficiency_event", "AceAces_Ply_Post_on_enter_ammo_efficiency_event", function(self)
	if self:has_category_upgrade("player", "head_shot_ammo_return_AA") and not self._coroutine_mgr:is_running("ammo_efficiency") then
		local weapon_unit = self:equipped_weapon_unit()
		if weapon_unit and weapon_unit:base():fire_mode() == "single" and weapon_unit:base():is_category("smg", "assault_rifle", "snp") then
			self:_on_enter_ammo_efficiency_event_AA()
		end
	end
end)

function PlayerManager:_attempt_alt_pocket_ecm_jammer()
	if type(self.__alt_ecm_jammer) == "table" and type(self.__alt_ecm_jammer.duration) == "number" and type(self.__alt_ecm_jammer.cd) == "number" then
		if managers.groupai and not managers.groupai:state():whisper_mode() then
			managers.hud:activate_teammate_ability_radial(HUDManager.PLAYER_PANEL, self.__alt_ecm_jammer.duration)
			self.__alt_jammer_data = {
				effect = "feedback",
				t = TimerManager:game():time() + self.__alt_ecm_jammer.duration,
				interval = 1.5,
				range = 2500,
				sound = self:player_unit():sound():play("ecm_jammer_puke_signal")
			}
			return true
		end
	end
	return false
end

Hooks:PostHook(PlayerManager, "update", "AceAces_"..Idstring("AceAces_ply_update_alt_pocket_ecm_jammer"):key(), function(self, t ,dt)
	if self:player_unit() and self:player_unit():movement() then
		if type(self.__alt_jammer_data) == "table" then
			if self.__alt_jammer_data.t > t then
				if not self.__alt_jammer_data.dt then
					self.__alt_jammer_data.dt = 0.5
					ECMJammerBase._detect_and_give_dmg(self:player_unit():position(), nil, self:player_unit(), 2500)
				else
					self.__alt_jammer_data.dt = self.__alt_jammer_data.dt - dt
					if self.__alt_jammer_data.dt < 0 then
						self.__alt_jammer_data.dt = nil
					end
				end
			else
				local _ = self.__alt_jammer_data.sound and self.__alt_jammer_data.sound:stop()
				self:player_unit():sound():play("ecm_jammer_puke_signal_stop")
				self.__alt_jammer_data = nil
			end
		else
			if self.__alt_ecm_jammer then
				if self.__alt_ecm_jammer.cd_dt then
					self.__alt_ecm_jammer.cd_dt = self.__alt_ecm_jammer.cd_dt - dt
					if self.__alt_ecm_jammer.cd_dt < 0 then
						self.__alt_ecm_jammer.cd_dt = nil
					end
				else
					self.__alt_ecm_jammer.cd_dt = self.__alt_ecm_jammer.cd
					self:_attempt_alt_pocket_ecm_jammer()
				end
			end
		end
	end
end)

Hooks:PostHook(PlayerManager, "init_finalize", "AceAces_"..Idstring("AceAces_post_init_finalize_alt_pocket_ecm_jammer"):key(), function(self)
	if self:has_category_upgrade("player", "frequently_addition_feedback_ecm") then
		self.__alt_ecm_jammer = self:upgrade_value("player", "frequently_addition_feedback_ecm")
		self.__alt_ecm_jammer.cd_dt = 3
	end
end)

AA_movement_speed_multiplier_swansong = AA_movement_speed_multiplier_swansong or PlayerManager.movement_speed_multiplier

function PlayerManager:movement_speed_multiplier(...)
	local __ans = AA_movement_speed_multiplier_swansong(self, ...)
	if self:has_category_upgrade("temporary", "berserker_damage_multiplier") and self:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier") then
		local __swansong = self:upgrade_value("temporary", "berserker_damage_multiplier")
		if type(__swansong) == "table" and type(__swansong[3]) == "number" then
			__ans = __ans * __swansong[3]
		end
	end
	return __ans
end

Hooks:PostHook(PlayerManager, "update", "AceAces_"..Idstring("AA_marked_enemy_bigger_area"):key(), function(self, t ,dt)
	if self:player_unit() and self:player_unit():movement() and type(self.__marked_enemy_bigger_area) == "table" and type(self.__marked_enemy_bigger_area.area) == "number" and not managers.groupai:state():whisper_mode() then
		if self.__marked_enemy_bigger_area.dt then
			self.__marked_enemy_bigger_area.dt = self.__marked_enemy_bigger_area.dt - dt
			if self.__marked_enemy_bigger_area.dt < 0 then
				self.__marked_enemy_bigger_area.dt = nil
			end
		else
			self.__marked_enemy_bigger_area.dt = 1.5
			for _, u_data in pairs(managers.enemy:all_enemies()) do	
				if u_data and u_data.unit and u_data.unit.contour and alive(u_data.unit) and self:player_unit() ~= u_data.unit then
					local distance = mvector3.distance_sq(self:player_unit():position(), u_data.m_pos)
					if distance < self.__marked_enemy_bigger_area.area then
						local __enemy_type = u_data.unit:base().get_type and u_data.unit:base():get_type()
						local __contour_type = self:get_contour_for_marked_enemy(__enemy_type)
						u_data.unit:contour():add(__contour_type, true)
					end
				end
			end
		end
	end
end)

Hooks:PostHook(PlayerManager, "init_finalize", "AceAces_"..Idstring("AceAces_post_init_finalize_marked_enemy_bigger_area"):key(), function(self)
	if self:has_category_upgrade("player", "marked_enemy_bigger_area") then
		self.__marked_enemy_bigger_area = {
			area = self:upgrade_value("player", "marked_enemy_bigger_area"),
			dt = nil
		}
	end
end)