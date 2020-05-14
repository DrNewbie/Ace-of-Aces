_G.AceAces = _G.AceAces or {}
AceAces.ModPath = ModPath
AceAces.SavePath = SavePath.."AceAces.txt"
AceAces.Settings = AceAces.Settings or {"None"}

AceAces.Skill_Tweak = {
	["medic_2x"] = {
		upgrades = {
			"doctor_bag_amount_increase2"
		}
	},
	["juggernaut"] = {
		upgrades = {
			"player_armor_multiplier_2"
		}
	},
	["feign_death"] = {
		upgrades = {
			"player_cheat_death_chance_4"
		}
	},
	["bandoliers"] = {
		upgrades = {
			"player_regain_throwable_from_ammo_2"
		}
	},
	["prison_wife"] = {
		upgrades = {
			"player_headshot_regen_armor_bonus_3",
			"player_headshot_regen_armor_cooldown_reduce"
		}
	},
	["inspire"] = {
		upgrades = {
			"player_far_long_dis_revive"
		}
	},
	["insulation"] = {
		upgrades = {
			"player_electro_boom",
			"player_taser_malfunction_2"
		}
	},
	["body_expertise"] = {
		upgrades = {
			"weapon_head_shot_add_free"
		}
	},
	["oppressor"] = {
		upgrades = {
			"player_armor_regen_time_mul_2"
		}
	},
	["scavenging"] = {
		upgrades = {
			"player_increased_pickup_area_2"
		}
	},
	["combat_medic"] = {
		upgrades = {
			"player_revive_damage_reduction_2"
		}
	},
	["stockholm_syndrome"] = {
		upgrades = {
			"player_civilian_reviver",
			"player_super_syndrome_2",
			"player_recharge_super_syndrome"
		}
	},
	["jack_of_all_trades"] = {
		upgrades = {
			"player_second_deployable_normal"
		}
	},
	["fire_trap"] = {
		upgrades = {
			"trip_mine_fire_trap_3"
		}
	},
	["black_marketeer"] = {
		upgrades = {
			"player_hostage_health_regen_addend_3"
		}
	},
	["martial_arts"] = {
		upgrades = {
			"player_run_and_punch"
		}
	},
	["drop_soap"] = {
		upgrades = {
			"player_counter_strike_spooc_boom"
		}
	},
	["nine_lives"] = {
		upgrades = {
			"player_bleed_out_health_multiplier_god"
		}
	},
	["trigger_happy"] = {
		upgrades = {
			"pistol_stacking_hit_damage_multiplier_3"
		}
	},
	["expert_handling"] = {
		upgrades = {
			"pistol_reload_speed_bonus_1",
			"pistol_stacked_accuracy_bonus_2"
		}
	},
	["dance_instructor"] = {
		upgrades = {
			"pistol_magazine_capacity_multiplier_1"
		}
	},
	["equilibrium"] = {
		upgrades = {
			"pistol_spread_index_addend_2"
		}
	},
	["ammo_2x"] = {
		upgrades = {
			"player_take_less_from_ammo_bag"
		}
	},
	["shotgun_cqb"] = {
		upgrades = {
			"weapon_put_that_in_faster"
		}
	},
	["jail_workout"] = {
		upgrades = {
			"player_mask_off_movement"
		}
	},
	["second_chances"] = {
		upgrades = {
			"player_pick_lock_easy_speed_multiplier_2",
			"player_pick_lock_so_hard"
		}
	},
	["engineering"] = {
		upgrades = {
			"sentry_gun_dead_take_up"
		}
	},
	["tower_defense"] = {
		upgrades = {
			"sentry_gun_explode_arrow"
		}
	},
	["sentry_targeting_package"] = {
		upgrades = {
			"sentry_gun_extra_ammo_multiplier_2"
		}
	},
	["up_you_go"] = {
		upgrades = {
			"player_temp_health_regen_1"
		}
	},
	["running_from_death"] = {
		upgrades = {
			"player_temp_increased_dodge_1"
		}
	},
	["single_shot_ammo_return"] = {
		upgrades = {
			"snp_graze_taser_effect"
		}
	},
	["spotter_teamwork"] = {
		upgrades = {
			"head_shot_ammo_return_3",
			"head_shot_ammo_return_AA"
		}
	},
	["joker"] = {
		upgrades = {
			"joker_temp_invulnerable"
		}
	},
	["control_freak"] = {
		upgrades = {
			"joker_give_armor"
		}
	},
	["portable_saw"] = {
		upgrades = {
			"saw_extra_ammo_multiplier_2"
		}
	},	
	["ammo_reservoir"] = {
		upgrades = {
			"temporary_no_ammo_cost_repeat"
		}
	},
	["jail_diet"] = {
		upgrades = {
			"player_stamina_to_dodge_1"
		}
	},
	["underdog"] = {
		upgrades = {
			"underdog_zed_time_1"
		}
	},
	["frenzy"] = {
		upgrades = {
			"player_health_damage_reduction_forced",
			"player_max_health_reduction_forced",
			"player_health_multiplier_2"
		}
	},
	["messiah"] = {
		upgrades = {
			"player_messiah_revive_from_bleed_out_3"
		}
	},
	["sprinter"] = {
		upgrades = {
			"player_crouch_dodge_chance_3",
			"player_vehicle_dodge_chance_1",
		}
	},
	["far_away"] = {
		upgrades = {
			"shotgun_no_falloff",
			"shotgun_more_bullet"
		}
	}
}

function AceAces:Save()
	local _file = io.open(self.SavePath, "w+")
	if _file then
		_file:write(json.encode(self.Settings))
		_file:close()
	end
end

function AceAces:Load()
	local _file = io.open(self.SavePath, "r")
	if _file then
		self.Settings = json.decode(tostring(_file:read("*all")))
		_file:close()
	else
		self.Settings = {"None"}
		self:Save()
	end
end

AceAces:Load()
