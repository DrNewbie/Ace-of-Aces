local AA_SentryGunDamage_die = SentryGunDamage.die
function SentryGunDamage:die(...)
	if managers.player:has_category_upgrade("sentry_gun", "dead_take_up") then
		self._health = 0
		self._dead = true
	else
		AA_SentryGunDamage_die(self, ...)
	end
end