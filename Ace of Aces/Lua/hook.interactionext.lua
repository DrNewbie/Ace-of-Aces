Hooks:PostHook(ReviveInteractionExt, "interact", "AA_ReviveInteractionExt", function(self, reviving_unit)
	if managers.player:has_category_upgrade("player", "inspire_team_speed_up") and reviving_unit and reviving_unit ~= managers.player:player_unit() then
		local event_listener = reviving_unit:event_listener()
		if event_listener then
			managers.player:send_activate_temporary_team_upgrade_to_peers("temporary", "team_damage_speed_multiplier_received")
		end
	end
end)