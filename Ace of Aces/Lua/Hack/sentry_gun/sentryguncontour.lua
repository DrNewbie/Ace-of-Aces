function SentryGunContour:_on_death_event()
	if managers.player:has_category_upgrade("sentry_gun", "dead_take_up") then
		return
	end
	self:_remove_contour()
end