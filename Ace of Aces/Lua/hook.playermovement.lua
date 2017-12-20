Hooks:PostHook(PlayerMovement, "init", "AA_PlayerMovementInit", function(self)
	if managers.player:has_category_upgrade("player", "far_long_dis_revive") and self._rally_skill_data and self._rally_skill_data.range_sq then
		self._rally_skill_data.range_sq = 810000 * 2
	end
end)