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
	self.values.player.cheat_death_chance[4] = self.values.player.cheat_death_chance[2] + 0.3
	self.definitions.player_cheat_death_chance_4 = {
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
		time = 0.25
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
	self.values.player.head_shot_ammo_return_AA = {true}
	self.definitions.head_shot_ammo_return_AA = {
		incremental = true,
		name_id = "menu_head_shot_ammo_return_AA",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "head_shot_ammo_return_AA",
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
	self.values.player.run_and_punch = {2.0}
	self.definitions.player_run_and_punch = {
		name_id = "menu_player_run_and_punch",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "run_and_punch",
			category = "player"
		}
	}
	self.values.player.counter_strike_spooc_boom = {true}
	self.definitions.player_counter_strike_spooc_boom = {
		name_id = "menu_player_counter_strike_spooc_boom",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "counter_strike_spooc_boom",
			category = "player"
		}
	}
	self.values.player.bleed_out_health_multiplier[2] = 91.01
	self.definitions.player_bleed_out_health_multiplier_god = {
		name_id = "menu_player_bleed_out_health_multiplier_god",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "bleed_out_health_multiplier",
			category = "player"
		}
	}
	self.values.pistol.stacking_hit_damage_multiplier[3] = {
		max_stacks = 10,
		max_time = 4,
		damage_bonus = 1.2
	}
	self.definitions.pistol_stacking_hit_damage_multiplier_3 = {
		name_id = "menu_pistol_stacking_hit_damage_multiplier",
		category = "feature",
		upgrade = {
			value = 3,
			upgrade = "stacking_hit_damage_multiplier",
			category = "pistol"
		}
	}
	self.values.pistol.stacked_accuracy_bonus[2] = {
		max_stacks = 8,
		accuracy_bonus = self.values.pistol.stacked_accuracy_bonus[1].accuracy_bonus,
		max_time = self.values.pistol.stacked_accuracy_bonus[1].max_time
	}
	self.definitions.pistol_stacked_accuracy_bonus_2 = {
		name_id = "menu_pistol_stacked_accuracy_bonus",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "stacked_accuracy_bonus",
			category = "pistol"
		}
	}
	self.values.pistol.reload_speed_bonus = {true}
	self.definitions.pistol_reload_speed_bonus_1 = {
		name_id = "menu_pistol_reload_speed_bonus_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "reload_speed_bonus",
			category = "pistol"
		}
	}
	self.values.pistol.stacked_accuracy_bonus[2] = self.values.pistol.stacked_accuracy_bonus[1]
	self.values.pistol.stacked_accuracy_bonus[2].max_stacks = 8
	self.definitions.pistol_stacked_accuracy_bonus_2 = {
		name_id = "menu_pistol_stacked_accuracy_bonus",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "stacked_accuracy_bonus",
			category = "pistol"
		}
	}
	self.values.pistol.magazine_capacity_multiplier = {2}
	self.definitions.pistol_magazine_capacity_multiplier_1 = {
		name_id = "menu_pistol_magazine_capacity_multiplier_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "magazine_capacity_multiplier",
			category = "pistol"
		}
	}
	self.values.pistol.spread_index_addend[2] = 4
	self.definitions.pistol_spread_index_addend_2 = {
		name_id = "menu_pistol_spread_index_addend_2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "spread_index_addend",
			category = "pistol"
		}
	}
	self.values.player.take_less_from_ammo_bag = {0.25}
	self.definitions.player_take_less_from_ammo_bag = {
		name_id = "menu_player_take_less_from_ammo_bag",
		category = "equipment_upgrade",
		upgrade = {
			value = 1,
			upgrade = "take_less_from_ammo_bag",
			category = "player"
		}
	}
	self.values.weapon.put_that_in_faster = {0.5}
	self.definitions.weapon_put_that_in_faster = {
		name_id = "menu_weapon_put_that_in_faster",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "put_that_in_faster",
			category = "weapon"
		}
	}
	self.values.player.mask_off_movement = {true}
	self.definitions.player_mask_off_movement = {
		name_id = "menu_player_mask_off_movement",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "mask_off_movement",
			category = "player"
		}
	}
	self.values.player.pick_lock_easy_speed_multiplier[2] = 0.25
	self.definitions.player_pick_lock_easy_speed_multiplier_2 = {
		name_id = "menu_player_pick_lock_easy_speed_multiplier",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "pick_lock_easy_speed_multiplier",
			category = "player"
		}
	}
	self.values.player.pick_lock_so_hard = {true}
	self.definitions.player_pick_lock_so_hard = {
		name_id = "menu_player_pick_lock_so_hard",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "pick_lock_so_hard",
			category = "player"
		}
	}
	self.values.sentry_gun.dead_take_up = {true}
	self.definitions.sentry_gun_dead_take_up = {
		name_id = "menu_sentry_gun_dead_take_up",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "dead_take_up",
			category = "sentry_gun"
		}
	}
	self.values.sentry_gun.explode_arrow = {3}
	self.definitions.sentry_gun_explode_arrow = {
		name_id = "menu_sentry_gun_explode_arrow",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "explode_arrow",
			category = "sentry_gun"
		}
	}
	self.values.sentry_gun.extra_ammo_multiplier[2] = 3
	self.definitions.sentry_gun_extra_ammo_multiplier_2 = {
		incremental = true,
		name_id = "menu_sentry_gun_extra_ammo_multiplier",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "extra_ammo_multiplier",
			category = "sentry_gun"
		}
	}
	self.values.temporary.increased_dodge = {{
		0.2,
		10
	}}
	self.definitions.player_temp_increased_dodge_1 = {
		name_id = "player_temp_increased_dodge_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "increased_dodge",
			category = "temporary"
		}
	}
	self.values.temporary.health_regen = {{
		0.5,
		10,
		0.5
	}}
	self.definitions.player_temp_health_regen_1 = {
		name_id = "player_temp_health_regen_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "health_regen",
			category = "temporary"
		}
	}
	self.values.snp.graze_taser_effect = {true}
	self.definitions.snp_graze_taser_effect = {
		name_id = "snp_graze_taser_effect",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "graze_taser_effect",
			category = "snp"
		}
	}
	self.values.temporary.joker_temp_invulnerable = {0.8}
	self.definitions.joker_temp_invulnerable = {
		name_id = "joker_temp_invulnerable",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "joker_temp_invulnerable",
			category = "temporary"
		}
	}
	self.values.temporary.joker_give_armor = {{0.25, 8}}
	self.definitions.joker_give_armor = {
		name_id = "joker_give_armor",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "joker_give_armor",
			category = "temporary"
		}
	}
	self.values.saw.extra_ammo_multiplier[2] = 2.5
	self.definitions.saw_extra_ammo_multiplier_2 = {
		name_id = "saw_extra_ammo_multiplier_2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "extra_ammo_multiplier",
			category = "saw"
		}
	}
	self.values.player.no_ammo_cost_repeat = {{0.3, 3, 5}}
	self.definitions.temporary_no_ammo_cost_repeat = {
		name_id = "temporary_no_ammo_cost_repeat",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "no_ammo_cost_repeat",
			category = "player"
		}
	}
	self.values.player.stamina_to_dodge = {0.15}
	self.definitions.player_stamina_to_dodge_1 = {
		name_id = "player_stamina_to_dodge_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "stamina_to_dodge",
			category = "player"
		}
	}
	self.values.temporary.underdog_zed_time = {
		{
			0.1,
			6,
			{
				sustain = 12,
				timer = "pausable",
				speed = 0.15,
				fade_in = 0.25,
				fade_out = 0.8
			},
			0.33
		}
	}
	self.definitions.underdog_zed_time_1 = {
		name_id = "underdog_zed_time_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "underdog_zed_time",
			category = "temporary"
		}
	}
	--reduce dmg from lose MAX HP
	self.values.player.health_damage_reduction_forced = {
		0.999
	}
	self.definitions.player_health_damage_reduction_forced = {
		name_id = "menu_player_health_damage_reduction_forced",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "health_damage_reduction_forced",
			category = "player"
		}
	}
	--lose MAX HP
	self.values.player.max_health_reduction_forced = {
		1
	}
	self.definitions.player_max_health_reduction_forced = {
		name_id = "menu_player_max_health_reduction_forced",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "max_health_reduction_forced",
			category = "player"
		}
	}
	self.values.player.health_multiplier[2] = 2.5
	self.definitions.player_health_multiplier_2 = {
		name_id = "menu_player_health_multiplier",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "health_multiplier",
			category = "player"
		}
	}
	self.values.player.messiah_revive_from_bleed_out[2] = 2
	self.values.player.messiah_revive_from_bleed_out[3] = 3
	self.definitions.player_messiah_revive_from_bleed_out_3 = {
		name_id = "menu_player_pistol_revive_from_bleed_out",
		category = "feature",
		upgrade = {
			value = 3,
			upgrade = "messiah_revive_from_bleed_out",
			category = "player"
		}
	}
	self.values.player.crouch_dodge_chance[3] = 0.1
	self.definitions.player_crouch_dodge_chance_3 = {
		name_id = "menu_player_crouch_dodge_chance",
		category = "feature",
		upgrade = {
			value = 3,
			upgrade = "crouch_dodge_chance",
			category = "player"
		}
	}
	self.values.player.vehicle_dodge_chance = {
		0.15
	}
	self.definitions.player_vehicle_dodge_chance_1 = {
		name_id = "menu_player_vehicle_dodge_chance",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "vehicle_dodge_chance",
			category = "player"
		}
	}
	self.values.shotgun.shotgun_no_falloff = {
		true
	}
	self.definitions.shotgun_no_falloff = {
		name_id = "menu_shotgun_no_falloff",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "shotgun_no_falloff",
			category = "shotgun"
		}
	}
	self.values.shotgun.shotgun_more_bullet = {
		1
	}
	self.definitions.shotgun_more_bullet = {
		name_id = "menu_shotgun_more_bullet",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "shotgun_more_bullet",
			category = "shotgun"
		}
	}
end)