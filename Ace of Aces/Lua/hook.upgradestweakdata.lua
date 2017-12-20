Hooks:PostHook(UpgradesTweakData, "_player_definitions", "AceAces_UpgradesTweakData", function(self)
	self.values.doctor_bag.amount_increase[2] = self.values.doctor_bag.amount_increase[1] + 2
	self.values.player.armor_multiplier[2] = self.values.player.armor_multiplier[1] + 0.5
	self.definitions.player_armor_multiplier_2 = {
		name_id = "menu_player_armor_multiplier",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "armor_multiplier",
			category = "player"
		}
	}
	self.values.player.cheat_death_chance[3] = self.values.player.cheat_death_chance[2] + 0.3
	self.definitions.player_cheat_death_chance_3 = {
		name_id = "menu_player_cheat_death_chance",
		category = "feature",
		upgrade = {
			value = 3,
			upgrade = "cheat_death_chance",
			category = "player"
		}
	}
	self.values.player.regain_throwable_from_ammo[2] = {
		chance = 0.05,
		chance_inc = 1.01,
		special = true
	}
	self.definitions.player_regain_throwable_from_ammo_2 = {
		name_id = "menu_player_regain_throwable_from_ammo",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "regain_throwable_from_ammo",
			category = "player"
		}
	}
	self.values.player.headshot_regen_armor_bonus[3] = self.values.player.headshot_regen_armor_bonus[2] + 2.5
	self.definitions.player_headshot_regen_armor_bonus_3 = {
		name_id = "menu_player_headshot_regen_armor_bonus",
		category = "feature",
		upgrade = {
			value = 3,
			upgrade = "headshot_regen_armor_bonus",
			category = "player"
		}
	}
	self.values.player.headshot_regen_armor_cooldown_reduce = {1}
	self.definitions.player_headshot_regen_armor_cooldown_reduce = {
		name_id = "menu_player_headshot_regen_armor_cooldown_reduce",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "headshot_regen_armor_cooldown_reduce",
			category = "player"
		}
	}
	self.values.player.far_long_dis_revive = {true}
	self.definitions.player_far_long_dis_revive = {
		name_id = "menu_player_far_long_dis_revive",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "far_long_dis_revive",
			category = "player"
		}
	}
	self.values.player.electro_boom = {true}
	self.definitions.player_electro_boom = {
		name_id = "menu_player_electro_boom",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "electro_boom",
			category = "player"
		}
	}
	self.values.player.taser_malfunction[2] = {
		interval = 1,
		chance_to_trigger = 1.0
	}
	self.definitions.player_taser_malfunction_2 = {
		name_id = "menu_player_taser_malf",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "taser_malfunction",
			category = "player"
		}
	}
	self.values.weapon.head_shot_add_free = {true}
	self.definitions.weapon_head_shot_add_free = {
		name_id = "menu_weapon_head_shot_add_free",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "head_shot_add_free",
			category = "weapon"
		}
	}
	self.values.player.armor_regen_time_mul[2] = math.max(self.values.player.armor_regen_time_mul[1] - 0.50, 0.01)
	self.definitions.player_armor_regen_time_mul_2 = {
		name_id = "menu_player_armor_regen_time_mul",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "armor_regen_time_mul",
			category = "player"
		}
	}
	self.values.player.increased_pickup_area[2] = 2.5
	self.definitions.player_increased_pickup_area_2 = {
		name_id = "menu_player_increased_pickup_area",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "increased_pickup_area",
			category = "player"
		}
	}
	self.values.player.revive_damage_reduction[2] = 0.1
	self.definitions.player_revive_damage_reduction_2 = {
		name_id = "menu_player_revive_damage_reduction",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "revive_damage_reduction",
			category = "player"
		}
	}
	self.values.player.super_syndrome[2] = 2
	self.definitions.player_super_syndrome_2 = {
		name_id = "menu_player_super_syndrome",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "super_syndrome",
			category = "player"
		}
	}
	self.values.player.recharge_super_syndrome = {1}
	self.definitions.player_recharge_super_syndrome = {
		name_id = "menu_player_recharge_super_syndrome",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "recharge_super_syndrome",
			category = "player"
		}
	}
	self.values.player.second_deployable_normal = {true}
	self.definitions.player_second_deployable_normal = {
		name_id = "menu_player_second_deployable_normal",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "second_deployable_normal",
			category = "player"
		}
	}
	self.values.trip_mine.fire_trap[3] = {
		self.values.trip_mine.fire_trap[2][1] + 15,
		self.values.trip_mine.fire_trap[2][2] + 0.75
	}
	self.definitions.trip_mine_fire_trap_3 = {
		name_id = "menu_trip_mine_fire_trap",
		category = "feature",
		upgrade = {
			value = 3,
			upgrade = "fire_trap",
			category = "trip_mine"
		}
	}
	self.values.player.head_shot_ammo_return[3] = {
		headshots = 1,
		ammo = 1,
		time = 6
	}
	self.definitions.head_shot_ammo_return_3 = {
		incremental = true,
		name_id = "menu_head_shot_ammo_return_3",
		category = "feature",
		upgrade = {
			value = 3,
			upgrade = "head_shot_ammo_return",
			category = "player"
		}
	}
	self.values.player.hostage_health_regen_addend[3] = 0.090
	self.definitions.player_hostage_health_regen_addend_3 = {
		name_id = "menu_player_hostage_health_regen_addend",
		category = "temporary",
		upgrade = {
			value = 3,
			upgrade = "hostage_health_regen_addend",
			category = "player"
		}
	}
end)